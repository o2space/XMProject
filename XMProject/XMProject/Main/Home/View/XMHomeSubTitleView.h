//
//  XMHomeSubTitleView.h
//  XMProject
//
//  Created by wukexiu on 16/12/25.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMHomeSubTitleView;
@protocol XMHomeSubTitleViewDelegate <NSObject>

// 必须实现的方法
//@required

// 可选实现的方法
@optional
- (void)homeSubTitleViewDidSelected:(XMHomeSubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title;

@end

@interface XMHomeSubTitleView : UIView{
    
}

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,weak)id <XMHomeSubTitleViewDelegate> delegate;

-(void)jump2Show:(NSInteger)index;
@end
