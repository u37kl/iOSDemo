//
//  ZPPanGestureRecognizerViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/27.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTestGestureRecognizerViewController.h"
#import "JFSKinManager.h"
#import "UIGestureRecognizer+Name.h"
#import "Masonry.h"
typedef NS_ENUM(NSUInteger, GestureDirection){
    GestureDirectionNone,
    GestureDirectionLeft,
    GestureDirectionRight,
    GestureDirectionTop,
    GestureDirectionBottom
};

@interface ZPTestGestureRecognizerViewController()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *orangeView;
@property (nonatomic, weak) UIView *blueView;
@property (nonatomic, weak) UIView *greenView;
@end

@implementation ZPTestGestureRecognizerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandleRoot:)];
    pan.gestureName = @"根view";
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    [self loadViewCenterView];
}

- (void)loadViewCenterView
{
    UIView *orangeView = [[UIView alloc] init];
    orangeView.backgroundColor = [UIColor orangeColor];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(panGestureHandleOrange:)];
    pan.delegate = self;
    pan.gestureName = @"橙色view";
    [orangeView addGestureRecognizer:pan];
    [self.view addSubview:orangeView];
    self.orangeView = orangeView;
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(40);
        make.right.bottom.equalTo(self.view).offset(-40);
    }];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(panGestureHandleBlue:)];
    pan1.delegate = self;
    pan1.gestureName = @"蓝色view";
    self.blueView = blueView;
    [blueView addGestureRecognizer:pan1];
    [orangeView addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(orangeView);
        make.bottom.equalTo(orangeView);
    }];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor greenColor];
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(panGestureHandleGreen:)];
    pan2.delegate = self;
    pan2.gestureName = @"绿色view";
    [greenView addGestureRecognizer:pan2];
    self.greenView = greenView;
    [orangeView addSubview:greenView];
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orangeView);
        make.left.equalTo(blueView.mas_right);
        make.right.bottom.equalTo(orangeView);
        make.width.equalTo(blueView);
    }];
}




#pragma mark - 计算拖拽方向
// 将用户的拖拽方向划分到四个象限，45度、135度、225度、315度不考虑(忽略对角线方向拖拽)
-(GestureDirection)getDirection:(CGPoint)point
{
    CGFloat fabsX = fabs(point.x);
    CGFloat fabsY = fabs(point.y);
    if (point.x > 0) {
        if (point.y > 0) {
            // 第四象限
            if (fabsX > fabsY) {
                return fabsY/fabsX > 0.75 ? GestureDirectionNone: GestureDirectionRight;
            }else{
                return fabsX/fabsY > 0.75 ? GestureDirectionNone: GestureDirectionBottom;
            }
        }else{
            // 第一象限
            if (fabsX > fabsY) {
                return fabsY/fabsX > 0.75 ? GestureDirectionNone: GestureDirectionRight;
            }else{
                return fabsX/fabsY > 0.75 ? GestureDirectionNone: GestureDirectionTop;
            }
        }
    }else{
        if (point.y > 0) {
            // 第三象限
            if (fabsX > fabsY) {
                return fabsY/fabsX > 0.75 ? GestureDirectionNone: GestureDirectionLeft;
            }else{
                return fabsX/fabsY > 0.75 ? GestureDirectionNone: GestureDirectionBottom;
            }
        }else{
            // 第二象限
            if (fabsX > fabsY) {
                return fabsY/fabsX > 0.75 ? GestureDirectionNone: GestureDirectionLeft;
            }else{
                return fabsX/fabsY > 0.75 ? GestureDirectionNone: GestureDirectionTop;
            }
        }
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    CGPoint point = [touch locationInView:gestureRecognizer.view];

    
    if (gestureRecognizer.view == self.orangeView) {
        if (point.x <= 40) {
            return YES;
        }else{
            return NO;
        }
    }else if(gestureRecognizer.view == self.blueView){
        if (point.x > 40) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint vP = [pan velocityInView:gestureRecognizer.view];
    GestureDirection type = [self getDirection:vP];
    if (gestureRecognizer.view == self.orangeView) {
        if (type == GestureDirectionRight) {
            return YES;
        }
    }else if(gestureRecognizer.view == self.blueView){
        if (type == GestureDirectionRight) {
            return YES;
        }else{
            return NO;
        }
    }else if(gestureRecognizer.view == self.greenView){
        if (type == GestureDirectionLeft) {
            return YES;
        }else{
            return NO;
        }
    }else if(gestureRecognizer.view == self.view){
        if (type == GestureDirectionTop || type == GestureDirectionBottom) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press
{
    CGPoint sourceP = [gestureRecognizer locationInView:gestureRecognizer.view];
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint nextP = [pan translationInView:gestureRecognizer.view];
    NSLog(@"gestureRecognizershouldReceivePress --- %@ --- %f=%f --- %f=%f", gestureRecognizer.gestureName, sourceP.x, sourceP.y, nextP.x, nextP.y);
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    
//}

#pragma mark - 拖拽手势识别
-(void)panGestureHandleRoot:(UIPanGestureRecognizer *)gesture
{
    CGPoint p = [gesture translationInView:gesture.view];
    if (p.y > 0) {
        NSLog(@"%@ --- 下滑", gesture.gestureName);
    }else{
        NSLog(@"%@ --- 上滑", gesture.gestureName);
    }
}

-(void)panGestureHandleOrange:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"%@ --- 右滑", gesture.gestureName);
}


-(void)panGestureHandleBlue:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"%@ --- 右滑", gesture.gestureName);
}


-(void)panGestureHandleGreen:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"%@ --- 左滑", gesture.gestureName);
}



@end
