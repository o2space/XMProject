//
//  XMImageTitleValueCell.m
//  XMProject
//
//  Created by wukexiu on 16/12/21.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMImageTitleValueCell.h"
#import "UIImageView+WebCache.h"

@interface XMImageTitleValueCell()

@property (strong, nonatomic) UILabel *titleLabel, *valueLabel;
@property (strong, nonatomic) UIImageView *titleImage, *valueImage;

@end

@implementation XMImageTitleValueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 100, 50)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
            _titleLabel.textColor = XMUIColor(62, 62, 62, 1.0);
            [self.contentView addSubview:_titleLabel];
        }
        if (!_valueLabel) {
            _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, kScreen_Width - 80 - 25 - 35 - 10, 50)];
            _valueLabel.backgroundColor = [UIColor clearColor];
            _valueLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            _valueLabel.textColor = XMUIColor(62, 62, 62, 0.5);
            _valueLabel.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_valueLabel];
        }
        if (!_titleImage) {
            _titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 25, 50)];
            _titleImage.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:_titleImage];
        }
        if (!_valueImage) {
            _valueImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width - 25 - 35, 0, 25, 50)];
            _valueImage.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:_valueImage];
        }
    }
    return self;
}

- (void)updateTitleImg:(NSString *)titImg TitleLbl:(NSString *)titLabl ValueImg:(NSString *)valueImg ValueLbl:(NSString *)valueLbl{
    self.titleLabel.text = titLabl;
    self.valueLabel.text = valueLbl;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:titImg] placeholderImage:[UIImage imageNamed:@""]];
    if (valueImg != nil && ![valueImg isEqualToString:@""]) {
        [self.valueImage sd_setImageWithURL:[NSURL URLWithString:valueImg] placeholderImage:[UIImage imageNamed:@""]];
        self.valueLabel.width = kScreen_Width - 80 - 25 - 35 - 10;
    }else{
        self.valueLabel.width = kScreen_Width - 80 - 35;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (CGFloat)cellHeight{
    return 50.0;
}

+(NSString *)getID{
    return @"XMImageTitleValueCellID";
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
