//
//  ZPBezierViewController.m
//  iOSDemo
//
//  Created by ww on 2018/8/31.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBezierViewController.h"
#import "JFSKinManager.h"
#define kLayerHeight 200
#define kMaxHeight 70
@interface ZPBezierViewController ()<CAAnimationDelegate>
@property (nonatomic, weak) CAShapeLayer *layer;
@property (nonatomic, weak) CAShapeLayer *shapeLayer;
@property (nonatomic, weak) CALayer *subLayer;
@property (nonatomic, weak) CALayer *referenceObject;
@property (nonatomic, weak) CAShapeLayer *outWaterLayer;
@property (nonatomic, weak) CADisplayLink *link;
@end

@implementation ZPBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [self getPath:0].CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture1:)];
    [self.view addGestureRecognizer:pan];
    
    CALayer *referenceObjectLayer = [[CALayer alloc] init];
    referenceObjectLayer.bounds = CGRectMake(0, 0, 10, 10);
    referenceObjectLayer.backgroundColor = [UIColor blueColor].CGColor;
    referenceObjectLayer.position = CGPointMake(kDeviceWidth * 0.5, kLayerHeight);
    [self.layer addSublayer:referenceObjectLayer];
    self.referenceObject = referenceObjectLayer;
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.anchorPoint = CGPointMake(0.5, 0.5);
    shapeLayer.lineWidth = 2;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer = shapeLayer;

    CALayer *subLayer = [[CALayer alloc] init];
    subLayer.backgroundColor = [UIColor clearColor].CGColor;
    subLayer.cornerRadius = 20;
    subLayer.masksToBounds = YES;
    subLayer.position = CGPointMake(kDeviceWidth * 0.5, kLayerHeight - 35);
    subLayer.bounds = CGRectMake(0, 0, 40, 40);
    [subLayer addSublayer:shapeLayer];
    [layer addSublayer:subLayer];

    CAShapeLayer *shapeLayer1 = [[CAShapeLayer alloc] init];
    shapeLayer1.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer1.path = [self getSubLayerPath].CGPath;
    [subLayer addSublayer:shapeLayer1];
    self.subLayer = subLayer;

    CAShapeLayer *outWaterLayer = [[CAShapeLayer alloc] init];
    outWaterLayer.strokeColor = [UIColor blueColor].CGColor;
    outWaterLayer.anchorPoint = CGPointMake(0.5, 0.5);
    outWaterLayer.fillColor = [UIColor blueColor].CGColor;
    outWaterLayer.path = [self getOutWaterPath:0].CGPath;
    [self.layer addSublayer:outWaterLayer];
    self.outWaterLayer = outWaterLayer;
    
    self.outWaterLayer.path = [self getOutWaterPath:-30].CGPath;
}

-(UIBezierPath *)getShapePath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(20,20) radius:19 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path closePath];
    return path;
}

-(UIBezierPath *)getSubLayerPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(20, 20) radius:16 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path closePath];
    return path;
}

-(UIBezierPath *)getOutWaterPath:(CGFloat)temp{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, kLayerHeight)];
    [path addQuadCurveToPoint:CGPointMake(kDeviceWidth, kLayerHeight) controlPoint:CGPointMake(kDeviceWidth/2, kLayerHeight+temp)];
    [path addQuadCurveToPoint:CGPointMake(self.subLayer.position.x + self.subLayer.bounds.size.width * 0.5, self.subLayer.position.y) controlPoint:CGPointMake(self.subLayer.position.x + self.subLayer.bounds.size.width * 0.5, kLayerHeight)];
    
    [path addLineToPoint:CGPointMake(self.subLayer.position.x - self.subLayer.bounds.size.width * .5, self.subLayer.position.y)];
    [path addQuadCurveToPoint:CGPointMake(0, kLayerHeight) controlPoint:CGPointMake(kDeviceWidth/2 - self.subLayer.bounds.size.width * .5 , kLayerHeight)];
    [path closePath];
    return path;
}

-(UIBezierPath *)getPath:(CGFloat)temp{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(kDeviceWidth, 0)];
    [path addLineToPoint:CGPointMake(kDeviceWidth, kLayerHeight)];
    [path addQuadCurveToPoint:CGPointMake(0, kLayerHeight) controlPoint:CGPointMake(kDeviceWidth/2, kLayerHeight+temp)];
    
    [path closePath];
    return path;
}

