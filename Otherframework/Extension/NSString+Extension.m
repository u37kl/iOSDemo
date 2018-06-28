//
//  NSString+Extension.m
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "NSString+Extension.h"
#import "UIFont+Extension.h"

void runNSNumberXxxForLib()
{
    
}
@implementation NSString (Extension)

-(CGSize)getSizeFromStrFontSize:(CGFloat)size
{

    CGSize temp = [self boundingRectWithSize:CGSizeMake(2000, 200) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{@"NSFontAttributeName":[UIFont getPFRWithSize:size]} context:nil].size;
    return CGSizeMake(temp.width + 1, temp.height);
}
@end
