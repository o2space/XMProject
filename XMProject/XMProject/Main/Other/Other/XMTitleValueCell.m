//
//  XMTitleValueCell.m
//  XMProject
//
//  Created by wukexiu on 16/12/21.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMTitleValueCell.h"

@interface XMTitleValueCell()

@property (strong, nonatomic) UILabel *titleLabel, *valueLabel;
@property (strong, nonatomic) NSString *title, *value;

@end

@implementation XMTitleValueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 7, 100, 30)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            _titleLabel.textColor = XMUIColor(62, 62, 62, 1.0);
            [self.contentView addSubview:_titleLabel];
        }
        if (!_valueLabel) {
            _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, kScreen_Width-(120+16), 30)];
            _valueLabel.backgroundColor = [UIColor clearColor];
            _valueLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            _valueLabel.textColor = XMUIColor(62, 62, 62, 0.5);
            _valueLabel.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_valueLabel];
        }
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.text = _title;
    _valueLabel.text = _value;
}

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    self.title = title;
    self.value = value;
}
+ (CGFloat)cellHeight{
    return 44.0;
}
+(NSString *)getID{
    return @"XMTitleValueCellID";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