-(void)handleGesture1:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:gesture.view];
        NSLog(@"%@", NSStringFromCGPoint(point));
        self.layer.path = [self getPath:point.y].CGPath;
//        self.referenceObject.position = CGPointMake(self.referenceObject.position.x, kLayerHeight + point.y);
    }else if(gesture.state == UIGestureRecognizerStateEnded){
        CGPoint point = [gesture translationInView:gesture.view];
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshLayer)];
        self.link = link;
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
        animation1.removedOnCompletion = NO;
        animation1.duration = 1;
        animation1.beginTime = 0;
        animation1.fillMode = kCAFillModeForwards;
        animation1.values = @[
                              [NSNumber numberWithDouble:self.referenceObject.position.y + point.y],
                              [NSNumber numberWithDouble:kLayerHeight * 0.7],
                              [NSNumber numberWithDouble:kLayerHeight * 1.2],
                              [NSNumber numberWithDouble:kLayerHeight * 0.9],
                              [NSNumber numberWithDouble:kLayerHeight],
                              ];
        animation1.delegate = self;

        [self.referenceObject addAnimation:animation1 forKey:@"animation"];
    }
}


-(void)refreshLayer
{
    CGFloat temp =  self.referenceObject.presentationLayer.position.y - kLayerHeight;
    NSLog(@"refreshLayer -- %f", temp);
    self.layer.path = [self getPath:temp].CGPath;
    self.outWaterLayer.path = [self getOutWaterPath:temp].CGPath;
}

-(void)handleGesture:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:gesture.view];
        NSLog(@"%@", NSStringFromCGPoint(point));
        self.layer.path = [self getPath:point.y].CGPath;
        self.outWaterLayer.path = [self getOutWaterPath:point.y].CGPath;

    }else if(gesture.state == UIGestureRecognizerStateEnded){
        CGPoint point = [gesture translationInView:gesture.view];
        NSMutableArray *arry = [NSMutableArray arrayWithCapacity:5];
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
        animation1.removedOnCompletion = NO;
        animation1.duration = 0.5;
        animation1.beginTime = 0;
        animation1.fillMode = kCAFillModeForwards;
        animation1.toValue = (__bridge id _Nullable)([self getPath:-40].CGPath);
        [arry addObject:animation1];
        
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
        animation2.removedOnCompletion = NO;
        animation2.duration = 0.5;
        animation2.beginTime = 0.5;
        animation2.fillMode = kCAFillModeForwards;
        animation2.toValue = (__bridge id _Nullable)([self getPath:10].CGPath);
        [arry addObject:animation2];
        
        CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
        animation3.removedOnCompletion = NO;
        animation3.duration = 0.5;
        animation3.beginTime = 1;
        animation3.fillMode = kCAFillModeForwards;
        animation3.toValue = (__bridge id _Nullable)([self getPath:0].CGPath);
        [arry addObject:animation3];
        
        

        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 1.5;
        group.delegate = self;
        group.animations = arry;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        [self.layer addAnimation:group forKey:@"animation"];
        
        self.shapeLayer.path = [self getShapePath].CGPath;
        CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation4.fromValue = @(0.0f);
        animation4.toValue = @(1.0f);
        animation4.duration = 1.5;
        animation4.removedOnCompletion = NO;
        animation4.fillMode = kCAFillModeForwards;
        [self.shapeLayer addAnimation:animation4 forKey:@"shape"];
        
        CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation5.toValue = @(M_PI * 4);
        animation5.duration = 1.5;
        animation5.removedOnCompletion = NO;
        animation5.fillMode = kCAFillModeForwards;
        [self.subLayer addAnimation:animation5 forKey:@"rotation"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [self.referenceObject removeAnimationForKey:@"animation"];
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];

//    self.referenceObject.position = CGPointMake(kDeviceWidth * 0.5, kLayerHeight);

    //提交事务
    [CATransaction commit];

}


//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    [self.layer removeAnimationForKey:@"animation"];
//    [CATransaction begin];
//    //禁用隐式动画
//    [CATransaction setDisableActions:YES];
//
//    self.layer.path = [self getPath:0].CGPath;
//
//    //提交事务
//    [CATransaction commit];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
