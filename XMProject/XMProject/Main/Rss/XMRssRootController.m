//
//  XMRssRootController.m
//  XMProject
//
//  Created by wukexiu on 16/12/15.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMRssRootController.h"
#import "MJRefresCatHeader.h"

@interface XMRssRootController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView *myTableView;

@end

@implementation XMRssRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNavBar];
    [self initMyTableView];
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
    //[_myTableView registerClass:[XMImageTitleValueCell class] forCellReuseIdentifier:[XMImageTitleValueCell getID]];
    //_myTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    
    __weak typeof(self) weakSelf = self;
    /*
    _viewModel = [[XMFindViewModel alloc] init];
    _viewModel.updateBlock = ^(){
        [weakSelf.myTableView reloadData];
        [weakSelf.myTableView.mj_header endRefreshing];
    };
     */
    MJRefresCatHeader *header = [MJRefresCatHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_header endRefreshing];
        //[_viewModel refreshDataSource];
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
    self.title = @"订阅";
    //leftBtn
    [self addLeftButtonWithImageName:@"top_addlike_n" Target:self Action:@selector(searchBtnClick:)];
    //rightBtn
    UIButton *historyBtn = [self getNavBarButtonWithImageName:@"top_history_n" Target:self Action:@selector(historyBtnClick:)];
    UIButton *downloadBtn = [self getNavBarButtonWithImageName:@"top_download_n" Target:self Action:@selector(downloadBtnClick:)];
    [self addRightBarItemCustomButtons:@[downloadBtn,historyBtn]];
}

#pragma mark Click
-(void)searchBtnClick:(id)sender{
    NSLog(@"点击了+按钮");
}
-(void)historyBtnClick:(id)sender{
    NSLog(@"点击了历史按钮");
}
-(void)downloadBtnClick:(id)sender{
    NSLog(@"点击了下载按钮");
}


#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight;
    cellHeight = 0;
    return cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
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
