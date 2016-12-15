//
//  DestRootController.m
//  thegloballove
//
//  Created by wukexiu on 16/2/3.
//  Copyright © 2016年 biandewen. All rights reserved.
//

#import "DestRootController.h"

#import "CityCollectionViewCell.h"
#import "CityHeadCollectionReusableView.h"

@interface DestRootController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(readonly,strong) UICollectionView *collView;
@property(readonly,strong) NSArray *headTitles;
@property(nonatomic,strong) NSArray *hotCityList;
@end

@implementation DestRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    _headTitles=[[NSArray alloc] initWithObjects:@"国内·发现·惊喜",@"国际·分享·攻略",nil];
    _hotCityList=[[NSArray alloc] initWithObjects:@[@"北京", @"上海", @"成都", @"广州", @"杭州", @"西安", @"重庆", @"厦门", @"台北"],@[@"罗马", @"迪拜", @"里斯本", @"巴黎", @"柏林", @"伦敦"], nil];
    [self setCollectionView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [UIApplication sharedApplication].statusBarHidden=NO;
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setCollectionView{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    CGFloat margin=10;
    layout.minimumInteritemSpacing=margin;
    layout.sectionInset=UIEdgeInsetsMake(margin, margin, margin, margin);
    CGFloat itemH=80;
    CGFloat itemW= (kScreen_Width - 4 * margin) / 3 -2;
    if (kScreen_Width > 375) {
        itemW -= 3;
    }
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.headerReferenceSize=CGSizeMake(kScreen_Width, 50);
    
    _collView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collView.backgroundColor=[UIColor whiteColor];
    _collView.delegate=self;
    _collView.dataSource=self;
    _collView.alwaysBounceVertical=true;
    [_collView registerNib:[UINib nibWithNibName:@"CityHeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CityHeadCollectionReusableViewID"];
    [_collView registerNib:[UINib nibWithNibName:@"CityCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CityCollectionViewCellID"];
    
    _collView.showsHorizontalScrollIndicator=false;
    _collView.showsVerticalScrollIndicator=false;
    _collView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.view addSubview:_collView];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_hotCityList count];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_hotCityList[section] count];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CityHeadCollectionReusableView *heaView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CityHeadCollectionReusableViewID" forIndexPath:indexPath];
    heaView.headTitle.text=_headTitles[indexPath.section];
    return heaView;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CityCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CityCollectionViewCellID" forIndexPath:indexPath];
    cell.titleLbl.text=_hotCityList[indexPath.section][indexPath.row];
    cell.cityIv.image=[UIImage imageNamed:@"defaultCity"];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
