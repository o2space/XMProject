//
//  XMHotRecommendsRootModel.m
//  XMProject
//
//  Created by wukexiu on 17/1/6.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import "XMHotRecommendsRootModel.h"

@implementation XMHotRecommendsRootModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMHotRecommendsModel"};
}

@end

@implementation XMHotRecommendsModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMHotRecommendsDetailModel"};
}

@end

@implementation XMHotRecommendsDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"detailId":@"id"
             };
}

@end
