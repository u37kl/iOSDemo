//
//  iOSNotificationViewController.m
//  iOSDemo
//
//  Created by ww on 2018/5/14.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "iOSNotificationViewController.h"

@interface iOSNotificationViewController ()

@end

@implementation iOSNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kfirstNotification object:nil];
    
    
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
