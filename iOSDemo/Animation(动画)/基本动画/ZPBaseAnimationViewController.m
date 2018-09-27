//
//  ZPBaseAnimationViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/8/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseAnimationViewController.h"
#import <math.h>
@interface ZPBaseAnimationViewController ()<CAAnimationDelegate>
@property (nonatomic, weak) CALayer *subLayer;
@property (nonatomic, assign) short isAnimation; // 0：未定义； 1：开始；2:暂停
@end

@implementation ZPBaseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
    CALayer *subLayer = [[CALayer alloc] init];
//    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"Resource"ofType:@"bundle"];
//    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
//    NSString *path = [resourceBundle pathForResource:@"icon1" ofType:@"jpg"];
//    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImage *image = [UIImage imageNamed:@"登录"];
    subLayer.contents = (__bridge id _Nullable)(image.CGImage);
    subLayer.frame = CGRectMake(10, 10, 143, 143);
    subLayer.backgroundColor = [UIColor redColor].CGColor;
//    subLayer.contentsRect = CGRectMake(0.25, 0.25, 0.5, 0.5);
//    subLayer.contentsGravity = kCAGravityResizeAspect;
    subLayer.contentsCenter = CGRectMake(0.25, 0.25, 0.75, 0.75);
    [self.view.layer addSublayer:subLayer];
    
    CALayer *subLayer1 = [[CALayer alloc] init];
    subLayer1.contents = (__bridge id _Nullable)(image.CGImage);
    subLayer1.frame = CGRectMake(10, 220, 100, 100);
    subLayer1.backgroundColor = [UIColor redColor].CGColor;
    subLayer1.anchorPoint = CGPointMake(0, 0);
    [self.view.layer addSublayer:subLayer1];
    self.subLayer =subLayer1;
    
}


-(void)animation1Stop:(CABasicAnimation *)anim
{
//    [CATransaction begin];
//    //禁用隐式动画
//    [CATransaction setDisableActions:YES];
//
//    CGPoint value = [[anim valueForKey:@"CABasicAnimation"] CGPointValue];
//    self.subLayer.position = value;
//    //提交事务
//    [CATransaction commit];
}

-(void)animation1{
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.delegate = self;
    animation.keyPath = @"transform";
    double sinB = sin(M_PI/180 * 60);
    double cosB = cos(M_PI/180 * 60);
    CGAffineTransform form = CGAffineTransformMake(cosB, sinB, -sinB, cosB, 0, 0);
    animation.toValue = [NSValue valueWithCGAffineTransform:form] ;
    animation.duration = 5;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.subLayer addAnimation:animation forKey:@"CABasicAnimation"];
}

#pragma mark - 自旋转动画

-(void)openRotateAnimation
{
    if (self.isAnimation == 0) {
        [self animation2:[NSNumber numberWithFloat:M_PI_4]];
        self.isAnimation = 1;
        NSLog(@"----- start ----- ");
        NSLog(@"currentTime= %f, timeOff= %f", CACurrentMediaTime(), self.subLayer.timeOffset);
    }else if(self.isAnimation == 1){
        self.isAnimation = 2;
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval pauseTime = [self.subLayer convertTime:currentTime fromLayer:nil];
        self.subLayer.timeOffset = pauseTime;
        self.subLayer.speed = 0;
        NSLog(@"----- pause ----- ");
        NSLog(@"currentTime= %f, timeOff= %f", currentTime, self.subLayer.timeOffset);
    }else if(self.isAnimation == 2){
        self.isAnimation = 1;
        self.subLayer.speed = 1;
        CFTimeInterval pauseTime = self.subLayer.timeOffset;
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval timeSincePause = currentTime - pauseTime;
        // 取消
        self.subLayer.timeOffset = 0;
        // local time相对于parent time世界的beginTime
        self.subLayer.beginTime = timeSincePause;
        
        NSLog(@"----- Resume ----- ");
        NSLog(@"currentTime= %f, timeOff= %f, beginTime= %f", currentTime, pauseTime, self.subLayer.beginTime);
    }
}

-(void)animation2:(NSNumber *)value{
    [self.subLayer removeAllAnimations];
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.autoreverses = YES;
    animation.delegate = self;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    animation.keyPath = @"transform.rotation.z";
//    animation.fromValue = @([value floatValue] - M_PI_4);
    animation.toValue= value;
    [animation setValue:animation.toValue forKey:@"CABasicAnimation"];
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
//    self.subLayer.anchorPoint = CGPointMake(0.5, 0);
    [self.subLayer addAnimation:animation forKey:@"CABasicAnimation"];
}

-(void)animation2Stop:(CABasicAnimation *)anim
{
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    CGFloat value = [(NSNumber *)[anim valueForKey:@"CABasicAnimation"] floatValue];
    self.subLayer.transform = CATransform3DRotate(self.subLayer.transform, M_PI_4, 0, 0, 1);
    
    //提交事务
    [CATransaction commit];
}


- (void)rotateView

{
    
    CABasicAnimation *rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    
    rotationAnimation.duration = 1;
    
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.subLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 [self.subLayer display];
    [self animation1];
//    [self openRotateAnimation];
    
}


#pragma mark - 动画开始与完成的代理方法
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self animation2Stop:anim];


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
