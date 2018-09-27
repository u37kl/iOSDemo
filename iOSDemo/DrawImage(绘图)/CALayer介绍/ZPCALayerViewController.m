//
//  ZPCALayerViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/9/21.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPCALayerViewController.h"
#import "Masonry.h"
@interface ZPCALayerViewController ()<CALayerDelegate>
@property (nonatomic, weak) CALayer *superLayer;
@property (nonatomic, weak) CALayer *subLayer;
@end

@implementation ZPCALayerViewController

// 实现CALayerDelegate协议 -- 进行CALayer自动布局

-(void)loadBtnView
{
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setTitle:@"放大" forState:UIControlStateNormal];
    [btn1 setTitle:@"放大" forState:UIControlStateHighlighted];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"缩小" forState:UIControlStateNormal];
    [btn2 setTitle:@"缩小" forState:UIControlStateHighlighted];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.view);
        make.width.equalTo(btn1);
        make.left.equalTo(btn1.mas_right);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark - 测试图层自动布局
-(void)createLayerForAutoLayout
{
    CALayer *superLayer = [[CALayer alloc] init];
    superLayer.position = CGPointMake(170, 250);
    superLayer.bounds = CGRectMake(0, 0, 300, 300);
    superLayer.anchorPoint = CGPointMake(0.5, 0.5);
    superLayer.cornerRadius = 20;
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;
    
    CALayer *subLayer = [[CALayer alloc] init];
    subLayer.position = CGPointMake(150, 150);
    subLayer.bounds = CGRectMake(0, 0, 250, 50);
    subLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [superLayer addSublayer:subLayer];
    self.subLayer = subLayer;
    
    // 设置父图层自动布局属性，当图层bounds改变或者调用setNeedsDisplay时，调用代理方法@selector(layoutSublayersOfLayer:)
    superLayer.delegate = self;
}
#pragma mark - 测试阴影属性
-(void)createLayerForShadow
{
    CALayer *superLayer = [[CALayer alloc] init];
    superLayer.position = CGPointMake(170, 250);
    superLayer.bounds = CGRectMake(0, 0, 300, 300);
    superLayer.anchorPoint = CGPointMake(0.5, 0.5);
    superLayer.delegate = self;
    superLayer.cornerRadius = 20;
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;
    
    CALayer *subLayer = [[CALayer alloc] init];
    subLayer.position = CGPointMake(150, 150);
    subLayer.bounds = CGRectMake(0, 0, 250, 50);
    subLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [superLayer addSublayer:subLayer];
    self.subLayer = subLayer;
    
    superLayer.shadowColor = [UIColor blackColor].CGColor;
    superLayer.shadowOffset = CGSizeMake(10, 10);
    superLayer.shadowOpacity = 0.5f;
    superLayer.shadowRadius = 1;
    
    superLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"shadow"].CGImage); // 设置内容
//    superLayer.backgroundColor = [UIColor redColor].CGColor; // 设置父图层颜色
    subLayer.backgroundColor = [UIColor blueColor].CGColor; // 设置子图层颜色
    
    CGPathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, superLayer.bounds);
    superLayer.shadowPath = path;
  
}

#pragma mark - 测试图层的mask属性
-(void)createLayerForMask
{
    CALayer *superLayer = [[CALayer alloc] init];
    superLayer.position = CGPointMake(170, 250);
    superLayer.bounds = CGRectMake(0, 0, 86, 86);
    superLayer.anchorPoint = CGPointMake(0.5, 0.5);
    superLayer.backgroundColor = [UIColor blueColor].CGColor;
    superLayer.delegate = self;
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;
    
    CALayer *subLayer = [[CALayer alloc] init];
    subLayer.position = CGPointMake(43, 43);
    subLayer.bounds = CGRectMake(0, 0, 86, 86);
    subLayer.cornerRadius = 10;
    subLayer.backgroundColor = [UIColor redColor].CGColor;
    subLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"shadow"].CGImage); // 设置内容
    subLayer.anchorPoint = CGPointMake(0.5, 0.5);

    superLayer.mask = subLayer;
}

