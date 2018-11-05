//
//  ZPBaseQuarzeViewController.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/30.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseQuarzeViewController.h"
#import "ZPBaseQuarzeView.h"
@interface ZPBaseQuarzeViewController ()

@end

@implementation ZPBaseQuarzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createQuarze];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    [btn1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"ui_leftNavBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    [self setRightBarButtonItem:left];
}

-(void)test1{
    ZPBaseQuarzeViewController *vc = [[ZPBaseQuarzeViewController alloc] init];


    [self.navigationController pushViewController:vc animated:YES];

}

-(void)createQuarze{
    CGFloat size = [JFScreenScale getDeviceWidth]/3;
    ZPBaseQuarzeView *baseView0 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    baseView0.type = ZPBaseQuarzeViewTypeLine;
    baseView0.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView0];
    
    ZPBaseQuarzeView *baseView1 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(size, 0, size, size)];
    baseView1.type = ZPBaseQuarzeViewTypeRects;
    baseView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView1];
    
    
    ZPBaseQuarzeView *baseView2 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(size * 2, 0, size, size)];
    baseView2.type = ZPBaseQuarzeViewTypeHalfRound;
    baseView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView2];
    
    ZPBaseQuarzeView *baseView3 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(0, size, size, size)];
    baseView3.type = ZPBaseQuarzeViewTypeRoundRect;
    baseView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView3];
    
    ZPBaseQuarzeView *baseView4 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(size, size, size, size)];
    baseView4.type = ZPBaseQuarzeViewTypeCircle;
    baseView4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView4];

    ZPBaseQuarzeView *baseView5 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(size * 2, size, size, size)];
    baseView5.type = ZPBaseQuarzeViewTypeOval;
    baseView5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView5];
    
    ZPBaseQuarzeView *baseView6 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(0, size * 2, size, size)];
    baseView6.type = ZPBaseQuarzeViewTypeDashed;
    baseView6.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView6];
    
    ZPBaseQuarzeView *baseView7 = [[ZPBaseQuarzeView alloc] initWithFrame:CGRectMake(size, size * 2, size, size)];
    baseView7.type = ZPBaseQuarzeViewTypeCurveLine;
    baseView7.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView7];
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
