//
//  RecommendViewController.m
//  thegloballove
//
//  Created by wukexiu on 15/12/29.
//  Copyright © 2015年 biandewen. All rights reserved.
//

#import "RecommendViewController.h"

#import "AlbumCardFlowLayout.h"
#import "AlbumCardItemView.h"
#import "AlbumCardMoreView.h"
#import "ChoiceCardItemView.h"
#import "RecruitCardItemView.h"

 
@interface RecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UIScrollView *cardScrollView;
@property(nonatomic,strong)UIView *choiceCardView,*recruitCardView;
@property(nonatomic,strong)UICollectionView *albumCardCollectView,*choiceCardCollectView,*recruitCardCollectView;
@property(nonatomic,strong)AlbumCardMoreView *albumCardMoreView;
@property(nonatomic,strong)NSMutableArray *albumCardData,*choiceCardData,*recruitCardData;
@property(nonatomic,strong)UILabel *bigTitel,*smallTitel;
@end

@implementation RecommendViewController

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
    
    self.albumCardData=[NSMutableArray array];
    [self.albumCardData addObjectsFromArray:@[@"demo_card_city",@"demo_card_goods",@"demo_card_persongroup",@"demo_card_themes",@"demo_card_person"]];
    self.choiceCardData= [NSMutableArray array];
    [self.choiceCardData addObjectsFromArray: @[@"demo_photo_1",@"demo_photo_2",@"demo_photo_3",@"demo_photo_1",@"demo_photo_2",@"demo_photo_3"]];
    self.recruitCardData=[NSMutableArray array];
    [self.recruitCardData addObjectsFromArray:@[@"demo_cover_photo",@"demo_travel_2",@"demo_travel_1",@"demo_travel_2",@"demo_travel_1",@"demo_travel_2"]];
    
    //UIImageView *imageV=[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //imageV.image=[UIImage imageNamed:@"recommend_bg"];
    //[self.view addSubview:imageV];
    self.view.backgroundColor= XMUIColor(236, 236, 236, 1);
    
    [self initScrollView];
    [self initAlbmTitelView];
    [self initAlbmCardCollectView];
    [self initChoiceCardCollectView];
    [self initRecruitCardCollectView];
    //NSLog(@"Screen Width:%f,Screen Height:%f",kScreen_Width,kScreen_Height);
    //NSLog(@"View Width:%f,View Height:%f",self.view.width,self.view.height);
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 80, kScreen_Width, 80)];
    toolbar.translucent = YES;
    toolbar.clipsToBounds = YES;
    //UIImageView *toolbarHairlineImageView = [self findHairlineImageViewUnder:toolbar];
    //toolbarHairlineImageView.hidden = YES;
    
    //[toolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //[toolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    
    [self.view addSubview:toolbar];
    
    
    /*
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.backgroundColor = XMUIColor(255, 255, 255, 0.5);
    effectView.frame = CGRectMake(0, 142, kScreen_Width, 80);
    [self.view addSubview:effectView];
     */
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)initScrollView{
    self.cardScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.cardScrollView.backgroundColor = [UIColor clearColor];
    self.cardScrollView.showsHorizontalScrollIndicator = NO;
    self.cardScrollView.showsVerticalScrollIndicator = NO;
    self.cardScrollView.bounces = YES;
    self.cardScrollView.alwaysBounceVertical=YES;
    self.cardScrollView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    [self.view addSubview:self.cardScrollView];
}
-(void)initAlbmTitelView{
    self.bigTitel=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, kScreen_Width-20*2, 30)];
    self.bigTitel.text=@"好莱坞徒步旅行摄影";
    self.bigTitel.font=[UIFont fontWithName:@"PingFangSC-Thin" size:23];
    self.bigTitel.textColor=XMUIColor(113, 118, 122, 1.0);
    [self.cardScrollView addSubview:self.bigTitel];
    
    self.smallTitel=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, kScreen_Width-20*2, 20)];
    self.smallTitel.text=@"拍摄时间：15.8.11-15.9.30";
    self.smallTitel.font=[UIFont fontWithName:@"PingFangSC-Thin" size:13];
    self.smallTitel.textColor=XMUIColor(113, 118, 122, 1.0);
    [self.cardScrollView addSubview:self.smallTitel];
    
}
-(void)initAlbmCardCollectView{
    AlbumCardFlowLayout *collectLayout=[[AlbumCardFlowLayout alloc] init];
    self.albumCardCollectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, kScreen_Width, 345*kScreen_Width/IPHONE6_WIDTH+50) collectionViewLayout:collectLayout];
    self.albumCardCollectView.delegate=self;
    self.albumCardCollectView.dataSource=self;
    self.albumCardCollectView.showsHorizontalScrollIndicator=false;
    self.albumCardCollectView.pagingEnabled=false;
    [self.albumCardCollectView registerNib:[UINib nibWithNibName:@"AlbumCardItemView" bundle:nil] forCellWithReuseIdentifier:@"AlbumCardCell"];
    self.albumCardCollectView.backgroundColor=[UIColor clearColor];
    self.albumCardCollectView.backgroundColor=XMUIColor(227, 228, 231, 1);//TGLColor(255, 231, 32, 0.6);
    self.albumCardCollectView.tag=100;
    
    [self.cardScrollView addSubview:self.albumCardCollectView];
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.albumCardCollectView footerViewPullToRefreshHorizontal:^{
        [self.albumCardCollectView setFooterHidden:NO];
        // 增加5条假数据
        /*
        for (int i = 0; i<10; i++) {
            if (weakSelf.albumCardData) {
                [weakSelf.albumCardData addObject:@"demo_card_goods"];
            }
            
        }
        */
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //[weakSelf.albumCardCollectView reloadData];
            if (self.albumCardMoreView) {
                [self.albumCardMoreView showAnimation];
            }
            // 结束刷新
            [weakSelf.albumCardCollectView footerEndRefreshing];
        });
        
    }];
    
    
    self.albumCardMoreView=[[[NSBundle mainBundle] loadNibNamed:@"AlbumCardMoreView" owner:nil options:nil] lastObject];
    self.albumCardMoreView.frame=CGRectMake(kScreen_Width+10, 90, kScreen_Width/2, 345*kScreen_Width/IPHONE6_WIDTH+50);
    //self.albumCardMoreView.x=kScreen_Width+10;
    [self.cardScrollView addSubview:self.albumCardMoreView];
}
-(void)initChoiceCardCollectView{
    self.choiceCardView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.albumCardCollectView.frame)+20, kScreen_Width, 160*kScreen_Width/IPHONE6_WIDTH+45+10)];
    self.choiceCardView.backgroundColor=XMUIColor(227, 228, 231, 1);
    [self.cardScrollView addSubview:self.choiceCardView];
    
    UICollectionViewFlowLayout *collectLayout=[[UICollectionViewFlowLayout alloc] init];
    float proportion=kScreen_Width/IPHONE6_WIDTH;
    collectLayout.itemSize=CGSizeMake(160*proportion, 160*proportion);
    collectLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    collectLayout.minimumInteritemSpacing=8;
    collectLayout.minimumLineSpacing=8;
    collectLayout.sectionInset=UIEdgeInsetsMake(0, 10, 2, 10);
    
    self.choiceCardCollectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,45, kScreen_Width, 160*kScreen_Width/IPHONE6_WIDTH+0+2) collectionViewLayout:collectLayout];
    self.choiceCardCollectView.delegate=self;
    self.choiceCardCollectView.dataSource=self;
    self.choiceCardCollectView.showsHorizontalScrollIndicator=false;
    self.choiceCardCollectView.pagingEnabled=false;
    [self.choiceCardCollectView registerNib:[UINib nibWithNibName:@"ChoiceCardItemView" bundle:nil] forCellWithReuseIdentifier:@"ChoiceCardCell"];
    self.choiceCardCollectView.backgroundColor=[UIColor clearColor];
    self.choiceCardCollectView.tag=101;
    [self.choiceCardView addSubview:self.choiceCardCollectView];
    
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    [self.choiceCardCollectView footerViewPullToRefreshHorizontal:^{
        [self.choiceCardCollectView setFooterHidden:NO];
        // 增加5条假数据
        for (int i = 0; i<10; i++) {
            if (weakSelf.choiceCardData) {
                [weakSelf.choiceCardData addObject:@"demo_photo_1"];
            }
            
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.choiceCardCollectView reloadData];
            
            // 结束刷新
            [weakSelf.choiceCardCollectView footerEndRefreshing];
        });
        
    }];
    
     
    UILabel *titlelbl=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-20*2, 45)];
    titlelbl.text=@"专辑";
    titlelbl.font=[UIFont fontWithName:@"PingFangSC-Thin" size:22];
    titlelbl.textColor=XMUIColor(113, 118, 122, 1.0);//[UIColor whiteColor];
    
    [self.choiceCardView addSubview:titlelbl];
    
    
}
-(void)initRecruitCardCollectView{
    self.recruitCardView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.choiceCardView.frame)+20, kScreen_Width, 160*kScreen_Width/IPHONE6_WIDTH+45+10)];
    self.recruitCardView.backgroundColor=XMUIColor(227, 228, 231, 1);
    [self.cardScrollView addSubview:self.recruitCardView];
    self.cardScrollView.contentSize=CGSizeMake(kScreen_Width, CGRectGetMaxY(self.recruitCardView.frame));
    /*
    [self.cardScrollView footerViewPullToRefreshVertical:^{
        NSLog(@"bbbbbbbbb");
        [self.cardScrollView setFooterHidden:NO];
        
        //[self.cardScrollView reloadData];
        [self.cardScrollView footerEndRefreshing];
        [self.cardScrollView setFooterHidden:YES];
    }];
    */
     
    UICollectionViewFlowLayout *collectLayout=[[UICollectionViewFlowLayout alloc] init];
    float proportion=kScreen_Width/IPHONE6_WIDTH;
    collectLayout.itemSize=CGSizeMake(268*proportion, 160*proportion);
    collectLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    collectLayout.minimumInteritemSpacing=8;
    collectLayout.minimumLineSpacing=8;
    collectLayout.sectionInset=UIEdgeInsetsMake(0, 10, 2, 10);
    
    self.recruitCardCollectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,45, kScreen_Width, 160*kScreen_Width/IPHONE6_WIDTH+0+2) collectionViewLayout:collectLayout];
    self.recruitCardCollectView.delegate=self;
    self.recruitCardCollectView.dataSource=self;
    self.recruitCardCollectView.showsHorizontalScrollIndicator=false;
    self.recruitCardCollectView.pagingEnabled=false;
    [self.recruitCardCollectView registerNib:[UINib nibWithNibName:@"RecruitCardItemView" bundle:nil] forCellWithReuseIdentifier:@"RecruitCardCell"];

    self.recruitCardCollectView.backgroundColor=[UIColor clearColor];
    self.recruitCardCollectView.tag=102;
    [self.recruitCardView addSubview:self.recruitCardCollectView];
    
    UILabel *titlelbl=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-20*2, 45)];
    titlelbl.text=@"精选服务";
    titlelbl.font=[UIFont fontWithName:@"PingFangSC-Thin" size:22];
    titlelbl.textColor=XMUIColor(113, 118, 122, 1.0);//[UIColor whiteColor];
    [self.recruitCardView addSubview:titlelbl];
    
}


