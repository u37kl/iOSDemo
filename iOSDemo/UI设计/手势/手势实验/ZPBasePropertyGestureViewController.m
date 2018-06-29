//
//  ZPBasePropertyGestureViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBasePropertyGestureViewController.h"
#import "JFSKinManager.h"
#import "UIGestureRecognizer+Name.h"
#import "Masonry.h"
@interface ZPBasePropertyGestureViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ZPBasePropertyGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandleRoot:)];
    pan.gestureName = @"根view";
    pan.edges = UIRectEdgeLeft;
    pan.requiresExclusiveTouchType = NO;
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    // 是否取消touch事件的响应
//    pan.cancelsTouchesInView = NO;
    // 当在手势识别的过程中，是否不将事件传递给触摸控件
//    pan.delaysTouchesBegan = YES;
    // 在手势识别失败后，是否延迟0.15ms将事件传递给触摸事件。
//    pan.delaysTouchesEnded = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)panGestureHandleRoot:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"panGestureHandleRoot");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}

@end
