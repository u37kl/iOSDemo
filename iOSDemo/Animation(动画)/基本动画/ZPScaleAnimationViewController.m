//
//  ZPScaleAnimationViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/8/30.
//  Copyright © 2018年 ww. All rights reserved.
//

/*
 static NSString *kCAScale = @"transform.scale";
 static NSString *kCAScaleX = @"transform.scale.x";
 static NSString *kCAScaleY = @"transform.scale.y";
 static NSString *kCAScaleZ = @"transform.scale.z";
 */

#import "ZPScaleAnimationViewController.h"
#import "JFSKinManager.h"
#import "Masonry.h"

@interface ZPScaleAnimationViewController ()<CAAnimationDelegate>
@property (nonatomic, weak) CALayer *sublayer;
@property (nonatomic, assign) short isAnimation; // 0：未定义； 1：开始；2:暂停
@property (nonatomic, assign) short tag;
@end
//cm2_play_disc
@implementation ZPScaleAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    self.tag = 0;
    
    
    CALayer *layer = [[CALayer alloc] init];
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"Resource"ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [resourceBundle pathForResource:@"icon1" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    layer.contents = (__bridge id _Nullable)image.CGImage;
    layer.position = CGPointMake(kDeviceWidth *0.5, kRootViewHeight * 0.5);
    layer.bounds = CGRectMake(0, 0, 155, 155);
    [self.view.layer addSublayer:layer];
    
    CALayer *superLayer = [[CALayer alloc] init];
    superLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"cm2_play_disc"].CGImage);
    superLayer.position = CGPointMake(layer.bounds.size.width *0.5, layer.bounds.size.width * 0.5);
    superLayer.bounds = CGRectMake(0, 0, 238, 238);
    [layer addSublayer:superLayer];
    self.sublayer = layer;
    
    UIButton *btnX = [[UIButton alloc] init];
    btnX.titleLabel.font = [UIFont systemFontOfSize:10];
    [btnX setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnX setTitle:@"X轴方向缩放" forState:UIControlStateNormal];
    btnX.tag = 1;
    [btnX addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnX];
    [btnX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *btnY = [[UIButton alloc] init];
    btnY.titleLabel.font = [UIFont systemFontOfSize:10];
    [btnY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnY setTitle:@"Y轴方向缩放" forState:UIControlStateNormal];
    btnY.tag = 2;
    [btnY addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnY];
    [btnY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.left.equalTo(btnX.mas_right);
        make.width.equalTo(btnX.mas_width);
    }];
    
    UIButton *btnZ = [[UIButton alloc] init];
    btnZ.titleLabel.font = [UIFont systemFontOfSize:10];
    [btnZ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnZ setTitle:@"Z轴方向缩放" forState:UIControlStateNormal];
    btnZ.tag = 3;
    [btnZ addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZ];
    [btnZ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.left.equalTo(btnY.mas_right);
        make.width.equalTo(btnY.mas_width);
    }];
    
    UIButton *btnXY = [[UIButton alloc] init];
    btnXY.titleLabel.font = [UIFont systemFontOfSize:10];
    [btnXY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnXY setTitle:@"沿XY轴旋转" forState:UIControlStateNormal];
    btnXY.tag = 4;
    [btnXY addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnXY];
    [btnXY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.left.equalTo(btnZ.mas_right);
        make.width.equalTo(btnZ.mas_width);
    }];
}

-(void)handleAnimation:(UIButton *)btn
{
    if (btn.tag == 1) {
        [self createAnimation_X:[NSNumber numberWithFloat:0.5]];
    }else if(btn.tag == 2){
        [self createAnimation_Y:[NSNumber numberWithFloat:0.5]];
    }else if(btn.tag == 3){
        // 从右向左压缩
        CATransform3D tranform = CATransform3DMakeScale(0.5, 1, 1);
        tranform.m41 = - 155 * 0.5;
        [self createAnimation_Z:[NSValue valueWithCATransform3D:tranform]];
    }else if(btn.tag == 4){
        // 从左到右压缩
        CATransform3D tranform = CATransform3DMakeScale(0.5, 1, 1);
        tranform.m41 = 155 * 0.5;
        [self createAnimation_Z:[NSValue valueWithCATransform3D:tranform]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)createAnimation_X:(NSNumber *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.delegate = self;
    animation.duration = 1;
    animation.toValue = value;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.sublayer addAnimation:animation forKey:@"animation"];
}

- (void)createAnimation_Y:(NSNumber *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.delegate = self;
    animation.duration = 1;
    animation.toValue = value;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.sublayer addAnimation:animation forKey:@"animation"];
}

- (void)createAnimation_Z:(NSValue *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.duration = 1;
    animation.toValue = value;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.sublayer addAnimation:animation forKey:@"animation"];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    CGFloat value = [(NSNumber *)[anim valueForKey:@"CABasicAnimation"] floatValue];
    
    self.sublayer.transform = CATransform3DIdentity;
    
    //提交事务
    [CATransaction commit];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
