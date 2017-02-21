//
//  XMMemberRootModel.m
//  XMProject
//
//  Created by wukexiu on 17/1/5.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import "XMMemberRootModel.h"

@implementation XMMemberRootModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"XMMemberRootDetailModel"};
}

@end

@implementation XMMemberRootDetailModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"ownerTitle":@"NSString"};
}

@end
