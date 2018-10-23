//
//  ZPTabBarViewController.m
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTabBarViewController.h"
#import "ZPMainModuleManager.h"
#import "ZPBaseNavigationController.h"
#import "ZPInterfaceViewController.h"
#import <Otherframework/Otherframework.h>
@interface ZPTabBarViewController ()

@end

@implementation ZPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadChildModule];
    self.tabBar.backgroundColor = [JFSKinManager skinManager].model.frontColor;
    self.tabBar.backgroundImage = [UIImage new];
    
}

-(void)loadChildModule
{
    NSArray <ZPMainModuleModelProtocol>* modelList = [ZPMainModuleManager getMainModule];
    for (short i = 0; i<modelList.count; i++) {
        id<ZPMainModuleModelProtocol> model = modelList[i];
        [self addChildViewControllerWithModel:model tabBarIndex:i];
    }
    self.selectedIndex = 0;
}

-(void)addChildViewControllerWithModel:(id<ZPMainModuleModelProtocol>)model tabBarIndex:(NSInteger)tag
{
    UIViewController *vc = [[NSClassFromString(model.className) alloc] init];
    vc.title = model.title;
    // 配置tabBar按钮文字和图片
    UIImage *selectedImage = [UIImage imageNamed:model.iconSelected];
    if (iOS7) {
       selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:model.title image:[UIImage imageNamed:model.iconNormal] selectedImage:selectedImage];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont getPFRWithSize:10],NSForegroundColorAttributeName:[JFSKinManager skinManager].model.tabBarTitleNormalColor}  forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont getPFRWithSize:10],NSForegroundColorAttributeName:[JFSKinManager skinManager].model.tabBarTitleSelectedColor} forState:UIControlStateSelected];

    vc.tabBarItem = item;
    vc.tabBarItem.tag = tag;

    ZPBaseNavigationController *nav = [[ZPBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
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
