//
//  CatPullView.h
//  TestDemo
//
//  Created by wukexiu on 16/12/13.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatPullView : UIView

@property (assign, nonatomic) float zoom;

- (void)animationIdle:(CGFloat)percent;
- (void)animationPulling:(CGFloat)percent;
- (void)animationRefreshing;
- (void)animationWillRefresh;

@end
