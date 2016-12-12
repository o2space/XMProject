//
//  XMNavigationViewController.h
//  XMProject
//
//  Created by wukexiu on 15/12/28.
//  Copyright (c) 2016年 wukexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMNavigationViewController : UINavigationController

@property (nonatomic, copy) void (^didOnNavigationCloseBlock)();

@end
