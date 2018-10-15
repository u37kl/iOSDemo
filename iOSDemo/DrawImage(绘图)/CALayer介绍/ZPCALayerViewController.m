//
//  ZPCALayerViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/9/21.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPCALayerViewController.h"
#import "Masonry.h"
#import <math.h>
#import "ZPBlockButton.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface ZPCALayerViewController ()<CALayerDelegate>
@property (nonatomic, weak) CALayer *superLayer;
@property (nonatomic, weak) CALayer *subLayer;
@property (nonatomic, weak) ZPBlockButton *leftBtn0;
@property (nonatomic, weak) ZPBlockButton *leftBtn1;
@property (nonatomic, weak) ZPBlockButton *leftBtn2;
@property (nonatomic, weak) ZPBlockButton *leftBtn3;
@property (nonatomic, weak) ZPBlockButton *leftBtn4;
@property (nonatomic, strong) CABasicAnimation *animation;
@property (nonatomic, assign) CGFloat angle;

@property (nonatomic, strong) NSMutableArray *btnArrList;
@end

@implementation ZPCALayerViewController

// 实现CALayerDelegate协议 -- 进行CALayer自动布局

-(void)loadBtnView
{
    ZPBlockButton *btn1 = [[ZPBlockButton alloc] init];
    [btn1 setTitle:@"缩放" forState:UIControlStateNormal];
    [btn1 setTitle:@"缩放" forState:UIControlStateHighlighted];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn1.backgroundColor = [UIColor blueColor];
    self.leftBtn0 = btn1;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    ZPBlockButton *btn3 = [[ZPBlockButton alloc] init];
    [btn3 setTitle:@"仿射缩放" forState:UIControlStateNormal];
    [btn3 setTitle:@"仿射缩放" forState:UIControlStateHighlighted];
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn3];
    self.leftBtn1 = btn3;
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(btn1.mas_right);
        make.width.equalTo(btn1);
        make.height.mas_equalTo(60);
    }];
    
    ZPBlockButton *btn4 = [[ZPBlockButton alloc] init];
    [btn4 setTitle:@"仿射旋转" forState:UIControlStateNormal];
    [btn4 setTitle:@"仿射旋转" forState:UIControlStateHighlighted];
    btn4.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn4.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:btn4];
    self.leftBtn2 = btn4;
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(btn3.mas_right);
        make.width.equalTo(btn3);
        make.height.mas_equalTo(60);
    }];
    
    ZPBlockButton *btn5 = [[ZPBlockButton alloc] init];
    [btn5 setTitle:@"仿射平移" forState:UIControlStateNormal];
    [btn5 setTitle:@"仿射平移" forState:UIControlStateHighlighted];
    btn5.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn5.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:btn5];
    self.leftBtn3 = btn5;
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(btn4.mas_right);
        make.width.equalTo(btn4);
        make.height.mas_equalTo(60);
    }];
    
    ZPBlockButton *btn6 = [[ZPBlockButton alloc] init];
    [btn6 setTitle:@"混合变换" forState:UIControlStateNormal];
    [btn6 setTitle:@"混合变换" forState:UIControlStateHighlighted];
    btn6.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn6.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn6];
    self.leftBtn4 = btn6;
    [btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.view);
        make.width.equalTo(btn5);
        make.left.equalTo(btn5.mas_right);
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
    
    __weak typeof(self)weakSelf = self;
    [self.leftBtn0 setHandleClickEvent:^(UIButton *btn) {
        if (weakSelf.superLayer.bounds.size.width == 300) {
            weakSelf.superLayer.bounds = CGRectMake(0, 0, 100, 100);
        }else{
            weakSelf.superLayer.bounds = CGRectMake(0, 0, 300, 300);
        }
    }];
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
    superLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tranform"].CGImage); // 设置内容
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;
}

#pragma mark - 测试图层的扁平化
-(void)createLayerForFlattening
{
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 =  -1.0 / 100.0;
    self.view.layer.sublayerTransform = trans;
    
    CALayer *superLayer = [[CALayer alloc] init];
    superLayer.position = CGPointMake(self.view.center.x, kRootViewHeight*0.5);
    superLayer.bounds = CGRectMake(0, 0, 100, 100);
    superLayer.anchorPoint = CGPointMake(0.5, 0.5);
    superLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;
    
    CALayer *subLayer = [[CALayer alloc] init];
    subLayer.position = CGPointMake(50, 50);
    subLayer.bounds = CGRectMake(0, 0, 50, 50);
    subLayer.backgroundColor = [UIColor blueColor].CGColor;
    subLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [superLayer addSublayer:subLayer];
    self.subLayer = subLayer;
    
    CATransform3D outer = CATransform3DIdentity;
//    outer.m34 = -1.0 / 100.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.superLayer.transform = outer;
    
    CATransform3D inner =CATransform3DIdentity;
//    inner.m34 = -1.0 / 100.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.subLayer.transform = inner;

}


