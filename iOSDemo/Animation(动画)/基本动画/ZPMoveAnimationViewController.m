//
//  ZPMoveAnimationViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/8/30.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPMoveAnimationViewController.h"
#import "JFSKinManager.h"
#import "Masonry.h"
/*
 static NSString *kCATranslation = @"transform.translation";
 static NSString *kCATranslationX = @"transform.translation.x";
 static NSString *kCATranslationY = @"transform.translation.y";
 static NSString *kCATranslationZ = @"transform.translation.z";
 static NSString *kCAPosition = @"position";
 static NSString *kCAPositionX = @"position.x";
 static NSString *kCAPositionY = @"position.y";
 */

@interface ZPMoveAnimationViewController ()<CAAnimationDelegate>
@property (nonatomic, weak) CALayer *sublayer;
@property (nonatomic, assign) short isAnimation; // 0：未定义； 1：开始；2:暂停
@property (nonatomic, assign) short tag;
@end

@implementation ZPMoveAnimationViewController

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
    btnX.titleLabel.font = [UIFont systemFontOfSize:8];
    [btnX setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnX setTitle:@"沿X轴平移" forState:UIControlStateNormal];
    btnX.tag = 1;
    [btnX addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnX];
    [btnX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *btnY = [[UIButton alloc] init];
    btnY.titleLabel.font = [UIFont systemFontOfSize:8];
    [btnY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnY setTitle:@"沿Y轴平移" forState:UIControlStateNormal];
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
    btnZ.titleLabel.font = [UIFont systemFontOfSize:8];
    [btnZ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnZ setTitle:@"沿Z轴平移" forState:UIControlStateNormal];
    btnZ.tag = 3;
    [btnZ addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZ];
    [btnZ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.left.equalTo(btnY.mas_right);
        make.width.equalTo(btnY.mas_width);
    }];
    
    UIButton *btnPX = [[UIButton alloc] init];
    btnPX.titleLabel.font = [UIFont systemFontOfSize:8];
    [btnPX setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPX setTitle:@"positionX增大" forState:UIControlStateNormal];
    btnPX.tag = 4;
    [btnPX addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPX];
    [btnPX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.left.equalTo(btnZ.mas_right);
        make.width.equalTo(btnZ.mas_width);
    }];
    
    UIButton *btnPY = [[UIButton alloc] init];
    btnPY.titleLabel.font = [UIFont systemFontOfSize:8];
    [btnPY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPY setTitle:@"positionY增大" forState:UIControlStateNormal];
    btnPY.tag = 5;
    [btnPY addTarget:self action:@selector(handleAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPY];
    [btnPY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.left.equalTo(btnPX.mas_right);
        make.width.equalTo(btnPX.mas_width);
    }];
}

-(void)handleAnimation:(UIButton *)btn
{
    
    if (self.tag == 0) {
        if (btn.tag == 1) {
            [self createAnimation_X:[NSNumber numberWithFloat:60]];
        }else if(btn.tag == 2){
            [self createAnimation_Y:[NSNumber numberWithFloat:60]];
        }else if(btn.tag == 3){
            [self createAnimation_Z:[NSNumber numberWithFloat:60]];
        }else if(btn.tag == 4){
            [self createAnimation_Position_X:[NSNumber numberWithFloat:320]];
        }else if(btn.tag == 5){
            [self createAnimation_Position_Y:[NSNumber numberWithFloat:700]];
        }
        self.tag = btn.tag;
        self.isAnimation = 1;
    }else if(self.tag != btn.tag){
        [self.sublayer removeAllAnimations];
        if (btn.tag == 1) {
            [self createAnimation_X:[NSNumber numberWithFloat:60]];
        }else if(btn.tag == 2){
            [self createAnimation_Y:[NSNumber numberWithFloat:60]];
        }else if(btn.tag == 3){
            [self createAnimation_Z:[NSNumber numberWithFloat:60]];
        }else if(btn.tag == 4){
            [self createAnimation_Position_X:[NSNumber numberWithFloat:320]];
        }else if(btn.tag == 5){
            [self createAnimation_Position_Y:[NSNumber numberWithFloat:700]];
        }
        self.tag = btn.tag;
        self.isAnimation = 1;
    }else if(self.isAnimation == 1){
        self.isAnimation = 2;
        CFTimeInterval currentTime =  [self.sublayer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.sublayer.speed = 0;
        self.sublayer.timeOffset = currentTime;
    }else if (self.isAnimation == 2){
        
        self.sublayer.speed = 1;
        CFTimeInterval currentTime = CACurrentMediaTime();;
        CFTimeInterval temp = currentTime - self.sublayer.timeOffset;
        self.sublayer.timeOffset = 0;
        self.sublayer.beginTime = temp;
        self.isAnimation = 1;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)createAnimation_X:(NSNumber *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.delegate = self;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = value;
    animation.cumulative = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.sublayer addAnimation:animation forKey:@"animation"];
}

- (void)createAnimation_Y:(NSNumber *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.delegate = self;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = value;
    animation.cumulative = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.sublayer addAnimation:animation forKey:@"animation"];
}

- (void)createAnimation_Z:(NSNumber *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.z"];
    animation.delegate = self;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = value;
    animation.cumulative = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.sublayer addAnimation:animation forKey:@"animation"];
}

- (void)createAnimation_Position_X:(NSNumber *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.delegate = self;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = value;
    animation.cumulative = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self.sublayer addAnimation:animation forKey:@"animation"];
}

- (void)createAnimation_Position_Y:(NSNumber *) value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.delegate = self;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = value;
    animation.cumulative = YES;
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
    CABasicAnimation *baseAnimation = (CABasicAnimation *)anim;
    NSLog(@"%@", baseAnimation.toValue);
    self.sublayer.transform = CATransform3DIdentity;
    
    //提交事务
    [CATransaction commit];
}

@end
