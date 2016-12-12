//
//  NewFeatureViewController.m
//  XMProject
//
//  Created by wukexiu on 15/12/28.
//  Copyright © 2015年 wukexiu. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "RootTabViewController.h"

#define NewfeatureImageCount 3

@interface NewFeatureViewController ()

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
    [self setupPageControl];
}

-(void)setupScrollView
{
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=self.view.bounds;
    scrollView.delegate=self;
    scrollView.pagingEnabled=true;
    [self.view addSubview:scrollView];
    
    CGFloat imageW=scrollView.width;
    CGFloat imageH=scrollView.height;
    for (int i=0; i<NewfeatureImageCount; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        NSString *name=[NSString stringWithFormat:@"new_feature_%d",i+1];
        if(FourInch){
            //name=[name stringByAppendingString:@"-568h"];
        }
        imageView.image=[UIImage imageWithName:name];
        [scrollView addSubview:imageView];
        imageView.y=0;
        imageView.width=imageW;
        imageView.x=i*imageW;
        imageView.height=imageH;
        
        if(i==NewfeatureImageCount-1)
        {
            [self setupLastImageView:imageView];
        }
    }
    //设置活动范围
    scrollView.contentSize=CGSizeMake(NewfeatureImageCount*imageW, 0);
    //设置背景颜色
    scrollView.backgroundColor=kXMColor(246, 246, 246, 1.0);
    //隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator=NO;
    //去除弹簧效果
    scrollView.bounces=NO;
}
-(void)setupPageControl
{
    UIPageControl *pageControl=[[UIPageControl alloc] init];
    pageControl.numberOfPages=NewfeatureImageCount;
    pageControl.center=CGPointMake(self.view.width*0.5, self.view.height-30);
    [self.view addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor=kXMColor(253, 98, 42, 1.0);
    pageControl.pageIndicatorTintColor=kXMColor(189, 189, 189, 1.0);
    self.pageControl=pageControl;
}

-(void)setupLastImageView:(UIImageView *)imageView
{
    //设置可交互
    imageView.userInteractionEnabled=YES;
    [self setupStarButton:imageView];
    
}

-(void)setupStarButton:(UIImageView *)imageView
{
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    
    //[startButton setBackgroundImage:[UIImage imageWithName:@"gwc_gg"] forState:UIControlStateNormal];
    //[startButton setBackgroundImage:[UIImage imageWithName:@"gwc_ggc"] forState:UIControlStateHighlighted];
    
    startButton.size=imageView.size; //startButton.currentBackgroundImage.size;
    startButton.center=CGPointMake(self.view.width*0.5, self.view.height*0.5);
    //[startButton setTitle:@"开始使用" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}
-(void)start
{
    //TGLTabBarViewController *vc=[[TGLTabBarViewController alloc] init];
    RootTabViewController *vc=[[RootTabViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController=vc;
}



#pragma mark-UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double doublePage=scrollView.contentOffset.x/scrollView.width;
    int intPage=(int)(doublePage+0.5);
    self.pageControl.currentPage=intPage;
}
#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
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