#pragma mark - 测试图层的ZPosition
// 设置修改图层的显示顺序，不会改变实际的图层顺序，即点击交集部分，subLayer按钮响应。
-(void)createLayerForZPotition
{
    
    ZPBlockButton *superLayer = [[ZPBlockButton alloc] init];
    superLayer.backgroundColor = [UIColor redColor];
    [self.view addSubview:superLayer];
    [superLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
    }];
    
    ZPBlockButton *subLayer = [[ZPBlockButton alloc] init];
    subLayer.backgroundColor = [UIColor blueColor];
    [self.view addSubview:subLayer];
    [subLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superLayer.mas_right).offset(-50);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(100);
         make.right.equalTo(self.view).offset(-15);
    }];
    superLayer.layer.zPosition = 1;
    
    [superLayer setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"superLayer");
    }];
    
    [subLayer setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"subLayer");
    }];
    
}

#pragma mark - 测试图层的翻转
-(void)createLayerFor3DTranform
{
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 =  -1.0 / 100.0;
    self.view.layer.sublayerTransform = trans;
    CALayer *superLayer = [[CALayer alloc] init];
    
    superLayer.position = CGPointMake(self.view.center.x, kRootViewHeight*0.5);
    superLayer.bounds = CGRectMake(0, 0, 100, 100);
    superLayer.anchorPoint = CGPointMake(0.5, 0.5);
    superLayer.backgroundColor = [UIColor redColor].CGColor;
    superLayer.cornerRadius = 20;
    superLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tranform"].CGImage); // 设置内容
    [self.view.layer addSublayer:superLayer];
    self.superLayer = superLayer;
    superLayer.transform = CATransform3DIdentity;
    
//    CATransform3D trans = CATransform3DIdentity;
//    trans.m34 =  -1.0 / 300.0;
//    self.superLayer.transform = trans;
    
    __weak typeof(self)weakSelf = self;
    [self.leftBtn0 setHandleClickEvent:^(UIButton *btn) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        animation.toValue = @(M_PI/1.5);
        animation.duration = 5;
        animation.repeatCount = MAXFLOAT;
        animation.cumulative = YES;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        self.animation = animation;
        [weakSelf.superLayer addAnimation:animation forKey:@"cell"];
        
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(test)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }];

}


#pragma mark - 测试图层的ZPosition
// 设置修改图层的显示顺序，不会改变实际的图层顺序，即点击交集部分，subLayer按钮响应。
-(void)createLayerFor3D
{
    
    ZPBlockButton *layer1 = [[ZPBlockButton alloc] init];
    layer1.backgroundColor = [UIColor whiteColor];
    [layer1 setTitle:@"1" forState:UIControlStateNormal];
    [layer1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    layer1.layer.borderColor = [UIColor blackColor].CGColor;
    layer1.layer.borderWidth = 0.5;
    [self.view addSubview:layer1];
    [self.btnArrList addObject:layer1];
    [layer1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
    
    ZPBlockButton *layer2 = [[ZPBlockButton alloc] init];
    layer2.backgroundColor = [UIColor whiteColor];
    [layer2 setTitle:@"2" forState:UIControlStateNormal];
    [layer2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    layer2.layer.borderColor = [UIColor blackColor].CGColor;
    layer2.layer.borderWidth = 0.5;
    [self.view addSubview:layer2];
    [self.btnArrList addObject:layer2];
    [layer2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
    
    ZPBlockButton *layer3 = [[ZPBlockButton alloc] init];
    layer3.backgroundColor = [UIColor whiteColor];
    [layer3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [layer3 setTitle:@"3" forState:UIControlStateNormal];
    layer3.layer.borderColor = [UIColor blackColor].CGColor;
    layer3.layer.borderWidth = 0.5;
    [self.view addSubview:layer3];
    [self.btnArrList addObject:layer3];
    [layer3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
    
    ZPBlockButton *layer4 = [[ZPBlockButton alloc] init];
    layer4.backgroundColor = [UIColor whiteColor];
    [layer4 setTitle:@"4" forState:UIControlStateNormal];
    [layer4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    layer4.layer.borderColor = [UIColor blackColor].CGColor;
    layer4.layer.borderWidth = 0.5;
    [self.view addSubview:layer4];
    [self.btnArrList addObject:layer4];
    [layer4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
    
    ZPBlockButton *layer5 = [[ZPBlockButton alloc] init];
    layer5.backgroundColor = [UIColor whiteColor];
    [layer5 setTitle:@"5" forState:UIControlStateNormal];
    [layer5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    layer5.layer.borderColor = [UIColor blackColor].CGColor;
    layer5.layer.borderWidth = 0.5;
    [self.view addSubview:layer5];
    [self.btnArrList addObject:layer5];
    [layer5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
    
    ZPBlockButton *layer6 = [[ZPBlockButton alloc] init];
    layer6.backgroundColor = [UIColor whiteColor];
    [layer6 setTitle:@"6" forState:UIControlStateNormal];
    [layer6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    layer6.layer.borderColor = [UIColor blackColor].CGColor;
    layer6.layer.borderWidth = 0.5;
    [self.view addSubview:layer6];
    [self.btnArrList addObject:layer6];
    [layer6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];

    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.view.layer.sublayerTransform = perspective;
    
    
    [layer1 setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"layer1");
    }];
    [layer2 setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"layer2");
    }];
    
    [layer3 setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"layer3");
    }];
    [layer4 setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"layer4");
    }];
    
    [layer5 setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"layer5");
    }];
    [layer6 setHandleClickEvent:^(UIButton *btn) {
        NSLog(@"layer6");
    }];
    
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
//    UIView *face = self.btnArrList[index];
//    [self.containerView addSubview:face];
    //center the face view within the container
//    CGSize containerSize = self.view.bounds.size;
//    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
//    face.layer.transform = transform;
//    [self applyLightingToFace:face.layer];
    
    UIView *face = self.btnArrList[index];
//    [self.containerView addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.view.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    face.layer.transform = transform;
//    [self applyLightingToFace:face.layer];
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
//    CALayer *layer = [CALayer layer];
//    layer.frame = face.bounds;
//    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D t = face.transform;
//    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix4 matrix4 = GLKMatrix4Make(t.m11, t.m12, t.m13, t.m14, t.m21, t.m22, t.m23, t.m24, t.m31, t.m32, t.m33, t.m34,t.m41, t.m42, t.m43, t.m44);
    
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(0,1,-0.5));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    face.backgroundColor = color.CGColor;
}