//MARK ScrollerDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.tag==100 && self.albumCardMoreView) {
        [self.albumCardMoreView hideAnimation];
    }
}
/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==100) {
        //NSLog(@"scrollViewDidScroll x:%f",scrollView.contentOffset.x);
        NSLog(@"scrollViewDidEndDecelerating x:%f",scrollView.contentOffset.x);
        float proportion=kScreen_Width/IPHONE6_WIDTH;
        int index=(scrollView.contentOffset.x+(proportion*187/2-40))/(proportion*187);
        
        if ([self.albumCardData count]>0&&[self.albumCardData count]-1<index) {
            index=[self.albumCardData count]-1;
        }
        NSLog(@"scrollView tag=100 index=%d",index);
        
    }else if (scrollView.tag==101){
        NSLog(@"scrollViewDidEndDecelerating x:%f",scrollView.contentOffset.x);
        float proportion=kScreen_Width/IPHONE6_WIDTH;
        int index=(scrollView.contentOffset.x+(proportion*107-20))/(proportion*107);

        if ([self.choiceCardData count]>0&&[self.choiceCardData count]-1<index) {
            index=[self.choiceCardData count]-1;
        }
        NSLog(@"scrollView tag=101 index=%d",index);
    }else if (scrollView.tag==102){
        NSLog(@"scrollViewDidEndDecelerating x:%f",scrollView.contentOffset.x);
        float proportion=kScreen_Width/IPHONE6_WIDTH;
        int index=(scrollView.contentOffset.x+(proportion*179/2-20))/(proportion*179);
        
        if ([self.recruitCardData count]>0&&[self.recruitCardData count]-1<index) {
            index=[self.recruitCardData count]-1;
        }
        NSLog(@"scrollView tag=102 index=%d",index);
    }
}
 */
 /*
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    if (scrollView.tag==100) {
        NSLog(@"scrollViewDidEndDecelerating x:%f",scrollView.contentOffset.x);
        float proportion=kScreen_Width/IPHONE5_WIDTH*(2/3.0);
        int index=(scrollView.contentOffset.x)/(proportion*292);

        if ([self.albumCardData count]>0&&[self.albumCardData count]-1<index) {
            index=[self.albumCardData count]-1;
        }
        NSLog(@"scrollView tag=100 index=%d",index);
    }else if (scrollView.tag==101){
        NSLog(@"scrollViewDidEndDecelerating x:%f",scrollView.contentOffset.x);
        float proportion=kScreen_Width/IPHONE5_WIDTH*(2/3.0);
        int index=(scrollView.contentOffset.x)/(proportion*172);
        
        if ([self.choiceCardData count]>0&&[self.choiceCardData count]-1<index) {
            index=[self.choiceCardData count]-1;
        }
        NSLog(@"scrollView tag=101 index=%d",index);
    }
    
}
 */
