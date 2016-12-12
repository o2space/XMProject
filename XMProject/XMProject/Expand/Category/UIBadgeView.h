

#import <UIKit/UIKit.h>

@interface UIBadgeView : UIView

/**
 * Text that is displayed in the upper-right corner of the item with a surrounding background.
 */
@property (nonatomic, copy) NSString *badgeValue;

+ (UIBadgeView *)viewWithBadgeTip:(NSString *)badgeValue;
+ (CGSize)badgeSizeWithStr:(NSString *)badgeValue font:(UIFont *)font;

- (CGSize)badgeSizeWithStr:(NSString *)badgeValue;

@end
