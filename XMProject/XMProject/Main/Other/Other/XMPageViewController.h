//
//  XMPageViewController.h
//  XMProject
//
//  Created by wukexiu on 16/12/25.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMPageViewController;
@protocol MXPageViewControllerDelegate <NSObject>

-(void)mxPageCurrentSubControllerIndex:(NSInteger) index pageViewController:(XMPageViewController *)pageViewController;

@end

@interface XMPageViewController : UIViewController

@property(nonatomic,weak)id<MXPageViewControllerDelegate> delegate;

- (instancetype)init:(UIViewController *)superController controllers:(NSArray *)controllers;
- (void)setCurrentSubControllerWith:(NSInteger)index;
@end
