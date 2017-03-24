//
//  RootTabViewController.m
//  XMProject
//
//  Created by wukexiu on 16/2/2.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "RootTabViewController.h"
#import "XMNavigationViewController.h"
#import "RDVTabBarItem.h"
#import "XMLoginTool.h"

#import "RecommendViewController.h"
#import "XMRssRootController.h"
#import "FindRootController.h"
#import "DestRootController.h"
#import "DynamicRootController.h"
#import "SquareRootController.h"
#import "XMFindRootController.h"
#import "XMHomeRootController.h"

@interface RootTabViewController ()

//@property(nonatomic,strong) TGLLoginView *loginView;

@end

@implementation RootTabViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
    
    UIImageView *iv_a = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width-75)/2.0, 49 - 65, 75, 65)];
    iv_a.image = [UIImage imageNamed:@"tabbar_np_shadow"];
    iv_a.contentMode = UIViewContentModeScaleAspectFill;
    [self.tabBar addSubview:iv_a];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width-65)/2.0, 49 - 65, 65, 65)];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_np_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_np_normal"] forState:UIControlStateHighlighted];
    btn.contentMode = UIViewContentModeScaleAspectFill;
    [self.tabBar addSubview:btn];
    btn.userInteractionEnabled = YES;
    
    self.tabBar.clipsToBounds = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupViewControllers{
    
    RecommendViewController *vc_recommend=[[RecommendViewController alloc] init];
    XMNavigationViewController *nav_recommend=[[XMNavigationViewController alloc] initWithRootViewController:vc_recommend];
    
    XMHomeRootController *vc_home = [[XMHomeRootController alloc] init];
    XMNavigationViewController *nav_home = [[XMNavigationViewController alloc] initWithRootViewController:vc_home];
    
    XMRssRootController *vc_rss=[[XMRssRootController alloc] init];
    XMNavigationViewController *nav_rss=[[XMNavigationViewController alloc] initWithRootViewController:vc_rss];
    
    RootViewController *vc_other = [[RootViewController alloc] init];
    XMNavigationViewController *nav_other = [[XMNavigationViewController alloc] initWithRootViewController:vc_other];
    
    FindRootController *nav_rss2=[FindRootController newSwipeBetweenViewControllers];
    [nav_rss2.viewControllerArray addObjectsFromArray:@[[[DestRootController alloc] init],
                                                        [[DynamicRootController alloc] init],
                                                        [[SquareRootController alloc] init]]];
    nav_rss2.buttonText=@[@"目的地",@"摄影师动态",@"广场"];
    nav_rss2.buttonImages=@[@"nav_title_img_dest",@"nav_title_img_dynamic",@"nav_title_img_square"];
    nav_rss2.pageSelected=@[@"nav_page_selected_yellow",@"nav_page_selected_green",@"nav_page_selected_red"];
    nav_rss2.pageUnselected=@[@"nav_page_unselected",@"nav_page_unselected",@"nav_page_unselected"];
    

    XMFindRootController *vc_find=[[XMFindRootController alloc] init];
    XMNavigationViewController *nav_find=[[XMNavigationViewController alloc] initWithRootViewController:vc_find];
    
    /*
    DiscoverRootController *vc_discover=[[DiscoverRootController alloc] initWithNibName:@"DiscoverRootController" bundle:nil];
    XMNavigationViewController *nav_discover=[[XMNavigationViewController alloc] initWithRootViewController:vc_discover];
    
    ScheduleRootController *vc_schedule=[[ScheduleRootController alloc] initWithNibName:@"ScheduleRootController" bundle:nil];
    XMNavigationViewController *nav_schedule=[[XMNavigationViewController alloc] initWithRootViewController:vc_schedule];
    
    
    MessageRootController *vc_message=[[MessageRootController alloc] init];
    XMNavigationViewController *nav_message=[[XMNavigationViewController alloc] initWithRootViewController:vc_message];

    MePhotogRootController *vc_mephotog=[[MePhotogRootController alloc] initWithNibName:@"MePhotogRootController" bundle:nil];
    MeRootController *vc_me=[[MeRootController alloc] initWithNibName:@"MeRootController" bundle:nil];
    XMNavigationViewController *nav_me;
    nav_me = [[XMNavigationViewController alloc] initWithRootViewController:vc_mephotog];
    */
    [self setViewControllers:@[nav_home,nav_rss,nav_other,nav_find,nav_rss2]];
    [self customizeTabBarForController];
    self.delegate=self;
    self.selectedIndex = 0;
     
}
-(void)customizeTabBarForController{
    UIImage *backgroundImage=[UIImage imageWithColor:XMUIColor(255, 255, 255, 1.0) withFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, -7, kScreen_Width, 8)];
    iv.image = [UIImage imageNamed:@"tabbar_split_Image"];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    [self.tabBar addSubview:iv];
    NSArray *tabBarItemImages=@[@"tabbar_icon_homepage",@"tabbar_icon_Rss",@"",@"tabbar_icon_find",@"tabbar_icon_my"];
    //tabbar_np_normal tabbar_np_shadow
    NSArray *tabBarItemTitles = @[@"首页", @"订阅", @"", @"发现", @"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_pressed",
                                                      [tabBarItemImages objectAtIndex:index]]];//_selected
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];//_normal
        if (index == 2) {
            [item setFinishedSelectedImage:nil withFinishedUnselectedImage:nil];
        }else{
            [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        }
        /*
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:10],
                                           NSForegroundColorAttributeName: kXMColor(121, 121, 121, 1),
                                           };
        item.selectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:10],
                                           NSForegroundColorAttributeName: kXMColor(121, 121, 121, 1),
                                           };
         */
        index++;
    }

}

#pragma mark RDVTabBarControllerDelegate
-(BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    __weak typeof(self) weakSelf = self;

    /*
    if (tabBarController.selectedViewController==viewController) {
        return NO;
    }
    
    if (![viewController isKindOfClass:[XMNavigationViewController class]]&&![viewController isKindOfClass:[RKSwipeBetweenViewControllers class]]) {
        return NO;
    }
    
    XMNavigationViewController *nav = (XMNavigationViewController *)viewController;
    
    if ([nav.viewControllers[0] isKindOfClass:[ScheduleRootController class]] || [nav.viewControllers[0] isKindOfClass:[MessageRootController class]]||[nav.viewControllers[0] isKindOfClass:[MeRootController class]]||[nav.viewControllers[0] isKindOfClass:[MePhotogRootController class]]){
        //return YES;
        if ([XMLoginTool sharedLoginTool].isLogin) {
            return YES;
        }
        [[XMLoginTool sharedLoginTool] toLoginFunctionShow:YES completion:^{
            [weakSelf setupViewControllers];
        }];
        return NO;
    }
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
     */
    return YES;
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
