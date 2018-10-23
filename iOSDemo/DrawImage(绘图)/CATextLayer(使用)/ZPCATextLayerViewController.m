//
//  ZPCATextLayerViewController.m
//  iOSDemo
//
//  Created by ww on 2018/10/17.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPCATextLayerViewController.h"
#import <CoreText/CoreText.h>
#import "ZPBaseLabel.h"
#import "Masonry.h"
#import <objc/runtime.h>

@interface ZPCATextLayerViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ZPCATextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createTextLayer];
//    [self createTextAttributeLayer];
    [self createCustomLabel];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"返回中" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    self.navigationItem.leftBarButtonItem = left;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count > 0) {
        return YES;
    }else{
        return NO;
    }
}

-(void)test1{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createTextLayer
{
    CATextLayer *layer = [[CATextLayer alloc] init];
    layer.frame = CGRectMake(50, 50, 100, 100);
    [self.view.layer addSublayer:layer];
    
    layer.foregroundColor = [UIColor blackColor].CGColor;
    layer.alignmentMode = kCAAlignmentLeft;
    layer.wrapped = YES;
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    layer.font = fontRef;
    layer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    layer.string = text;
    layer.contentsScale = [UIScreen mainScreen].scale;
    
}

-(void)createTextAttributeLayer
{
    

    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    
    UIFont *font = [UIFont fontWithName:@"Chalkduster" size:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSLog(@"Retain count is %ld", CFGetRetainCount(fontRef));
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge __unsafe_unretained id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    
    CFRelease(fontRef);

    // 使用UIFont设置富文本
    
    /*
    UIFont *font1 = [UIFont fontWithName:@"Chalkduster" size:15];
    NSDictionary *attribs1 = @{
                              NSForegroundColorAttributeName:[UIColor blueColor],
                              NSFontAttributeName : font1
                              };
    
    [string setAttributes:attribs1 range:NSMakeRange(0, [text length])];
    
    attribs1 = @{
                NSForegroundColorAttributeName: [UIColor redColor],
                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                NSFontAttributeName : font1
                };
    [string setAttributes:attribs1 range:NSMakeRange(6, 5)];
     
     */
    
    CATextLayer *layer = [[CATextLayer alloc] init];
    layer.frame = CGRectMake(50, 50, 320, 100);
    [self.view.layer addSublayer:layer];
    layer.wrapped = YES;
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.string = string;
}


-(void)createCustomLabel
{
    ZPBaseLabel *label = [[ZPBaseLabel alloc] init];
    
    
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(50);
        make.height.mas_equalTo(300);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(label.mas_bottom).offset(10);
        make.height.mas_equalTo(300);
    }];
    
    
    UIFont *font = [UIFont fontWithName:@"Chalkduster" size:15];
    label.font = font;
    label.textColor = [UIColor blueColor];
    label.text = @"Lorem ipsum dolor sit amet";
    label.textAlignment = NSTextAlignmentRight;

    label1.font = font;
    label1.textColor = [UIColor blueColor];
    label1.numberOfLines = 0;
    label1.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    
}
@end
