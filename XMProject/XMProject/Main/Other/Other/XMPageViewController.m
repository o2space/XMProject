//
//  XMPageViewController.m
//  XMProject
//
//  Created by wukexiu on 16/12/25.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMPageViewController.h"

@interface XMPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property(nonatomic,strong)NSArray *controllers;
@property(nonatomic,strong)UIViewController *superController;
@property(nonatomic,strong)UIPageViewController *pageVc;

@end

@implementation XMPageViewController

- (instancetype)init:(UIViewController *)superController controllers:(NSArray *)controllers{
    self = [super initWithNibName:nil bundle:nil];
    self.controllers = controllers;
    self.superController = superController;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

-(void)setup{
    if (self.controllers.count == 0) {
        return;
    }
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey: UIPageViewControllerOptionSpineLocationKey];
    //[UIPageViewControllerOptionSpineLocationKey]
    UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    page.delegate = self;
    page.dataSource = self;
    [page setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    page.view.frame = self.view.frame;
    self.pageVc = page;
    [self.view addSubview:page.view];
}

- (void)setCurrentSubControllerWith:(NSInteger)index{
    [_pageVc setViewControllers:@[[self.controllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark UIPageViewControllerDelegate,UIPageViewControllerDataSource
/// 前一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_controllers indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return _controllers[index - 1];
}
/// 后一个控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [_controllers indexOfObject:viewController];
    if (index == NSNotFound || index == _controllers.count - 1 ) {
        return nil;
    }
    return _controllers[index + 1];
}
/// 返回控制器数量
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return _controllers.count;
}
/// 跳转到另一个控制器界面时调用
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController *vc = pageViewController.viewControllers[0];
    if (vc == nil) {
        return;
    }
    NSInteger index = [self indexForViewControler:vc];
    if ([_delegate respondsToSelector:@selector(mxPageCurrentSubControllerIndex: pageViewController:)]) {
        [_delegate mxPageCurrentSubControllerIndex:index pageViewController:self];
    }
}
/// 获取当前子控制器的角标
- (NSInteger) indexForViewControler:(UIViewController *)controller{
    return [_controllers indexOfObject:controller];
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
