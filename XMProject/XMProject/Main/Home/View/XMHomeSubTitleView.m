//
//  XMHomeSubTitleView.m
//  XMProject
//
//  Created by wukexiu on 16/12/25.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMHomeSubTitleView.h"

@interface XMHomeSubTitleView()

@property(nonatomic,strong)NSMutableArray *subTitleBtnArray;
@property(nonatomic,strong)UIButton *currentSelectedBtn;
@property(nonatomic,strong)UIView *sliderView;

@end

@implementation XMHomeSubTitleView

-(NSArray *)subTitleBtnArray{
    if (!_subTitleBtnArray) {
        _subTitleBtnArray = [NSMutableArray array];
    }
    return _subTitleBtnArray;
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self configSubTitles];
}

-(UIView *)sliderView{
    if (!_sliderView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:0.96 green:0.39 blue:0.26 alpha:1.0];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.size.equalTo(CGSizeMake(30, 2));
            //make.height.mas_equalTo(2);
            //make.width.mas_equalTo(30);
            make.size.mas_equalTo(CGSizeMake(30, 2));
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left).offset(5);
        }];
        _sliderView = view;
    }
    return _sliderView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)jump2Show:(NSInteger)index{
    if (index < 0 || index >= self.subTitleBtnArray.count) {
        return;
    }
    UIButton *btn = self.subTitleBtnArray[index];
    [self selectedAtBtn:btn isFirstStart:NO];
}

-(void)configSubTitles{
    // 每一个titleBtn的宽度
    CGFloat btnW = kScreen_Width/ (CGFloat)[_titleArray count];
    for (NSInteger index = 0; index < [_titleArray count]; index++) {
        NSString *title = _titleArray[index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.38 green:0.39 blue:0.40 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.96 green:0.39 blue:0.26 alpha:1.0] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:0.96 green:0.39 blue:0.26 alpha:1.0] forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(index * btnW, 0, btnW, 38);
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];//[UIFont systemFontOfSize:15];
        btn.adjustsImageWhenDisabled = NO;
        [btn addTarget:self action:@selector(subTitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.subTitleBtnArray addObject:btn];
        [self addSubview:btn];
    }
    UIButton *firstBtn = self.subTitleBtnArray.firstObject;
    if (!firstBtn) {
        return;
    }
    [self selectedAtBtn:firstBtn isFirstStart:YES];
}

-(void)selectedAtBtn:(UIButton *)btn isFirstStart:(BOOL)isFirstStart{
    btn.selected = YES;
    _currentSelectedBtn = btn;
    [self.sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(btn.x + btn.width * 0.5 -15);
    }];
    if (!isFirstStart) {
        [UIView animateWithDuration:0.25 animations:^{
            if (self) {
                [self layoutIfNeeded];
            }
        }];
    }
    [self unSelectedAllBtn:btn];
}

-(void)unSelectedAllBtn:(UIButton *)btn{
    for (UIButton *sbtn in self.subTitleBtnArray) {
        if (sbtn == btn) {
            continue;
        }
        sbtn.selected = NO;
    }
}

-(void)subTitleClick:(UIButton *)btn{
    if (btn == _currentSelectedBtn) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(homeSubTitleViewDidSelected:atIndex:title:)]) {
        [_delegate homeSubTitleViewDidSelected:self atIndex:[self.subTitleBtnArray indexOfObject:btn] title:btn.titleLabel.text?:@""];
    }
    [self selectedAtBtn:btn isFirstStart:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
