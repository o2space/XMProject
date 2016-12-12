//
//  XMLoginTool.h
//  XMProject
//
//  Created by wukexiu on 16/2/26.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XMLoginTool : NSObject
@property(nonatomic,assign)BOOL isLogin;
+(XMLoginTool *)sharedLoginTool;
-(void)autoUserLogin;
-(void)toLoginFunctionShow:(BOOL)showLoginView completion:(void(^)())completion;
-(void)didLoginSaveUserInfo:(NSDictionary *)userInfo;
@end
