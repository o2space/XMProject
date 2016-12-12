//
//  XMNavigationViewController.m
//  XMProject
//
//  Created by wukexiu on 15/12/28.
//  Copyright (c) 2016年 wukexiu. All rights reserved.
//

#import "XMNavigationViewController.h"

#import "RDVTabBarController.h"

@implementation XMNavigationViewController
+(void)initialize
{
    [self setupNavigationBarTheme];
    
    [self setupBarButtionItemTheme];
}
+(void)setupNavigationBarTheme
{
    UINavigationBar *appearance=[UINavigationBar appearance];
    //appearance.barTintColor=[UIColor clearColor];
    //appearance.barTintColor=TGLColor(45, 47, 62, 1.0);
    /*
    if(!iOS7)
    {
        [appearance setBackgroundImage:[UIImage resizedImage:@"nav_bar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [appearance setBackgroundImage:[UIImage resizedImage:@"nav_bar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
     */
    //appearance.barStyle=UIBarStyleBlackTranslucent;
    appearance.translucent=NO;
    
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    //设置字体颜色
    textAttrs[UITextAttributeTextColor]=[UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:38.0/255.0 alpha:1.0];
    //设置字体大小
    textAttrs[UITextAttributeFont]=[UIFont fontWithName:@"PingFangSC-Regular" size:18];
    //设置字体的偏移量（0）
    //说明：UIOffsetZero是结构体，只有包装成NSValue对象才能放进字典中
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
}
+(void)setupBarButtionItemTheme
{
   /*
    //通过设置appearance对象，能够修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance=[UIBarButtonItem appearance];
    
    //设置文字的属性
    //1.设置普通状态下文字的属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    //设置字体
    textAttrs[UITextAttributeFont]=[UIFont systemFontOfSize:15];
    //这是偏移量为0
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    //设置颜色为橙色
    textAttrs[UITextAttributeTextColor]=[UIColor blackColor];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    //2.设置高亮状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *hightextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //设置颜色为红色
    hightextAttrs[UITextAttributeTextColor]=[UIColor orangeColor];
    [appearance setTitleTextAttributes:hightextAttrs forState:UIControlStateHighlighted];
    
    
    //3.设置不可用状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *disabletextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //设置颜色为灰色
    disabletextAttrs[UITextAttributeTextColor]=[UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
    
    //设置背景
    //技巧提示：为了让某个按钮的背景消失，可以设置一张完全透明的背景图片
//    [appearance setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [appearance setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    */
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarHidden=YES;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果push的不是栈顶控制器，那么隐藏tabbar工具条
    if(self.viewControllers.count>0){
        //viewController.hidesBottomBarWhenPushed=YES;//底部bar隐藏
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        /*
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"menu_icon_bulb" highImageName:@"menu_icon_bulb_pressed" target:self action:@selector(more)];
        */
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    }
    [super pushViewController:viewController animated:YES];
}
-(UIViewController *) popViewControllerAnimated:(BOOL)animated
{
    /*
    if (self.viewControllers.count==2) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
     */
//    return [super popViewControllerAnimated:animated];
    if (self.viewControllers.count <=2 ) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }
    return [super popViewControllerAnimated:animated];
}


- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    /*
    if ([viewController isKindOfClass:[MePhotogRootController class]] ||[viewController isKindOfClass:[MeRootController class]] || [viewController isKindOfClass:[DiscoverRootController class]] || [viewController isKindOfClass:[MessageRootController class]] || [viewController isKindOfClass:[TGLHomepageController class]]) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }
     */
    return [super popToViewController:viewController animated:animated];
}
-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

 -(void) back
{
    #warning 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}
-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
