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
    self.mj_h = MJRefreshHeaderHeight + 18;
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
    
    if (self.state == MJRefreshStateRefreshing) {
        self.alpha = 1.0;
        [self.catGif animationIdle:1.0];
    }
    if (self.state == MJRefreshStateIdle) {
        if (pullingPercent>0 && self.oldState == MJRefreshStateRefreshing) {
            NSLog(@"aaaa:1111111");
            self.alpha = 0.0;
            [self.catGif animationIdle:1];
        }else if (pullingPercent ==0 && self.oldState == MJRefreshStateRefreshing) {
            NSLog(@"aaaa:2222222");
            self.alpha = 0.0;
            [self.catGif animationIdle:0];
            self.oldState = MJRefreshStateIdle;
        }else if (pullingPercent>0){
            NSLog(@"aaaa:3333333");
            self.alpha = 1;
            [self.catGif animationIdle:pullingPercent];
        }else if(pullingPercent == 0){
            self.alpha = 0;
        }
    }
    [super setPullingPercent:pullingPercent];
    NSLog(@"pullingPercent:%f",pullingPercent);
}

- (void)setState:(MJRefreshState)state
{
    //MJRefreshCheckState
    MJRefreshState oldState = self.state;
    if (state == oldState) return;
    if (state == MJRefreshStateIdle && oldState == MJRefreshStateRefreshing) {
        self.alpha = 0.0;
    }
    [super setState:state];
    self.oldState = oldState;
    NSLog(@"refresh oldState:%ld,currState:%ld",self.oldState,state);
    if (state == MJRefreshStateIdle) {

    }else if (state == MJRefreshStatePulling){
        [self.catGif animationPulling:1];
    }else if (state == MJRefreshStateWillRefresh){
        [self.catGif animationWillRefresh];
    }else if (state == MJRefreshStateRefreshing){
        [self.catGif animationRefreshing];
    }
}

@end
