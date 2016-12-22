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

@interface XMFindRootController ()<UITableViewDataSource,UITableViewDelegate>

@property(weak, nonatomic)UITableView *myTableView;

@end

@implementation XMFindRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
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
    _myTableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    //[_myTableView registerClass:[XMTitleValueCell class] forCellReuseIdentifier:[XMTitleValueCell getID]];
    //[_myTableView registerClass:[XMTitleValueMoreCell class] forCellReuseIdentifier:[XMTitleValueMoreCell getID]];
    [_myTableView registerClass:[XMImageTitleValueCell class] forCellReuseIdentifier:[XMImageTitleValueCell getID]];
    _myTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
}

#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row;
    switch (section) {
        case 0:
            row=1;
            break;
        case 1:
            row=4;
            break;
        case 2:
            row=1;
            break;
        case 3:
            row=4;
            break;
        default:
            row=0;
            break;
    }
    return row;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight;
    /*
    if (indexPath.section==1&&indexPath.row==1) {
        cellHeight = [XMTitleValueCell cellHeight];
    }else{
        cellHeight = [XMTitleValueMoreCell cellHeight];
    }
     */
    cellHeight = [XMImageTitleValueCell cellHeight];
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
    headerView.backgroundColor = XMUIColor(237, 237, 237, 1.0);
    [headerView setHeight:10.0];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XMImageTitleValueCell *cell = [tableView dequeueReusableCellWithIdentifier:[XMImageTitleValueCell getID] forIndexPath:indexPath];
    return cell;
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
