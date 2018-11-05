//
//  UIView+ViewController.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ViewController)
@property (nonatomic, weak) UIViewController *belongViewController; // 所属于的ViewController
@end

NS_ASSUME_NONNULL_END
