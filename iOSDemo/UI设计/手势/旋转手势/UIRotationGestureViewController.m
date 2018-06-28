//
//  UIRotationGestureViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/28.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIRotationGestureViewController.h"
#import "JFSKinManager.h"
#import "Masonry.h"
#import "UIGestureRecognizer+Name.h"
#import "UIView+Frame.h"

@interface UIRotationGestureViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIImageView *redView;
@property (nonatomic, assign) CGFloat scale;
@end

@implementation UIRotationGestureViewController

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
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]  initWithTarget:self action:@selector(rotationGestureHandle:)];
     UIPinchGestureRecognizer *scoll = [[UIPinchGestureRecognizer alloc]  initWithTarget:self action:@selector(rotationGestureHandle:)];
    rotation.delegate = self;
    scoll.delegate = self;
    [self.view addGestureRecognizer:rotation];
    [self.view addGestureRecognizer:scoll];
}


-(void)rotationGestureHandle:(UIGestureRecognizer  *)gesture
{
    if ([gesture isKindOfClass:[UIRotationGestureRecognizer class]]) {
        UIRotationGestureRecognizer *ro = (UIRotationGestureRecognizer *)gesture;
        self.redView.transform = CGAffineTransformRotate(self.redView.transform, ro.rotation);
        ro.rotation = 0;
    }else if([gesture isKindOfClass:[UIPinchGestureRecognizer class]]){
        UIPinchGestureRecognizer *pin = (UIPinchGestureRecognizer *)gesture;
        self.redView.transform = CGAffineTransformScale(self.redView.transform, pin.scale, pin.scale);
        pin.scale = 1;
        NSLog(@"%f --- %@", pin.scale,NSStringFromCGRect(self.redView.frame));
    }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
