//
//  AlbumCardMoreCell.m
//  thegloballove
//
//  Created by wukexiu on 16/1/8.
//  Copyright © 2016年 biandewen. All rights reserved.
//

#import "AlbumCardMoreCell.h"

@implementation AlbumCardMoreCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    self.titelLbl.font=[UIFont fontWithName:@"PingFangSC-Regular" size:20];
    self.titelLbl.textColor=XMUIColor(113, 118, 122, 1.0);
    
    self.descLbl.font=[UIFont fontWithName:@"PingFangSC-Light" size:15];
    self.descLbl.textColor=XMUIColor(113, 118, 122, 1.0);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
