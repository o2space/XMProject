//
//  EncryptTool.m
//  XMProject
//
//  Created by wukexiu on 16/12/9.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMEncryptTool.h"
#import <CommonCrypto/CommonCrypto.h>

#define XM_encryptDesKey   @"8daluqp9xm2kw6zs1hta"

@implementation XMEncryptTool

/**
 *  加密方式,MAC算法: HmacSHA256
 *
 *  @param plaintext 要加密的文本
 *  @param key       秘钥
 *
 *  @return 加密后的字符串
 */
+ (NSString *)hmacSha256:(NSString *)hashString withKey:(NSString *)key
{
    NSData *cData = [hashString dataUsingEncoding:NSUTF8StringEncoding];
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];

    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [cData bytes], [cData length], cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    
    return HMAC;
}

+ (NSString *)encryptWithText:(NSString *)sText
{
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:XM_encryptDesKey];
}

+ (NSString *)decryptWithText:(NSString *)sText
{
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:XM_encryptDesKey];
}

+ (NSString *)encryptTextWithKey:(NSString *)sText key:(NSString *) key
{
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:key];
}

+ (NSString *)decryptTextWithKey:(NSString *)sText key:(NSString *) key
{
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:key];
}

+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *vplainText;  //内存泄漏被注
    size_t plainTextBufferSize;
    
    if (encryptOperation == kCCDecrypt)
    {
        NSData *decryptData =[[NSData alloc] initWithBase64EncodedData:[sText dataUsingEncoding:NSUTF8StringEncoding] options:0];  //[GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [decryptData length];
        vplainText = [decryptData bytes];//内存泄漏被注
    } else {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [encryptData length];
        vplainText = (const void *)[encryptData bytes];//内存泄漏被注
    }
    
    CCCryptorStatus ccStatus;//内存泄漏被注
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    //const void *vkey = (const void *) [DESKEY UTF8String];
    // 24位KEY
    if (key.length != 24) {
        for (int i = 0; key.length <= 24; i++) {
            key = [key stringByAppendingString:@"0"];
        }
    }//kCCOptionPKCS7Padding
    //内存泄漏被注
    ccStatus = CCCrypt(encryptOperation,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       [key UTF8String],
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    /*if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
     else if (ccStatus == kCCParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
     */
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    } else {
        NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; //[GTMBase64 stringByEncodingData:data];
    }
    free(bufferPtr);
    return result;
}

@end
