//
//  ZPLongPressViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/28.
//  Copyright © 2018年 ww. All rights reserved.
//


/*
 * 长按与拖拽手势(或者轻扫手势与拖拽手势)放在同一个控件中时，首先识别的是拖拽手势。
 * 通过获得拖拽手势的加速度，来判断是哪种手势
 * gestureRecognizer:shouldReceiveTouch:代理方法是用来获得用户接触屏幕的起点的，不能获得偏移量、用户手势划过屏幕的速度等信息，需要在gestureRecognizerShouldBegin:代理方法中获取。
 * 移动速度等于0是认为是长按手势，(0, 600]与[-600, 0)这两个区间认为是拖拽手势，其它区间认为是轻扫手势。
 * 通过gestureRecognizer:shouldReceiveTouch:代理方法调用translationInView来判断是否存在偏移量，从而判断是长按还是拖拽
 * translationInView方法反应迟钝，先左滑在右滑时，x值先变成负值，然后负值变小，最后变成正值。(gestureRecognizer:shouldReceiveTouch:方法中setTranslation:InView:方法是失效的，一般要在gestureRecognizerShouldBegin:方法中使用，或者手势的处理方法中)
 */

#import "ZPLongPressViewController.h"
#import "ZPTapGestureViewController.h"
#import "JFSKinManager.h"
#import "Masonry.h"
#import "UIGestureRecognizer+Name.h"
#import "UIView+Frame.h"

@interface ZPLongPressViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIImageView *redView;
@end

@implementation ZPLongPressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    [self loadViewCenterView];
}

- (void)loadViewCenterView
{
    
    UIImageView *redView = [[UIImageView alloc] init];
    redView.image = [UIImage imageNamed:@"gesture_3"];
    redView.userInteractionEnabled = YES;
    redView.backgroundColor = [JFSKinManager skinManager].model.frontColor;
    self.redView = redView;
    [self.view addSubview:redView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(90);
        make.right.bottom.equalTo(self.view).offset(-90);
    }];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(rotationGestureHandle:)];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]  initWithTarget:self action:@selector(rotationGestureHandle:)];
    pan.delegate = self;
    longPress.delegate = self;
    [redView addGestureRecognizer:pan];
    [redView addGestureRecognizer:longPress];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan =(UIPanGestureRecognizer *)gestureRecognizer;
        
        // 获取的偏移量数据有问题
        CGPoint xy = [pan translationInView:gestureRecognizer.view];
        NSLog(@"--- %@ ---", NSStringFromCGPoint(xy));
        // setTranslation:inView:方法失效
        [pan setTranslation:CGPointZero inView:gestureRecognizer.view];
        CGPoint xy1 = [pan translationInView:gestureRecognizer.view];
        NSLog(@"--- %@ ---", NSStringFromCGPoint(xy1));
        
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {

        UIPanGestureRecognizer *pan =(UIPanGestureRecognizer *)gestureRecognizer;
        
        CGPoint xy1 = [pan translationInView:gestureRecognizer.view];
        NSLog(@"--- %@ ---", NSStringFromCGPoint(xy1));
        [pan setTranslation:CGPointZero inView:gestureRecognizer.view];
        CGPoint xy2 = [pan translationInView:gestureRecognizer.view];
        NSLog(@"--- %@ ---", NSStringFromCGPoint(xy2));
        
        
        CGPoint xy = [pan velocityInView:gestureRecognizer.view];
        

        // 根据获取的手指划过屏幕的速度来区分手势
        if (xy.x == 0 || xy.y == 0) {
            return NO;
        }else{
            return YES;
        }
        
    }else{
        NSLog(@"咋办");
        return YES;
    }
}

-(void)rotationGestureHandle:(UIGestureRecognizer  *)gesture
{
    
    if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        NSLog(@"用户点击图片");
    }else if([gesture isKindOfClass:[UILongPressGestureRecognizer class]]){
        NSLog(@"用户长按图片");
    }
    
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
