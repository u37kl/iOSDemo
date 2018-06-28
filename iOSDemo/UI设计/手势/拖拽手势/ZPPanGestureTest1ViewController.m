//
//  ZPPanGestureTest1ViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/28.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPPanGestureTest1ViewController.h"
#import "Masonry.h"
#import "JFSKinManager.h"
#import "UIView+Frame.h"
#import "UIGestureRecognizer+Name.h"
@interface ZPPanGestureTest1ViewController ()
@property (nonatomic, weak) UIView *redView;
@end

@implementation ZPPanGestureTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    [self loadViewCenterView];
}

- (void)loadViewCenterView
{
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(20);
        make.height.width.mas_equalTo(60);
    }];
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(panGestureHandle:)];
    pan1.delegate = self;
    [redView addGestureRecognizer:pan1];
    pan1.gestureName = @"红色+Pan";
}

-(void)panGestureHandle:(UIPanGestureRecognizer *)gesture
{
    CGPoint p = [gesture translationInView:gesture.view];
    
//    self.redView.center_X = self.redView.center_X + p.x;
//    self.redView.center_Y = self.redView.center_Y + p.y;
    self.redView.transform = CGAffineTransformTranslate(self.redView.transform, p.x, p.y);
    [gesture setTranslation:CGPointZero inView:gesture.view];
    NSLog(@"%@ --- %@",NSStringFromCGPoint(self.redView.frame.origin), NSStringFromCGAffineTransform(self.redView.transform));
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
