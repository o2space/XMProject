//
//  XMLoginTool.m
//  XMProject
//
//  Created by wukexiu on 16/2/26.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMLoginTool.h"

@implementation XMLoginTool
+(XMLoginTool *)sharedLoginTool{
    static dispatch_once_t once;
    static XMLoginTool *tool;
    dispatch_once(&once, ^ { tool = [[self alloc] init];tool.isLogin=NO; });
    return tool;
}
-(void)autoUserLogin{
    
    
}
-(void)toLoginFunctionShow:(BOOL)showLoginView completion:(void (^)())completion{
    if (kKeyWindow.rootViewController) {
        
    }
}
-(void)didLoginSaveUserInfo:(NSDictionary *)userInfo{
    
}

@end
