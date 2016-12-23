//
//  NetworkTools.m
//  XMProject
//
//  Created by wukexiu on 16/12/23.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+ (NetworkTools *)shareInstance{
    static NetworkTools *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[NetworkTools alloc] init];
    });
    return instance;
}

- (void)requestDataWithURL:(NSString *)strURL success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock
{
    NSURL *nsurl = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    NSLog(@"url-----%@",[request.URL absoluteString]);
    //设置请求类型
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 输出返回的状态码，请求成功的话为200
            NSInteger responseCode = [self getResponseCode:response];
            NSLog(@">>>>>>GET>>net work 状态码>>>>ResponseCode:%ld",(long)responseCode);
            
            if (error == nil && responseCode == 200) {//请求成功
                NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@">>>>>>GET>>ResponseData:%@",str);
                NSError *e = nil;
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
                if (e == nil) {
                    successBlock(responseObject);
                }else{
                    NSLog(@">>>>>>GET>>net work failed>>>>error: %@", @"json格式解码错误，返回的数据非json格式");
                    //failureBlock(e);
                }
            }else {  //请求失败
            
            NSLog(@">>>>>>GET>>net work failed>>>>responseObject: %@,error: %@", response, error);
            failureBlock(error);
            }
        });
    }];
    [dataTask resume];  //开始请求
}

/* 输出http响应的状态码 */
- (NSInteger)getResponseCode:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    return responseStatusCode;
}
@end
