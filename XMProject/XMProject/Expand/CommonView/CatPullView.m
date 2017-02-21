//
//  CatPullView.m
//  TestDemo
//
//  Created by wukexiu on 16/12/13.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "CatPullView.h"

@interface CatPullView()

@property (strong, nonatomic) CAShapeLayer *bodyLayer;
@property (strong, nonatomic) CAShapeLayer *eyeLeftLayer;
@property (strong, nonatomic) CAShapeLayer *eyeRightLayer;

@end

@implementation CatPullView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.zoom = 0.5;
    if (self) {
        [self.layer addSublayer:self.bodyLayer];
        [self.layer addSublayer:self.eyeLeftLayer];
        [self.layer addSublayer:self.eyeRightLayer];
        
        self.bodyLayer.strokeStart = 0;
        self.bodyLayer.strokeEnd = 0;
    }
    return self;
}

-(CAShapeLayer *)bodyLayer{
    if (!_bodyLayer) {
        _bodyLayer = [CAShapeLayer layer];
        //46x46
        
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:CGPointMake(18*_zoom, 46*_zoom)];
        [bezier addLineToPoint:CGPointMake(18*_zoom, 27*_zoom)];
        [bezier addLineToPoint:CGPointMake(3*_zoom, 27*_zoom)];
        [bezier addLineToPoint:CGPointMake(7*_zoom, 0)];
        [bezier addLineToPoint:CGPointMake(16*_zoom, 10*_zoom)];
        
        [bezier addLineToPoint:CGPointMake((46-16)*_zoom, 10*_zoom)];
        [bezier addLineToPoint:CGPointMake((46-7)*_zoom, 0)];
        [bezier addLineToPoint:CGPointMake((46-3)*_zoom, 27*_zoom)];
        [bezier addLineToPoint:CGPointMake((46-18)*_zoom, 27*_zoom)];
        [bezier addLineToPoint:CGPointMake((46-18)*_zoom, 46*_zoom)];
        
        [bezier addLineToPoint:CGPointMake(11*_zoom, 46*_zoom)];
        [bezier addLineToPoint:CGPointMake(11*_zoom, 36*_zoom)];
        [bezier addLineToPoint:CGPointMake(0, 36*_zoom)];
        
        _bodyLayer.path = bezier.CGPath;
        _bodyLayer.lineWidth = 1.0f;
        _bodyLayer.strokeColor = [UIColor colorWithRed:248.0/255.0f green:100/255.0f blue:66/255.0f alpha:1.0f].CGColor;
        _bodyLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _bodyLayer;
}
-(CAShapeLayer *)eyeLeftLayer{
    if (!_eyeLeftLayer) {
        _eyeLeftLayer = [CAShapeLayer layer];
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:CGPointMake((14-4)*_zoom, 19*_zoom)];
        [bezier addLineToPoint:CGPointMake((21-4)*_zoom, 19*_zoom)];
        
        //[bezier moveToPoint:CGPointMake((14-5)*_zoom, 19*_zoom)];
        //[bezier addLineToPoint:CGPointMake((21+5)*_zoom, 19*_zoom)];
        
        _eyeLeftLayer.path = bezier.CGPath;
        _eyeLeftLayer.lineWidth = 1.0f;
        _eyeLeftLayer.strokeColor = [UIColor colorWithRed:248.0/255.0f green:100/255.0f blue:66/255.0f alpha:1.0f].CGColor;
        _eyeLeftLayer.fillColor = [UIColor clearColor].CGColor;
    }
    _eyeLeftLayer.hidden = YES;
    return _eyeLeftLayer;
}
-(CAShapeLayer *)eyeRightLayer{
    if (!_eyeRightLayer) {
        _eyeRightLayer = [CAShapeLayer layer];
        //46x46
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:CGPointMake((46-21-4)*_zoom, 19*_zoom)];
        [bezier addLineToPoint:CGPointMake((46-14-4)*_zoom, 19*_zoom)];
        //[bezier moveToPoint:CGPointMake((46-21-5)*_zoom, 19*_zoom)];
        //[bezier addLineToPoint:CGPointMake((46-14+5)*_zoom, 19*_zoom)];
        
        _eyeRightLayer.path = bezier.CGPath;
        _eyeRightLayer.lineWidth = 1.0f;
        _eyeRightLayer.strokeColor = [UIColor colorWithRed:248.0/255.0f green:100/255.0f blue:66/255.0f alpha:1.0f].CGColor;
        _eyeRightLayer.fillColor = [UIColor clearColor].CGColor;
    }
    _eyeRightLayer.hidden = YES;
    return _eyeRightLayer;
}

/*
- (void)animationWith:(CGFloat)percent{
    _bodyLayer.strokeStart = 0;
    _bodyLayer.strokeEnd = percent;
}
 */

- (void)animationIdle:(CGFloat)percent{
    _bodyLayer.strokeStart = 0;
    _bodyLayer.strokeEnd = percent;
    
    _eyeLeftLayer.hidden = YES;
    _eyeRightLayer.hidden = YES;
    if (percent == 0) {
        [_eyeLeftLayer removeAllAnimations];
        [_eyeRightLayer removeAllAnimations];
    }else{
    }
    
}

- (void)animationPulling:(CGFloat)percent{
    _bodyLayer.strokeStart = 0;
    _bodyLayer.strokeEnd = 1;
    _eyeLeftLayer.hidden = YES;
    _eyeRightLayer.hidden = YES;
}

- (void)animationRefreshing{
    _bodyLayer.strokeStart = 0;
    _bodyLayer.strokeEnd = 1;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"position"];
    animation.fromValue = [NSValue valueWithCGPoint:_eyeLeftLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_eyeLeftLayer.position.x+8*_zoom, _eyeLeftLayer.position.y)];
    animation.duration = 0.5;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    [_eyeLeftLayer addAnimation:animation forKey:@""];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath: @"position"];
    animation2.fromValue = [NSValue valueWithCGPoint:_eyeRightLayer.position];
    animation2.toValue = [NSValue valueWithCGPoint:CGPointMake(_eyeRightLayer.position.x+8*_zoom, _eyeRightLayer.position.y)];
    animation2.duration = 0.5;
    animation2.repeatCount = HUGE_VALF;
    animation2.autoreverses = YES;
    [_eyeRightLayer addAnimation:animation2 forKey:@""];
    
    _eyeLeftLayer.hidden = NO;
    _eyeRightLayer.hidden = NO;
    
}

- (void)animationWillRefresh{
    _bodyLayer.strokeStart = 0;
    _bodyLayer.strokeEnd = 1;
    _eyeLeftLayer.hidden = NO;
    //_eyeRightLayer.hidden = NO;
}

@end
