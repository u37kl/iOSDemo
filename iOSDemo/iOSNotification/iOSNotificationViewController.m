//
//  iOSNotificationViewController.m
//  iOSDemo
//
//  Created by ww on 2018/5/14.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "iOSNotificationViewController.h"

@interface iOSNotificationViewController ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation iOSNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kfirstNotification object:nil];
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor blackColor];
    CGSize size=[UIScreen mainScreen].bounds.size;
    NSString *str = @"我的：";
    CGSize temp = [str boundingRectWithSize:CGSizeMake(200, size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size;
    label.frame = CGRectMake(0, 70, temp.width, 21);
    label.text = str;
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    self.label = label;
    btn.backgroundColor = [UIColor greenColor];
     btn.frame = CGRectMake(0, 320, 100, 100);
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
}

-(void)test{
    self.label.font = [UIFont systemFontOfSize:17*1.104];
    self.label.frame = CGRectMake(0, 70, 52*1.104, 21);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)handleNotification:(NSNotification *)no
{
    
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
