

#import "UIView+Extension.h"
#define kTagBadgeView  10000
#define kTagBadgePointView  10001
#import <objc/runtime.h>

@implementation UIView (Extension)

-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}



- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type {
    
    if(pointRadius < 1)
        return;
    
    [self removeBadgePoint];
    
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = [UIColor redColor];
    
    switch (type) {
            
        case BadgePositionTypeMiddle:
            badgeView.frame = CGRectMake(0, self.frame.size.height / 2 - pointRadius, 2 * pointRadius, 2 * pointRadius);
            break;
            
        default:
            badgeView.frame = CGRectMake(self.frame.size.width - 2 * pointRadius, 0, 2 * pointRadius, 2 * pointRadius);
            break;
    }
    
    [self addSubview:badgeView];
}

- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point {
    
    if(pointRadius < 1)
        return;
    
    [self removeBadgePoint];
    
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = [UIColor colorWithRed:247/255.0 green:83/255.0 blue:136/255.0 alpha:1.0];
    badgeView.frame = CGRectMake(0, 0, 2 * pointRadius, 2 * pointRadius);
    badgeView.center = point;
    [self addSubview:badgeView];
}

- (void)removeBadgePoint {
    
    for (UIView *subView in self.subviews) {
        
        if(subView.tag == kTagBadgePointView)
            [subView removeFromSuperview];
    }
}

- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
            badgeV.hidden = NO;
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        [badgeV setCenter:center];
    }
}
- (void)addBadgeTip:(NSString *)badgeValue{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        CGSize badgeSize = badgeV.frame.size;
        CGSize selfSize = self.frame.size;
        CGFloat offset = 2.0;
        [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2),
                                      (offset +badgeSize.height/2))];
    }
}
- (void)removeBadgeTips{
    NSArray *subViews =[self subviews];
    if (subViews && [subViews count] > 0) {
        for (UIView *aView in subViews) {
            if (aView.tag == kTagBadgeView && [aView isKindOfClass:[UIBadgeView class]]) {
                aView.hidden = YES;
            }
        }
    }
}


+ (CGRect)frameWithOutNavTab{
    CGRect frame = kScreen_Bounds;
    frame.size.height -= (20+44+49);//减去状态栏、导航栏、Tab栏的高度
    return frame;
}
+ (CGRect)frameWithOutNav{
    CGRect frame = kScreen_Bounds;
    frame.size.height -= (20+44);//减去状态栏、导航栏的高度
    return frame;
}
+ (CGRect)frameWithOutTab{
    CGRect frame = kScreen_Bounds;
    frame.size.height -= (44);//减去Tab栏的高度
    return frame;
}

+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}


static char BlankPageViewKey;

#pragma mark BlankPageView
- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (EaseBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(NSString *)blankPageStr hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            EaseBlankPageView *view = [[EaseBlankPageView alloc] initWithFrame:self.bounds];
            self.blankPageView = view;
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        [self.blankPageView configWithType:blankPageStr offestY:0 hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}
- (void)configBlankPage:(NSString *)blankPageStr offestY:(float)offestY hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            EaseBlankPageView *view = [[EaseBlankPageView alloc] initWithFrame:self.bounds];
            self.blankPageView = view;
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        [self.blankPageView configWithType:blankPageStr offestY:offestY hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
            [aView addSubview:self.blankPageView];
            [aView sendSubviewToBack:self.blankPageView];
        }
    }
    return blankPageContainer;
}
@end

@implementation EaseBlankPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configWithType:(NSString *)blankPageStr offestY:(float)offestY hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    NSLog(@"EaseBlankPageView configWithType");
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    CGFloat maxWidth = CGRectGetWidth(self.bounds), maxHeight = CGRectGetHeight(self.bounds);
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, maxHeight/2.0-50+offestY, maxWidth - 30, 50)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor =[UIColor colorWithRed:29/255.0 green:29/255.0 blue:38/255.0 alpha:0.5]; //[UIColor lightGrayColor]; //(29,29,38,0.5)
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    _reloadButtonBlock = nil;
    if (hasError) {
        //        加载失败
        if (!_reloadButton) {
            _reloadButton = [[UIButton alloc] initWithFrame:CGRectMake((maxWidth -160)/2, CGRectGetMaxY(_tipLabel.frame), 160, 60)];
            [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
            _reloadButton.adjustsImageWhenHighlighted = YES;
            [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_reloadButton];
        }
        _reloadButton.hidden = NO;
        _reloadButtonBlock = block;
        _tipLabel.text = @"数据加载出了点差错\n请按钮重新加载";
    }else{
        //        空白数据
        if (_reloadButton) {
            _reloadButton.hidden = YES;
        }
        //NSString  *tipStr;
        _tipLabel.text = blankPageStr;
    }
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}

@end

