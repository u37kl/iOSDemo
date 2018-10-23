//
//  UIColor+Gradient.m
//  iOSDemo
//
//  Created by ww on 2018/10/22.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIColor+Gradient.h"

@implementation UIColor (Gradient)

+(UIColor *)colorFromBeginColor:(UIColor *)beginColor toEndColor:(UIColor *)endColor scale:(CGFloat) scale
{
    CGFloat beginRed  = 0;
    CGFloat beginGreen  = 0;
    CGFloat beginBlue  = 0;
    CGFloat beginAlpha  = 0;
    [beginColor getRed:&beginRed green:&beginGreen blue:&beginBlue alpha:&beginAlpha];
    
    CGFloat endRed  = 0;
    CGFloat endGreen  = 0;
    CGFloat endBlue  = 0;
    CGFloat endAlpha  = 0;
    [endColor getRed:&endRed green:&endGreen blue:&endBlue alpha:&endAlpha];
    
    return [UIColor colorWithRed:(beginRed + (endRed - beginRed) * scale) green:(beginGreen + (endGreen - beginGreen) * scale) blue:(beginBlue + (endBlue - beginBlue) * scale) alpha:1];
}
@end