#pragma mark - 测试图层的组透明
-(void)createLayerForAlpha
{
    CALayer *superLayer = [[CALayer alloc] init];
    superLayer.position = CGPointMake(170, 250);
    superLayer.bounds = CGRectMake(0, 0, 100, 100);
    superLayer.anchorPoint = CGPointMake(0.5, 0.5);
    superLayer.cornerRadius = 20;
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;

    CALayer *subLayer = [[CALayer alloc] init];
    subLayer.borderWidth = 2.0;
    subLayer.borderColor = [UIColor blueColor].CGColor;
    subLayer.position = CGPointMake(50, 50);
    subLayer.bounds = CGRectMake(0, 0, 50, 50);
    subLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [superLayer addSublayer:subLayer];
    self.subLayer = subLayer;

    // 设置当前图层透明，而不影响子图层的透明度
    superLayer.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5].CGColor;
    subLayer.backgroundColor = [UIColor redColor].CGColor;
    // 子图层透明 = 子图层50%自身颜色，25%的SuperLayer颜色，25%根图层的颜色，因此subLayer和SuperLayer图层颜色透明度相同，但是效果不同
//    superLayer.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5].CGColor;
//    subLayer.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5].CGColor;
    
     // 组透明，保证父图层和子图层的颜色透明一样(不会出现透明度混合)，测试结果是使用不使用shouldRasterize和rasterizationScale没啥变化
//    superLayer.backgroundColor = [UIColor redColor].CGColor;
//    subLayer.backgroundColor = [UIColor redColor].CGColor;
//    superLayer.opacity = 0.5;
//    superLayer.shouldRasterize = YES;
//    superLayer.rasterizationScale = [UIScreen mainScreen].scale;
}

#pragma mark - 测试图层的仿射变换
-(void)createLayerForTranform
{
    CALayer *superLayer = [[CALayer alloc] init];
    superLayer.position = CGPointMake(170, 250);
    superLayer.bounds = CGRectMake(0, 0, 100, 100);
    superLayer.anchorPoint = CGPointMake(0.5, 0.5);
    superLayer.cornerRadius = 20;
    subLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"shadow"].CGImage); // 设置内容
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBtnView];
//    [self createLayerForShadow];    // 设置图层的阴影
//    [self createLayerForMask];        // 设置图层蒙版
    [self createLayerForAlpha]; // 组透明
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.superLayer.delegate = nil;

    
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    if (layer.sublayers.count <= 0) {
        return;
    }
    CALayer *subLayer = layer.sublayers.firstObject;
    subLayer.bounds = CGRectMake(0, 0, layer.bounds.size.width - 150, layer.bounds.size.height - 150);
    subLayer.position = CGPointMake(layer.bounds.size.width / 2, layer.bounds.size.height / 2);
}

- (void)btn1Click
{
    self.superLayer.bounds = CGRectMake(0, 0, 300, 300);
}

-(void)btn2Click
{
    self.superLayer.bounds = CGRectMake(0, 0, 100, 100);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.superLayer.position = CGPointMake(170, 500);
//    NSLog(@"参照父图层左上角为原点 - %@", NSStringFromCGPoint(self.subLayer.position));
//    CGPoint newPoint = [self.view.layer convertPoint:self.subLayer.position fromLayer:self.superLayer];
//    NSLog(@"参照根图层左上角为原点 - %@", NSStringFromCGPoint(newPoint));
//    CGPoint newPoint1 = [self.view.layer convertPoint:self.superLayer.position toLayer:self.subLayer];
//    NSLog(@"根图层相对于子图层的位置 - %@", NSStringFromCGPoint(newPoint1));
//
//    CGPoint newPoint2 = [self.superLayer convertPoint:self.subLayer.position toLayer:self.view.layer];
//    NSLog(@"根图层相对于子图层的位置 - %@", NSStringFromCGPoint(newPoint2));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
