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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupViewControllers{
    /*
    RecommendViewController *vc_recommend=[[RecommendViewController alloc] init];
    XMNavigationViewController *nav_recommend=[[XMNavigationViewController alloc] initWithRootViewController:vc_recommend];
    
    TGLHomepageController *vc_home=[[TGLHomepageController alloc] initWithNibName:@"TGLHomepageController" bundle:nil];
    XMNavigationViewController *nav_home=[[XMNavigationViewController alloc] initWithRootViewController:vc_home];
    */
    
    //FindViewController *vc_find=[[FindViewController alloc] init];
    //TGLNavigationViewController *nav_find=[[TGLNavigationViewController alloc] initWithRootViewController:vc_find];
    
    /*
    FindRootController *nav_find=[FindRootController newSwipeBetweenViewControllers];
    [nav_find.viewControllerArray addObjectsFromArray:@[[[DestRootController alloc] init],
                                                        [[DynamicRootController alloc] init],
                                                        [[SquareRootController alloc] init]]];
    nav_find.buttonText=@[@"目的地",@"摄影师动态",@"广场"];
    nav_find.buttonImages=@[@"nav_title_img_dest",@"nav_title_img_dynamic",@"nav_title_img_square"];
    nav_find.pageSelected=@[@"nav_page_selected_yellow",@"nav_page_selected_green",@"nav_page_selected_red"];
    nav_find.pageUnselected=@[@"nav_page_unselected",@"nav_page_unselected",@"nav_page_unselected"];
    */

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
    
    [self setViewControllers:@[nav_home,nav_discover,nav_message,nav_me]];
    [self customizeTabBarForController];
    self.delegate=self;
    self.selectedIndex = 0;
     */
}
-(void)customizeTabBarForController{
    UIImage *backgroundImage=[UIImage imageWithColor:kXMColor(255, 255, 255, 0.85) withFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    NSArray *tabBarItemImages=@[@"tab_recommend",@"tab_find",@"tab_message",@"tab_me"];
    NSArray *tabBarItemTitles = @[@"推荐", @"发现",@"消息", @"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sle",
                                                      [tabBarItemImages objectAtIndex:index]]];//_selected
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor",
                                                        [tabBarItemImages objectAtIndex:index]]];//_normal
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:10],
                                           NSForegroundColorAttributeName: kXMColor(121, 121, 121, 1),
                                           };
        item.selectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:10],
                                           NSForegroundColorAttributeName: kXMColor(121, 121, 121, 1),
                                           };
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