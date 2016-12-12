//
//  XMNetworkManager.h
//  XMProject
//
//  Created by wukexiu on 16/12/8.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XMNetworkConnectType) {
    XMNetworkConnectPOST = 0,
    XMNetworkConnectGET,
};

typedef void (^XMCompletioBlock)(NSDictionary *dic, NSURLResponse *response, NSError *error);
typedef void (^XMSuccessBlock)(id responseObject);
typedef void (^XMFailureBlock)(NSError *error);

@interface XMNetworkManager : NSObject

+ (XMNetworkManager *)defaultManager;

/**
 *  get请求
 */
- (void)GETWithURL:(NSString *)strURL parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock;

/**
 * post请求
 */
- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock;

+ (NSDictionary *)getParametersWithDic:(NSDictionary *)params url:(NSString *)url;

@end
