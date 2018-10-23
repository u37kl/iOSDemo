//
//  UIButtonViewController.m
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIButtonViewController.h"
#import <Otherframework/Otherframework.h>
#import "NSString+Size.h"
#import "ZPButton.h"
#import "Masonry.h"
@interface UIButtonViewController ()
@property (nonatomic, weak) UIButton *btn;
@end

@implementation UIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
//    [self test1];
//    [self test2];
    [self test3];
    
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
//    ZPButton *btn = [[ZPButton alloc] init];
//    btn.btnStyle = ZPButtonStyleImgTop;
//    btn.titleAndImgEdge = 8;
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    btn.titleLabel.font = [UIFont getPFRWithSize:12];
//    [btn setTitle:@"呵呵" forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"叹号"] forState:UIControlStateNormal];
//    [btn setTitle:@"哈哈" forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(test1BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(10, 60, 70, 60);
//    btn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
    
    ZPButton *btn1 = [[ZPButton alloc] init];
    btn1.btnStyle = ZPButtonStyleImgRight;
    btn1.titleAndImgEdge = 8;
    btn1.titleAndSuperLeftEdge = 8;
    btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn1.titleLabel.font = [UIFont getPFRWithSize:12];
    [btn1 setTitle:@"呵呵" forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"叹号"] forState:UIControlStateNormal];
    [btn1 setTitle:@"哈哈" forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(test1BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame = CGRectMake(100, 60, 100, 60);
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
}

-(void)test3{
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"当前网络不可用，请检查你的网络设置" forState:UIControlStateNormal];
    [btn setTitle:@"当前网络不可用，请检查你的网络设置" forState:UIControlStateHighlighted];
    btn.tag = 0;
    [self.view addSubview:btn];
    self.btn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(updateLayout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIView *subView = [[UIView alloc] init];
    subView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom);
        make.bottom.equalTo(btn1.mas_top);
    }];
}

-(void)updateLayout
{
    if (self.btn.tag == 0) {
        
        [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
        }];
        self.btn.tag = 1;
    }else{
        [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        self.btn.tag = 0;
    }
    
    [self.btn setNeedsUpdateConstraints];
    [UIView animateWithDuration:4 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    [self.btn setNeedsUpdateConstraints];
    [UIView animateWithDuration:4 animations:^{
        [self.view layoutIfNeeded];
    }];
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
