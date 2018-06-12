//
//  UIFont+Extension.m
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIFont+Extension.h"
#import "JFScreenScale.h"
@implementation UIFont (Extension)

+(UIFont *)getPFRWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:[JFScreenScale getFloatFromScaleFloor:size]];
}
+(UIFont *)getPFBWithSize:(CGFloat)size
{
    
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:[JFScreenScale getFloatFromScaleFloor:size]];
}
@end
