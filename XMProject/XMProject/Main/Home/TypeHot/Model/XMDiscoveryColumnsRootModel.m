//
//  XMDiscoveryColumnsRootModel.m
//  XMProject
//
//  Created by wukexiu on 17/1/5.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import "XMDiscoveryColumnsRootModel.h"

@implementation XMDiscoveryColumnsRootModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMDiscoveryColumnsDetailModel"};
}

@end

@implementation XMDiscoveryColumnsDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"detailId":@"id"
             };
}

@end
