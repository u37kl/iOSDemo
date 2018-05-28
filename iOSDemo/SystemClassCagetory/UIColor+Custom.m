//
//  UIColor+Custom.m
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+(UIColor *)getUIColorFromRGB:(NSInteger)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0x00FF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0x0000FF))/255.0
                           alpha:1.0];
}
@end
