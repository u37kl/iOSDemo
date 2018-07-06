//
//  ZPTapGestureViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/28.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTapGestureViewController.h"
#import "JFSKinManager.h"
#import "Masonry.h"
#import "UIGestureRecognizer+Name.h"
#import "UIView+Frame.h"

@interface ZPTapGestureViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIImageView *redView;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation ZPTapGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    [self loadViewCenterView];
    self.scale = 0;
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(rotationGestureHandle:)];
    tap.delaysTouchesEnded = YES;
    tap.name = @"UITapGestureRecognizer";
    tap.delegate = self;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]  initWithTarget:self action:@selector(rotationGestureHandle:)];
    longPress.name = @"UILongPressGestureRecognizer";
    longPress.delegate = self;
    [redView addGestureRecognizer:tap];
    [redView addGestureRecognizer:longPress];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"%@ --- %@", gestureRecognizer.name, otherGestureRecognizer.name);
    return YES;
}


-(void)rotationGestureHandle:(UIGestureRecognizer  *)gesture
{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"用户点击图片");
    }else if([gesture isKindOfClass:[UILongPressGestureRecognizer class]]){
        NSLog(@"用户长按图片");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
