//
//  MJRefresCatHeader.m
//  TestDemo
//
//  Created by wukexiu on 16/12/13.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "MJRefresCatHeader.h"
#import "CatPullView.h"

@interface MJRefresCatHeader()

@property(nonatomic,strong)CatPullView *catGif;

@property(nonatomic,assign)MJRefreshState oldState;

@end

@implementation MJRefresCatHeader

#pragma mark - 懒加载
- (CatPullView *)catGif
{
    if (!_catGif) {
        CatPullView *catGif  = [[CatPullView alloc] init];
        [self addSubview:_catGif = catGif];
    }
    return _catGif;
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    self.mj_h = MJRefreshHeaderHeight + 10;
    self.automaticallyChangeAlpha = NO;
}
- (void)placeSubviews
{
    [super placeSubviews];
    if (!self.catGif) return;
    
    self.catGif.frame = CGRectMake(0, 0, 46 * self.catGif.zoom, 46 * self.catGif.zoom);
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.catGif.mj_x = (self.bounds.size.width - 46 * self.catGif.zoom)/2.0;
        self.catGif.mj_y = (self.bounds.size.height - 46 * self.catGif.zoom)/2.0 - 2;
    } else {
        self.catGif.mj_x = (self.bounds.size.width - 46 * self.catGif.zoom )/2.0 - 50;
        self.catGif.mj_y = (self.bounds.size.height - 46 * self.catGif.zoom)/2.0 - 2;
    }
    
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    self.mj_y= self.mj_h + self.scrollView.mj_offsetY;
    [super scrollViewContentOffsetDidChange:change];
}

- (void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
    //NSLog(@"pullingPercent:%lf",pullingPercent);
    if (pullingPercent<0.016) {
        pullingPercent = 0;
    }
    if (self.state == MJRefreshStateIdle) {
        if (pullingPercent>0 && self.oldState != MJRefreshStateRefreshing) {
            self.alpha = 1.0;
            [self.catGif animationIdle:pullingPercent];
        }
        if (pullingPercent == 0.0) {
            self.alpha = 0.0;
            self.oldState = MJRefreshStateIdle;
            [self.catGif animationIdle:0];
        }
        
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    self.oldState = oldState;
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.alpha = 0;
            self.pullingPercent = 1;
            [self.catGif animationIdle:1];
        }
    }else if (state == MJRefreshStatePulling){
        [self.catGif animationPulling:1];
    }else if (state == MJRefreshStateWillRefresh){
        [self.catGif animationWillRefresh];
    }else if (state == MJRefreshStateRefreshing){
        [self.catGif animationRefreshing];
    }
}

@end
