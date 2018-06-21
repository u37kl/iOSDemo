//
//  ZPWKWebViewController.m
//  iOSDemo
//
//  Created by ww on 2018/6/14.
//  Copyright © 2018年 ww. All rights reserved.
//
#import "Masonry.h"
#import "ZPWKWebViewController.h"
#import <WebKit/WebKit.h>
@interface ZPWKWebViewController ()
@property (nonatomic, weak) WKWebView *webView;
@end

@implementation ZPWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc] init];
    [self.view addSubview:webView];
    self.webView = webView;
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    NSString *url =@"file:///Users/ww/Downloads/1841.docx";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
//    [self loadNetData];
}

-(void)loadNetData
{
    NSString *webUrl =@"file:///Users/ww/Downloads/1841.docx";
    NSURL *url = [NSURL URLWithString:webUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if ([webUrl hasSuffix:@"doc"]) {

        [self.webView loadData:data MIMEType:@"application/msword" characterEncodingName:@"GB2312" baseURL:nil];
    }else if([webUrl hasSuffix:@"docx"]){
        [self.webView loadData:data MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" characterEncodingName:@"UTF-8" baseURL:nil];
    }
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
