//
//  ZPURLSessionViewController.m
//  iOSDemo
//
//  Created by ww on 2018/5/24.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPURLSessionViewController.h"
#import "JFNetTool.h"
@interface ZPURLSessionViewController ()<NSURLSessionDelegate>

@end

@implementation ZPURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURLSessionConfiguration *con = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:con delegate:self delegateQueue:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];    NSData *data = [NSData dataWithContentsOfURL:ipURL];    NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];     NSString *ipStr = nil;
    if (ipDic && [ipDic[@"code"] integerValue] == 0) { //获取成功
        ipStr = ipDic[@"data"][@"ip"];
    }
    
    NSError *error;
    NSURL *ipURLs = [NSURL URLWithString:@"http://ifconfig.me/ip"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURLs encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"");
    
}

@end
