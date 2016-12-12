

#import <UIKit/UIKit.h>
#import "UIBadgeView.h"

@class EaseBlankPageView;

typedef NS_ENUM(NSInteger, BadgePositionType) {
    BadgePositionTypeDefault = 0,
    BadgePositionTypeMiddle
};

@interface UIView (Extension)
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type;
- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point;
- (void)removeBadgePoint;
- (void)removeBadgeTips;

+ (CGRect)frameWithOutNavTab;
+ (CGRect)frameWithOutNav;
+ (CGRect)frameWithOutTab;

+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;


#pragma mark BlankPageView
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(NSString *)blankPageStr hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
- (void)configBlankPage:(NSString *)blankPageStr offestY:(float)offestY hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end


@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
- (void)configWithType:(NSString *)blankPageStr offestY:(float)offestY hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end