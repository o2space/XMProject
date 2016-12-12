//
//  NetResponse.m
//  XMProject
//
//  Created by wukexiu on 16/12/9.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import "NetResponse.h"

@implementation NetResponse

-(id)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        if ([dict objectForKey:@"status"] == nil || [dict objectForKey:@"status"] == [NSNull null]) {
            self.status = [[dict objectForKey:@"code"] integerValue];
        }else{
            self.status = [[dict objectForKey:@"status"] integerValue];
        }
        
        if ([dict objectForKey:@"data"] == nil || [dict objectForKey:@"data"] == [NSNull null]) {
            self.data = [NSDictionary dictionary];
        }else{
            self.data = [dict objectForKey:@"data"];
        }
        
        if ([dict objectForKey:@"message"] == nil || [dict objectForKey:@"message"] == [NSNull null]) {
            self.message = @"";
        }else{
            self.message = [dict objectForKey:@"message"];
        }
    }
    return self;
}

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"status" : @"code" };
}

@end
