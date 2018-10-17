//
//  ZPViewController.m
//  iOSDemo
//
//  Created by ww on 2018/9/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseViewController.h"
#import "JFSKinManager.h"
@interface ZPBaseViewController ()

@end

@implementation ZPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
