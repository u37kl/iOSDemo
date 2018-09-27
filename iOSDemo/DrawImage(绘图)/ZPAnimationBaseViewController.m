//
//  ZPAnimationBaseViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/8/21.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPAnimationBaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZPLayer.h"
@interface ZPAnimationBaseViewController ()
@property (nonatomic, weak) ZPLayer *layer;
@end

@implementation ZPAnimationBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ZPLayer *layer = [[ZPLayer alloc] init];
    // 设置图层的锚点
    layer.anchorPoint = CGPointMake(0, 0);
    // 设置图层中心点对于父图层左上角(原点)的位置
    layer.position = CGPointMake(20, 20);
    // 设置图层的大小
    layer.bounds = CGRectMake(0, 0, 100, 100);
    // 设置图层内容
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"icon4"].CGImage);
    // 将图层添加到父图层中
    [self.view.layer addSublayer:layer];
    layer.delegate = layer;
    self.layer = layer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.layer setNeedsDisplay];
}

-(UIImage *)getImage
{
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(80, 40)];
    [path addLineToPoint:CGPointMake(40, 80)];
    [path addLineToPoint:CGPointMake(40, 40)];
    [[UIColor redColor] set];
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
