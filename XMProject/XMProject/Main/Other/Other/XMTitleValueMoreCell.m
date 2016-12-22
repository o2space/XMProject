//
//  XMTitleValueMoreCell.m
//  XMProject
//
//  Created by wukexiu on 16/12/21.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMTitleValueMoreCell.h"

@interface XMTitleValueMoreCell()

@property (strong, nonatomic) UILabel *titleLabel, *valueLabel;

@end

@implementation XMTitleValueMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 7, 100, 30)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            _titleLabel.textColor = XMUIColor(62, 62, 62, 1.0);
            [self.contentView addSubview:_titleLabel];
        }
        if (!_valueLabel) {
            _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, kScreen_Width-(110+16) - 30, 30)];
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
}

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    _titleLabel.text = title;
    _valueLabel.text = value;
}

+ (CGFloat)cellHeight{
    return 44.0;
}
+(NSString *)getID{
    return @"XMTitleValueMoreCellID";
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
