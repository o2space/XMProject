//
//  NSString+Extension.h
//  thegloballove
//
//  Created by wukexiu on 15/8/14.
//  Copyright (c) 2015年 kimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
- (NSString *)emotionMonkeyName;
@end
