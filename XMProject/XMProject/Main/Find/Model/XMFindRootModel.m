//
//  XMFindRootModel.m
//  XMProject
//
//  Created by wukexiu on 16/12/22.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMFindRootModel.h"

@implementation XMFindRootModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMFindModel"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"findRootId":@"id"
             };
}
@end

@implementation XMFindModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMFindDetailModel"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"findId":@"id"
             };
}
@end


@implementation XMFindDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"findDetailId":@"id",
             @"categoryId":@"properties.categoryId"
             };
}
@end
