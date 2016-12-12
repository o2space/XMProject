//
//  XMControllerTool.m
//  XMProject
//
//  Created by wukexiu on 15/12/28.
//  Copyright (c) 2016年 wukexiu. All rights reserved.
//

#import "XMControllerTool.h"
#import "NewFeatureViewController.h"
#import "RootTabViewController.h"
#import "XMLoginTool.h"

@implementation XMControllerTool
+(void)chooseRootViewController
{
    //UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    
    NSString *versionKey=@"CurrCFBundleVersion";
    versionKey=(__bridge NSString *)kCFBundleVersionKey;
    
    //从沙盒中取出上次存储的软件版本号（取出用户上次的使用记录）
    NSUserDefaults *defaults=[[NSUserDefaults alloc]init];
    NSString *lastVersion=[defaults objectForKey:versionKey];
    
    //获得当前打开软件的版本号
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[versionKey];
    if ([currentVersion isEqualToString:lastVersion]) {//当前版本号==上次使用的版本号
        //NSLog(@"TabBarViewController");
        kKeyWindow.rootViewController=[[RootTabViewController alloc] init];//[[TGLTabBarViewController alloc] init]; //
        [[XMLoginTool sharedLoginTool] autoUserLogin];
        
    }else{//当前版本号！=上次使用的版本号：显示新版本的特性
        //NSLog(@"NewFeatureViewController");
        kKeyWindow.rootViewController=[[NewFeatureViewController alloc] init];
        [[XMLoginTool sharedLoginTool] autoUserLogin];
        //存储这个使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        //立刻写入
        [defaults synchronize];
    }
    
}
@end
