//
//  XMHomeRootController.m
//  XMProject
//
//  Created by wukexiu on 16/12/25.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMHomeRootController.h"
#import "XMSubHomeFactory.h"
#import "XMHomeSubTitleView.h"
#import "XMPageViewController.h"

@interface XMHomeRootController ()<MXPageViewControllerDelegate,XMHomeSubTitleViewDelegate>

@property(nonatomic,strong)NSArray *subTitleArr;//子标题
@property(nonatomic,strong)NSArray *controllers;//子控制器
@property(nonatomic,strong)XMHomeSubTitleView *subTitleView;//子标题视图
@property(nonatomic,strong)XMPageViewController *xmPageVc;

@end

@implementation XMHomeRootController

#pragma mark - 懒加载
/// 子标题
- (NSArray *)subTitleArr{
    if (!_subTitleArr) {
        _subTitleArr = @[@"推荐", @"热门", @"分类", @"榜单", @"主播"];
    }
    return _subTitleArr;
}

/// 子控制器
- (NSArray *)controllers{
    if (!_controllers) {
        NSMutableArray *cons = [NSMutableArray array];
        for (NSString *title in self.subTitleArr) {
            BaseViewController *con = [XMSubHomeFactory subHomeVcWith:title];
            [cons addObject:con];
        }
        _controllers = [cons copy];
    }
    return _controllers;
}

/// 子标题视图
- (XMHomeSubTitleView *)subTitleView{
    if (!_subTitleView) {
        _subTitleView = [[XMHomeSubTitleView alloc] init];
        [self.view addSubview:_subTitleView];
        [_subTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.equalTo(self.view.mas_left);
            //make.right.equalTo(self.view.mas_right);
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(64);
            make.height.mas_equalTo(40);
        }];
    }
    return _subTitleView;
}

/// 控制多个子控制器
-(XMPageViewController *)xmPageVc{
    if (!_xmPageVc) {
        XMPageViewController *pageVc = [[XMPageViewController alloc] init:self controllers:self.controllers];
        pageVc.delegate = self;
        [self.view addSubview:pageVc.view];
        _xmPageVc = pageVc;
    }
    return _xmPageVc;
}


#pragma mark - LifeCircle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化NAV
    [self setupNavBar];
    // 设置背景颜色
    //self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.93 blue:0.93 alpha:1.0];
    self.subTitleView.delegate = self;
    self.subTitleView.titleArray = self.subTitleArr;
    
    // 配置子标题视图
    [self configSubViews];
    
    NSLog(@"1--------home view height:%lf",self.view.height);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"2--------home view height:%lf",self.view.height);
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
}

- (void)setupNavBar{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"首页";
    //leftBtn
    [self addLeftButtonWithImageName:@"top_search_n" Target:self Action:@selector(searchBtnClick:)];
    //rightBtn
    UIButton *historyBtn = [self getNavBarButtonWithImageName:@"top_history_n" Target:self Action:@selector(historyBtnClick:)];
    UIButton *downloadBtn = [self getNavBarButtonWithImageName:@"top_download_n" Target:self Action:@selector(downloadBtnClick:)];
    [self addRightBarItemCustomButtons:@[downloadBtn,historyBtn]];
}


-(void)configSubViews{
    [self.xmPageVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

#pragma mark - Click
-(void)searchBtnClick:(id)sender{
    NSLog(@"点击了搜索按钮");
}
-(void)historyBtnClick:(id)sender{
    NSLog(@"点击了历史按钮");
}
-(void)downloadBtnClick:(id)sender{
    NSLog(@"点击了下载按钮");
}

#pragma mark - MXPageViewControllerDelegate
-(void)mxPageCurrentSubControllerIndex:(NSInteger)index pageViewController:(XMPageViewController *)pageViewController{
    [self.subTitleView jump2Show:index];
}

#pragma mark - XMHomeSubTitleViewDelegate
-(void)homeSubTitleViewDidSelected:(XMHomeSubTitleView *)titleView atIndex:(NSInteger)index title:(NSString *)title{
    // 跳转对相应的子标题界面
    [self.xmPageVc setCurrentSubControllerWith:index];
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
