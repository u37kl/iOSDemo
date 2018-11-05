//
//  ZPTextQuarzeViewController.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/31.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTextQuarzeViewController.h"
#import "ZPTextQuarzeView.h"
@interface ZPTextQuarzeViewController ()

@end

@implementation ZPTextQuarzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ZPTextQuarzeViewController --- viewDidLoad");
    [self createTextView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"ZPTextQuarzeViewController --- viewWillAppear");
}

-(void)createTextView
{
    NSString *title = @"在默认情况下，由编译器所合成的方法会通过锁定机制确保其原子性(atomicity)。如果属性具备 nonatomic 特质，则不使用同步锁。请注意，尽管没有名为“atomic”的特质(如果某属性不具备 nonatomic 特质，那它就是“原子的”(atomic))。在iOS开发中，你会发现，几乎所有属性都声明为 nonatomic";
    
    ZPTextQuarzeView *view0 = [[ZPTextQuarzeView alloc] init];
    view0.type = ZPTextQuarzeViewTypePoint;
    view0.title = title;
    [self.view addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    ZPTextQuarzeView *view1 = [[ZPTextQuarzeView alloc] init];
    view1.title = title;
    view1.type = ZPTextQuarzeViewTypeRect;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(view0.mas_bottom);
        make.height.mas_equalTo(50);
    }];
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
