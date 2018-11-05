//
//  ZPBaseQuarzeView.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/30.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseQuarzeView.h"

@implementation ZPBaseQuarzeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.layer.borderWidth = 5;
    self.layer.borderColor = [JFSKinManager skinManager].model.separatorLineColor.CGColor;
    switch (self.type) {
        case ZPBaseQuarzeViewTypeRects:
        {
            [self createRect];
            break;
        }
            
        case ZPBaseQuarzeViewTypeCircle:
        {
            [self createCircular];
            break;
        }
            
        case ZPBaseQuarzeViewTypeRoundRect:
        {
            [self createRoundRect];
            break;
        }
            
        case ZPBaseQuarzeViewTypeHalfRound:
        {
            [self createHalfCircular];
            break;
        }
            
        case ZPBaseQuarzeViewTypeOval:
        {
            [self createOval];
            break;
        }
            
        case ZPBaseQuarzeViewTypeDashed:
        {
            [self createDashedLine];
            break;
        }
            
        case ZPBaseQuarzeViewTypeCurveLine:
        {
            [self createCurveLine];
            break;
        }
            
        default:
        {
            [self createLine];
            break;
        }
    }
}

#pragma mark - 创建圆角矩形
-(void)createRoundRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRoundedRect(path, NULL, CGRectMake(20, 20, 60, 60), 20, 10);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    CGPathRelease(path);
}

#pragma mark - 创建椭圆
-(void)createOval
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGPathAddEllipseInRect(path, NULL, CGRectMake(20, 35, 60, 30));
        CGContextAddPath(context, path);
//    CGContextAddEllipseInRect(context, CGRectMake(20, 35, 60, 30));  不手动创建路径画椭圆
    CGContextFillPath(context);
    
    CGPathRelease(path);
}

#pragma mark - 创建圆形
-(void)createCircular
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(20, 20, 60, 60));
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    CGPathRelease(path);
}

#pragma mark - 创建饼图
-(void)createHalfCircular
{
    /*
       绘制饼图 == 绘制多个扇形
       图形上下文只能保存一个画笔的颜色、尺寸。
       因此如果需要不同颜色组成的饼图，需要进行多次的绘制。
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 50, 50, 30, 0, M_PI_4, NO);
    CGPathAddLineToPoint(path, NULL, 50, 50);
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    path = CGPathCreateMutable();
    CGPathAddRelativeArc(path, NULL, 50, 50, 30, M_PI_4, 120*M_PI/180);
//    CGPathAddArc(path, NULL, 50, 50, 30, M_PI_4, 120*M_PI/180, NO);
    CGPathAddLineToPoint(path, NULL, 50, 50);
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillPath(context);
    
    path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 50, 50, 30, 120*M_PI/180, 180*M_PI/180, NO);
    CGPathAddLineToPoint(path, NULL, 50, 50);
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillPath(context);
    
    path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 50, 50, 30, 180*M_PI/180, 300*M_PI/180, NO);
    CGPathAddLineToPoint(path, NULL, 50, 50);
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextFillPath(context);
    
    path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 50, 50, 30, 300*M_PI/180, 360*M_PI/180, NO);
    CGPathAddLineToPoint(path, NULL, 50, 50);
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillPath(context);
    
    CGPathRelease(path);
}

#pragma mark - 创建矩形
-(void)createRect
{
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(20, 20, 60, 60));
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 3);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    CGPathRelease(path);
 
}

#pragma mark - 创建虚线
-(void)createDashedLine
{
    // 获取当前控件的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建绘画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 20, 20);
    CGPathAddLineToPoint(path, NULL, 80, 20);
    CGPathAddLineToPoint(path, NULL, 80, 80);
    CGPathAddLineToPoint(path, NULL, 20, 80);
    // 将起点和终点用线段连接起来
    CGPathCloseSubpath(path);

    /*
     path：要进行虚线化的路径
     phase：从lengths数组的第几部分开始绘制虚线
     lengths:C风格的数组 其中为CGFloat值 表示每段虚线的绘制长度 例如传入数组为{5,10}，则虚线的先绘制长度为5的实线 在绘制长度为10虚线 在进行循环
     count：这个参数需要设置为lengths数组的长度
     */
//    CGFloat ag[2] = {5, 10};
    CGFloat ag[2] = {2, 10};
    CGPathRef path1 = CGPathCreateCopyByDashingPath(path, NULL, 0, ag, 2);
    CGPathRelease(path);
    // 将路径添加到上下文中
    CGContextAddPath(context, path1);
    [[UIColor redColor] set];
//    CGContextSetLineWidth(context, 5);
    // 设置线的连接处的形状
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    // 设置线的端点的形状
//    CGContextSetLineCap(context, kCGLineCapRound);
    // 将上下文中的路径绘制到控件上
    CGContextStrokePath(context);
    
    CGPathRelease(path1);
    
}

#pragma mark - 创建线
-(void)createLine
{
    // 获取当前控件的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建绘画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 20, 20);
    CGPathAddLineToPoint(path, NULL, 80, 20);
    CGPathAddLineToPoint(path, NULL, 80, 80);
    CGPathAddLineToPoint(path, NULL, 20, 80);
    CGPathAddLineToPoint(path, NULL, 20, 20);
    // 将路径添加到上下文中
    CGContextAddPath(context, path);
    [[UIColor redColor] set];
    CGContextSetLineWidth(context, 5);
    // 设置线的连接处的形状
    CGContextSetLineJoin(context, kCGLineJoinRound);
    // 设置线的端点的形状
    CGContextSetLineCap(context, kCGLineCapRound);
    // 将上下文中的路径绘制到控件上
    CGContextStrokePath(context);

    CGPathRelease(path);
}

#pragma mark - 创建曲线
-(void)createCurveLine
{
    CGFloat halfHeight = self.bounds.size.height/2;
    // 获取当前控件的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建绘画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 20, halfHeight);
    CGPathAddQuadCurveToPoint(path, NULL, 40, halfHeight-60, 80, halfHeight);
    CGPathMoveToPoint(path, NULL, 20, halfHeight);
    CGPathAddQuadCurveToPoint(path, NULL, 40, halfHeight+60, 80, halfHeight);
//    CGPathCloseSubpath(path);
    // 将路径添加到上下文中
    CGContextAddPath(context, path);
    [[UIColor redColor] set];
    CGContextSetLineWidth(context, 5);
    // 设置线的连接处的形状
    CGContextSetLineJoin(context, kCGLineJoinRound);
    // 设置线的端点的形状
    CGContextSetLineCap(context, kCGLineCapRound);
    // 将上下文中的路径绘制到控件上
    CGContextStrokePath(context);
    
    CGPathRelease(path);
}


@end
