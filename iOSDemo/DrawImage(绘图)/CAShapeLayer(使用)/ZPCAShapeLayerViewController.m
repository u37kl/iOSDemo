//
//  ZPCAShapeLayerViewController.m
//  iOSDemo
//
//  Created by ww on 2018/10/16.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPCAShapeLayerViewController.h"

@interface ZPCAShapeLayerViewController ()

@end

@implementation ZPCAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createCornerImage];
    [self createDrawImage];
}


// 绘制一个火柴人
-(void)createDrawImage
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.view.layer addSublayer:shapeLayer];
}

// 绘制一个圆角图片
-(void)createCornerImage
{
    CAShapeLayer *layper = [[CAShapeLayer alloc] init];
    layper.frame = CGRectMake(0, 0, 200, 200);    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, layper.frame.size.width, layper.frame.size.height) byRoundingCorners:corners cornerRadii:radii];
    layper.path = path.CGPath;
    
    CALayer *imageLayer = [[CALayer alloc] init];
    imageLayer.frame = CGRectMake(50, 50, 200, 200);
    imageLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tranform"].CGImage);
    imageLayer.mask = layper;
    
    [self.view.layer addSublayer:imageLayer];
   
    
    
}

@end
