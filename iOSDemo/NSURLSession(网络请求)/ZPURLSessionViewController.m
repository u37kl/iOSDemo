//
//  ZPURLSessionViewController.m
//  iOSDemo
//
//  Created by ww on 2018/5/24.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPURLSessionViewController.h"

@interface ZPURLSessionViewController ()<NSURLSessionDelegate>

@end

@implementation ZPURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSessionConfiguration *con = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:con delegate:self delegateQueue:nil];
    
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
