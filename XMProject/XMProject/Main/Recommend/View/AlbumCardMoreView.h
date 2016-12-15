//
//  AlbumCardMoreView.h
//  thegloballove
//
//  Created by wukexiu on 16/1/8.
//  Copyright © 2016年 biandewen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, AlbumMoreState) {
    /** 普通闲置状态 */
    AlbumMoreStateHide = 1,
    /** 松开就可以进行刷新的状态 */
    AlbumMoreStateMoving,
    /** 正在刷新中的状态 */
    AlbumMoreStateShow
};

@interface AlbumCardMoreView : UIView{
    int currentMaxDisplayedCell;
    int currentMaxDisplayedSection;
}
@property(nonatomic,weak)IBOutlet UIImageView *leftImgShow;
@property(nonatomic,weak)IBOutlet UITableView *moreAlbumTable;
@property(nonatomic,strong) NSMutableArray *moreAlbumData;
@property(assign, nonatomic) AlbumMoreState state;

-(void)showAnimation;
-(void)hideAnimation;
@end
