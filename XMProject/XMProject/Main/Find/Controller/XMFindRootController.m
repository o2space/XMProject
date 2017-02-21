//
//  XMFindRootController.m
//  XMProject
//
//  Created by wukexiu on 16/12/21.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMFindRootController.h"
#import "XMTitleValueCell.h"
#import "XMTitleValueMoreCell.h"
#import "XMImageTitleValueCell.h"
#import "XMFindViewModel.h"
#import "MJRefresCatHeader.h"

@interface XMFindRootController ()<UITableViewDataSource,UITableViewDelegate>
@property(weak, nonatomic)IBOutlet UITableView *myTableView;

@property(strong, nonatomic)XMFindViewModel *viewModel;

@end

@implementation XMFindRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setupNavBar];
    [self initMyTableView];
    NSLog(@"1--------Find view height:%lf",self.view.height);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"2--------Find view height:%lf",self.view.height);
    });
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
}

- (void)initMyTableView{
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_myTableView registerClass:[XMImageTitleValueCell class] forCellReuseIdentifier:[XMImageTitleValueCell getID]];
    _myTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    _myTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    
    __weak typeof(self) weakSelf = self;
    _viewModel = [[XMFindViewModel alloc] init];
    _viewModel.updateBlock = ^(){
        [weakSelf.myTableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.myTableView.mj_header endRefreshing];
        });
        
    };
    MJRefresCatHeader *header = [MJRefresCatHeader headerWithRefreshingBlock:^{
        [_viewModel refreshDataSource];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"           下拉可以刷新..." forState:MJRefreshStateIdle];
    [header setTitle:@"           松开即可刷新..." forState:MJRefreshStatePulling];
    [header setTitle:@"               玩命加载中..." forState:MJRefreshStateRefreshing];
    self.myTableView.mj_header = header;
    [self.myTableView.mj_header beginRefreshing];
}

- (void)setupNavBar{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"发现";
    //leftBtn
    [self addLeftButtonWithImageName:@"top_search_n" Target:self Action:@selector(searchBtnClick:)];
    //rightBtn
    UIButton *historyBtn = [self getNavBarButtonWithImageName:@"top_history_n" Target:self Action:@selector(historyBtnClick:)];
    UIButton *downloadBtn = [self getNavBarButtonWithImageName:@"top_download_n" Target:self Action:@selector(downloadBtnClick:)];
    [self addRightBarItemCustomButtons:@[downloadBtn,historyBtn]];
}

#pragma mark Click
-(void)searchBtnClick:(id)sender{
    NSLog(@"点击了搜索按钮");
}
-(void)historyBtnClick:(id)sender{
    NSLog(@"点击了历史按钮");
}
-(void)downloadBtnClick:(id)sender{
    NSLog(@"点击了下载按钮");
}

#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_viewModel.findRootModel.list count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSInteger row = section;
    XMFindModel *findModel = (XMFindModel *)_viewModel.findRootModel.list[section];
    return findModel == nil ? 0 : [findModel.list count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 9.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight;
    cellHeight = [XMImageTitleValueCell cellHeight];
    return cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
    headerView.backgroundColor = XMUIColor(237, 237, 237, 1.0);
    [headerView setHeight:10.0];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
    footerView.backgroundColor = XMUIColor(237, 237, 237, 1.0);
    [footerView setHeight:0.0];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    XMImageTitleValueCell *cell = [tableView dequeueReusableCellWithIdentifier:[XMImageTitleValueCell getID] forIndexPath:indexPath];
    
    XMFindModel *findModel = (XMFindModel *)_viewModel.findRootModel.list[section];
    if (findModel) {
        XMFindDetailModel *findDetail = (XMFindDetailModel *)findModel.list[row];
        if (findDetail) {
            [cell updateTitleImg:findDetail.coverPath TitleLbl:findDetail.title ValueImg:findDetail.subCoverPath ValueLbl:findDetail.subtitle];
        }
    }
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:60 hasSectionLine:NO];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
