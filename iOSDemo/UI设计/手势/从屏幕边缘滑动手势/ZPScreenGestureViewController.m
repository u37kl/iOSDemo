//
//  ZPScreenGestureViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/29.
//  Copyright © 2018年 ww. All rights reserved.
//

// UIPanGestureRecognizer手势的子类
#import "ZPScreenGestureViewController.h"
#import "JFSKinManager.h"
#import "UIGestureRecognizer+Name.h"
#import "Masonry.h"
@interface ZPScreenGestureViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ZPScreenGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandleRoot:)];
    pan.gestureName = @"根view";
    // 识别从屏幕左边侧滑的手势
    pan.edges = UIRectEdgeLeft;
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)panGestureHandleRoot:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"panGestureHandleRoot");
}



@end
