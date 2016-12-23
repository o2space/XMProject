//
//  NetworkTools.h
//  XMProject
//
//  Created by wukexiu on 16/12/23.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTools : NSObject

+ (NetworkTools *)shareInstance;
- (void)requestDataWithURL:(NSString *)strURL success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock;
@end
