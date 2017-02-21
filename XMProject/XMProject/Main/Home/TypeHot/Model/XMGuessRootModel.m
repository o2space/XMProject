//
//  XMGuessRootModel.m
//  XMProject
//
//  Created by wukexiu on 17/1/5.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import "XMGuessRootModel.h"

@implementation XMGuessRootModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMGuessDetailModel"};
}

@end

@implementation XMGuessDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"detailId":@"id"
             };
}

@end
