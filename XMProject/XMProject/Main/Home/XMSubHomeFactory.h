//
//  XMSubHomeFactory.h
//  XMProject
//
//  Created by wukexiu on 16/12/25.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,XMSubHomeType)
{
    XMSubHomeTypeRecommend,    // 推荐
    XMSubHomeTypeHot,          // 热门
    XMSubHomeTypeCategory,     // 分类
    XMSubHomeTypeRadio,        // 广播
    XMSubHomeTypeRand,         // 榜单
    XMSubHomeTypeAnchor,       // 主播
    XMSubHomeTypeUnkown,       // 未知
};

@interface XMSubHomeFactory : NSObject

+ (BaseViewController *)subHomeVcWith:(NSString *)identifier;

@end
