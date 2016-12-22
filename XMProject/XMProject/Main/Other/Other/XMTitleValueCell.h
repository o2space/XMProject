//
//  XMTitleValueCell.h
//  XMProject
//
//  Created by wukexiu on 16/12/21.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTitleValueCell : UITableViewCell

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;
+ (CGFloat)cellHeight;
+ (NSString *)getID;

@end
