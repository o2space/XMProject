//
//  XMSubHomeFactory.m
//  XMProject
//
//  Created by wukexiu on 16/12/25.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMSubHomeFactory.h"

@implementation XMSubHomeFactory

+ (BaseViewController *)subHomeVcWith:(NSString *)identifier{
    XMSubHomeType subHomeType = [XMSubHomeFactory typeFromTitle:identifier];
    BaseViewController *controller;
    switch (subHomeType) {
            case XMSubHomeTypeRecommend:{
                controller = [[BaseViewController alloc] init];
            }
            break;
            case XMSubHomeTypeHot:{
                controller = [[BaseViewController alloc] init];
            }
            break;
            case XMSubHomeTypeCategory:{
                 controller = [[BaseViewController alloc] init];
            }
            break;
            case XMSubHomeTypeRadio:{
                 controller = [[BaseViewController alloc] init];
            }
            break;
            case XMSubHomeTypeRand:{
                 controller = [[BaseViewController alloc] init];
            }
            break;
            case XMSubHomeTypeAnchor:{
                 controller = [[BaseViewController alloc] init];
            }
            break;
            default:{
                 controller = [[BaseViewController alloc] init];
            }
            break;
    }
    
    return controller;
}

+ (XMSubHomeType)typeFromTitle:(NSString *)title{
    if ([title isEqualToString:@"推荐"]) {
        return XMSubHomeTypeRecommend;
    }else if ([title isEqualToString:@"热门"]){
        return XMSubHomeTypeHot;
    }else if ([title isEqualToString:@"分类"]){
        return XMSubHomeTypeCategory;
    }else if ([title isEqualToString:@"广播"]){
        return XMSubHomeTypeRadio;
    }else if ([title isEqualToString:@"榜单"]){
        return XMSubHomeTypeRand;
    }else if ([title isEqualToString:@"主播"]){
        return XMSubHomeTypeAnchor;
    }else{
        return XMSubHomeTypeUnkown;
    }
}

@end
