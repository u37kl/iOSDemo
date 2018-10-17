//
//  ZPBaseNavigationController.m
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseNavigationController.h"
#import "JFSKinManager.h"
@interface ZPBaseNavigationController ()

@end

@implementation ZPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [JFSKinManager skinManager].model.themeColor;
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
