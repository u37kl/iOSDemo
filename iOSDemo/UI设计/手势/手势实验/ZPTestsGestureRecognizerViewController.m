//
//  ZPTest1GestureRecognizerViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/27.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTestsGestureRecognizerViewController.h"
#import "UIGestureRecognizer+Name.h"
#import "JFSKinManager.h"
#import "Masonry.h"
@interface ZPTestsGestureRecognizerViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *blueView;
@property (nonatomic, weak) UIView *greenView;
@end

@implementation ZPTestsGestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
//    pan.gestureName = @"根view";
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
    [self loadViewCenterView];
}

- (void)loadViewCenterView
{
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    self.blueView = blueView;
    [self.view addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(panGestureHandle:)];
    pan1.delegate = self;
    [blueView addGestureRecognizer:pan1];
    pan1.gestureName = @"橙色+Pan";
    
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(swipeGestureHandle:)];
    swipe1.delegate = self;
    [blueView addGestureRecognizer:swipe1];
    swipe1.gestureName = @"橙色+Swipe";
//    [pan1 requireGestureRecognizerToFail:swipe1];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor orangeColor];
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(panGestureHandle:)];
    pan2.delegate = self;
    pan2.gestureName = @"橙色view";
    [greenView addGestureRecognizer:pan2];
    self.greenView = greenView;
    [self.view addSubview:greenView];
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(blueView.mas_right);
        make.right.bottom.equalTo(self.view);
        make.width.equalTo(blueView);
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint vP = [pan velocityInView:gestureRecognizer.view];
        NSLog(@"%@", NSStringFromCGPoint(vP));
        if (vP.x < 600) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

#pragma mark - 拖拽手势识别
-(void)panGestureHandle:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"gestureName --- %@", gesture.gestureName);
}

#pragma mark - 轻扫手势识别
-(void)swipeGestureHandle:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"gestureName --- %@", gesture.gestureName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
