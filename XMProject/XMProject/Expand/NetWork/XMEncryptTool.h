//
//  EncryptTool.h
//  XMProject
//
//  Created by wukexiu on 16/12/9.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMEncryptTool : NSObject

+ (NSString *)hmacSha256:(NSString *)hashString withKey:(NSString *)key;

+ (NSString *)encryptWithText:(NSString *)sText;
+ (NSString *)decryptWithText:(NSString *)sText;
+ (NSString *)encryptTextWithKey:(NSString *)sText key:(NSString *) key;
+ (NSString *)decryptTextWithKey:(NSString *)sText key:(NSString *) key;
@end
