//
//  XMLiveRootModel.m
//  XMProject
//
//  Created by wukexiu on 17/1/6.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import "XMLiveRootModel.h"

@implementation XMLiveRootModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"data":@"XMHotRecommendsModel"};
}

@end

@implementation XMLiveModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"liveId":@"id"
             };
}

@end