//MARK UICollection Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag==100) {
        return [self.albumCardData count];
    }else if (collectionView.tag==101){
        return [self.choiceCardData count];
    }else if (collectionView.tag==102){
        return [self.recruitCardData count];
    }
    return 0;
} 
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==100) {
        AlbumCardItemView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCardCell" forIndexPath:indexPath];
        NSString *imageUrl=self.albumCardData[indexPath.row];
        cell.cardImage.image=[UIImage imageNamed:imageUrl];
        return cell;
    }else if (collectionView.tag==101){
        ChoiceCardItemView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ChoiceCardCell" forIndexPath:indexPath];
        NSString *imageUrl=self.choiceCardData[indexPath.row];
        cell.cardImage.image=[UIImage imageNamed:imageUrl];
        return cell;
    }else if (collectionView.tag==102){
        RecruitCardItemView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RecruitCardCell" forIndexPath:indexPath];
        NSString *imageUrl=self.recruitCardData[indexPath.row];
        cell.cardImage.image=[UIImage imageNamed:imageUrl];
        return cell;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==100) {
        //NSLog(@"点击了卡片%ld",indexPath.row);
        
    
    }else if (collectionView.tag==101){
        //NSLog(@"精选合集卡片%ld",indexPath.row);
        
        
    }else if (collectionView.tag==102){
        //NSLog(@"招募合集卡片%ld",indexPath.row);

    }
    
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
