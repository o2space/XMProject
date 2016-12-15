//
//  AlbumCardMoreView.m
//  thegloballove
//
//  Created by wukexiu on 16/1/8.
//  Copyright © 2016年 biandewen. All rights reserved.
//

#import "AlbumCardMoreView.h"
#import "AlbumCardMoreCell.h"

@interface AlbumCardMoreView()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AlbumCardMoreView

/*
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
*/

-(void)awakeFromNib{
    self.backgroundColor=XMUIColor(227, 228, 231, 0.85);
    self.leftImgShow.image=[UIImage resizedImage:@"albumCardMore_Shadow"];
    
    self.moreAlbumData=[NSMutableArray array];
    self.moreAlbumTable.backgroundColor=[UIColor clearColor];
    self.moreAlbumTable.showsVerticalScrollIndicator=NO;
    self.moreAlbumTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.moreAlbumTable.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.moreAlbumTable.scrollIndicatorInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    self.state=AlbumMoreStateHide;
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
    /*
    if (!self.moreAlbumData) {
        return 0;
    }
    return self.moreAlbumData.count;
     */
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumCardMoreCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AlbumCardMoreCell"];
    if (cell==nil) {
        //cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AlbumCardMoreCell"];
        cell=[[[NSBundle mainBundle] loadNibNamed:@"AlbumCardMoreCell" owner:nil options:nil] lastObject];
    }
    if (indexPath.row%6==0) {
        cell.titelLbl.text=@"亲子";
        cell.descLbl.text=@"你是我的小honey";
    }else if (indexPath.row%6==1){
        cell.titelLbl.text=@"英格兰";
        cell.descLbl.text=@"拾起现代都是遗落的童话";
    }else if (indexPath.row%6==2){
        cell.titelLbl.text=@"Gay蜜";
        cell.descLbl.text=@"第一次看你不大顺眼";
    }else if (indexPath.row%6==3){
        cell.titelLbl.text=@"女性摄影师";
        cell.descLbl.text=@"新势力蓄势待发";
    }else if (indexPath.row%6==4){
        cell.titelLbl.text=@"冰岛";
        cell.descLbl.text=@"走一起去看极光";
    }else if (indexPath.row%6==5){
        cell.titelLbl.text=@"另类婚纱摄影师推荐";
        cell.descLbl.text=@"值得珍藏的幸福时光";
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.frame=CGRectMake(0, 0, tableView.width, 65);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((indexPath.section == 0 && currentMaxDisplayedCell == 0) || indexPath.section > currentMaxDisplayedSection){
        currentMaxDisplayedCell=-1;
    }
    if (indexPath.section >= currentMaxDisplayedSection && indexPath.row > currentMaxDisplayedCell){
        
        cell.x=kScreen_Width/2;
        //首尾式动画
        [UIView beginAnimations:nil context:nil];
        //执行动画
        //设置动画执行时间
        [UIView setAnimationDuration:0.5];
        cell.x=0;
        [UIView commitAnimations];
        currentMaxDisplayedCell = (int)indexPath.row;
        currentMaxDisplayedSection = (int)indexPath.section;
    }
}
-(void)resetViewedCells{
    currentMaxDisplayedSection = 0;
    currentMaxDisplayedCell = 0;
}

-(void)showAnimation{
    if (self.state!=AlbumMoreStateHide) {
        return;
    }
    
    [self.moreAlbumTable reloadData];
    [self resetViewedCells];
    
    self.state=AlbumMoreStateMoving;
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.5];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(showStopAnimation)];
    self.x=kScreen_Width/2;
    [UIView commitAnimations];
}
-(void)showStopAnimation{
    self.state=AlbumMoreStateShow;
}
-(void)hideAnimation{
    if (self.state!=AlbumMoreStateShow) {
        return;
    }
    self.state=AlbumMoreStateMoving;
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.3];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(hideStopAnimation)];
    self.x=kScreen_Width+10;
    [UIView commitAnimations];
}
-(void)hideStopAnimation{
    self.state=AlbumMoreStateHide;
}
@end
