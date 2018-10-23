//
//  ZPBaseNavigationController.m
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseNavigationController.h"
#import "JFSKinManager.h"
#import "ZPBaseViewController.h"
@interface ZPBaseNavigationController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation ZPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [JFSKinManager skinManager].model.themeColor;
    __weak typeof(self)weakSelf = self;
    self.delegate = weakSelf;
    self.interactivePopGestureRecognizer.delegate = self;
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];//设置导航条颜色和界面颜色相同
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}



-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count > 1) {
        return YES;
    }else{
        return NO;
    }
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[ZPBaseViewController class]]) {
        ZPBaseViewController *vc = (ZPBaseViewController *)viewController;
        [navigationController setNavigationBarHidden:vc.isHiddleNavBar animated:YES];
    }
    
    if (navigationController.viewControllers.count <= 1) {
        viewController.hidesBottomBarWhenPushed = NO;
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
    

}

// 当在执行push或者pop动画时，将导航控制器interactivePopGestureRecognizer.enabled = NO;，导致app卡死。
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count <= 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
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
