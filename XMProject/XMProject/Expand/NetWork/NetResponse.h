//
//  NetResponse.h
//  XMProject
//
//  Created by wukexiu on 16/12/9.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,kServerState)
{
    kServerStateSuccess = 1000,//成功
    kServerStateFail    = 1401,//登录失效
    kServerStateHave    = 10013,//已有订单
    kServerStateCertainNo = 9013,//学信网未认证
    kServerStateInfoFail  = 10002,//商品信息填写不完整
};

@interface NetResponse : NSObject

/* response返回的状态  */
@property (nonatomic,assign)kServerState status;

/* 服务端返回回来的data数据  */
@property (nonatomic,strong)id data;

/* 返回的信息  */
@property (nonatomic,strong)NSString * message;


-(id)initWithDict:(NSDictionary *)dict;


@end