-(void)test{
    NSLog(@"%f",self.superLayer.presentationLayer.transform.m11);
    if (self.superLayer.presentationLayer.transform.m11 > 0) {
        self.superLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tranform"].CGImage); // 设置内容
        
    }else{
        self.superLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"icon4"].CGImage); // 设置内容
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBtnView];
    
//    [self createLayerForShadow];    // 设置图层的阴影
//    [self createLayerForMask];        // 设置图层蒙版
//    [self createLayerForAlpha]; // 组透明
//    [self createLayerForTranform];
//    [self createLayerFor3DTranform]; // 3D翻转
//    [self createLayerForFlattening];  // 扁平化
//    [self createLayerForZPotition];
    [self createLayerFor3D];
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

#pragma mark - 按钮点击
- (void)btn1Click
{
    self.superLayer.bounds = CGRectMake(0, 0, 300, 300);
}

-(void)btn2Click
{
    self.superLayer.bounds = CGRectMake(0, 0, 100, 100);
}

- (void)btn3Click
{
    if (self.superLayer.affineTransform.a == 0.5) {
        self.superLayer.affineTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    }else{
        self.superLayer.affineTransform = CGAffineTransformMake(0.5, 0, 0, 1, 0, 0);
    }
}

-(void)btn4Click
{
    CGFloat a = cos(M_PI / 3);
    CGFloat b = -sin(M_PI / 3);
    CGFloat c = sin(M_PI / 3);
    CGFloat d = cos(M_PI / 3);
    if (self.superLayer.affineTransform.a == a) {
        self.superLayer.affineTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    }else{
        self.superLayer.affineTransform = CGAffineTransformMake(a, b, c, d, 0, 0);
    }
}

- (void)btn5Click
{
    if (self.superLayer.affineTransform.tx == 100) {
        self.superLayer.affineTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    }else{
        self.superLayer.affineTransform = CGAffineTransformMake(1, 0, 0, 1, 100, 0);
    }
}

- (void)btn6Click
{
    
    CGFloat angle = M_PI / 3;
    CGFloat a = cos(angle);
    CGFloat b = sin(angle);
    CGFloat c = -sin(angle);
    CGFloat d = cos(angle);
    CGFloat ty = (1-d)*20 -b*100;
    CGFloat tx = (1-a)*100 -c*20;
    CGAffineTransform affineTransform = CGAffineTransformMake(a, b, c, d, tx, ty);
    
    
    
    if (self.superLayer.affineTransform.a == a) {
        self.superLayer.affineTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    }else{

        self.superLayer.affineTransform = CGAffineTransformMake(a, b, c, d, tx, ty);
    }
    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    //scale by 50%
////    transform = CGAffineTransformScale(transform, 0.5, 1);
//    //rotate by 30 degrees
//    transform = CGAffineTransformRotate(transform, M_PI / 3);
//    //translate by 200 points
//    transform = CGAffineTransformTranslate(transform, 100, 20);
//
//
//    if (self.superLayer.affineTransform.tx > 10) {
//        self.superLayer.affineTransform = CGAffineTransformIdentity;
//    }else{
//        self.superLayer.affineTransform = transform;
//    }
//
//    NSLog(@"tranform - %@", NSStringFromCGAffineTransform(transform));
    NSLog(@"tranform - %@", NSStringFromCGAffineTransform(affineTransform));
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

- (NSMutableArray *)btnArrList
{
    if (!_btnArrList) {
        _btnArrList = [NSMutableArray arrayWithCapacity:6];
    }
    return _btnArrList;
}

@end
