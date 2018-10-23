//
//  UIColor+Gradient.h
//  iOSDemo
//
//  Created by ww on 2018/10/22.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Gradient)

+(UIColor *)colorFromBeginColor:(UIColor *)beginColor toEndColor:(UIColor *)endColor scale:(CGFloat) scale;
@end

NS_ASSUME_NONNULL_END
