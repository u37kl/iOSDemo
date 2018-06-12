//
//  UIButtonViewController.m
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIButtonViewController.h"
#import "UIFont+Extension.h"
#import "ZPButton.h"
@interface UIButtonViewController ()

@end

@implementation UIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self test1];
    [self test2];
}

#pragma mark - 测试如何从普通状态过渡到选择状态，从选中状态过渡到普通状态
-(void)test1{
    /*
      枚举组合使用时，不一定是既包含A又包含B，有可能是生成一个新的属性。
      向按钮UIControlStateNormal | UIControlStateHighlighted 组合出普通状态下点击状态。
     */
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"呵呵" forState:UIControlStateNormal];
    [btn setTitle:@"呵呵" forState:UIControlStateSelected | UIControlStateHighlighted];
    [btn setTitle:@"哈哈" forState:UIControlStateNormal | UIControlStateHighlighted];
    [btn setTitle:@"哈哈" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(test1BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 10, 70, 40);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

-(void)test1BtnClick:(UIButton *)btn
{
    if (btn.isSelected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}

-(void)test2{
    /*
     枚举组合使用时，不一定是既包含A又包含B，有可能是生成一个新的属性。
     向按钮UIControlStateNormal | UIControlStateHighlighted 组合出普通状态下点击状态。
     */
    ZPButton *btn = [[ZPButton alloc] init];
    btn.btnStyle = ZPButtonStyleImgTop;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont getPFRWithSize:12];
    [btn setTitle:@"呵呵" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"叹号"] forState:UIControlStateNormal];
//    [btn setTitle:@"呵呵" forState:UIControlStateSelected | UIControlStateHighlighted];
//    [btn setTitle:@"哈哈" forState:UIControlStateNormal | UIControlStateHighlighted];
//    [btn setTitle:@"哈哈" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(test1BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 60, 70, 30);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
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
