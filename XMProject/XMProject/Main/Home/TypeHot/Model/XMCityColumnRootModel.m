//
//  XMCityColumnRootModel.m
//  XMProject
//
//  Created by wukexiu on 17/1/6.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import "XMCityColumnRootModel.h"

@implementation XMCityColumnRootModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMCityColumnDetailModel"};
}

@end

@implementation XMCityColumnDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"detailId":@"id"
             };
}

@end
