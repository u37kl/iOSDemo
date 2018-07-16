//
//  ZPFile3DScrollViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/12.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPFile3DScrollViewController.h"
#import "ZPRepeatPlayScrollView.h"
#import "JFSKinManager.h"
@interface ZPFile3DScrollViewController ()

@end

@implementation ZPFile3DScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
    ZPRepeatPlayScrollView *scrollView = [[ZPRepeatPlayScrollView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth, 320)];
    [self.view addSubview:scrollView];
    
     [scrollView setImageArr:@[@"gesture_1", @"gesture_2", @"gesture_3", @"gesture_4", @"gesture_5", @"gesture_6"]];
    [scrollView startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
