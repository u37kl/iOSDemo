//
//  NSString+Extension.m
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "NSString+Extension.h"
#import "UIFont+Extension.h"
@implementation NSString (Extension)

-(CGSize)getSizeFromStrFontSize:(CGFloat)size
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    [dict setObject:[UIFont getPFRWithSize:size] forKey:NSFontAttributeName];

    CGSize temp = [self boundingRectWithSize:CGSizeMake(2000, 200) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
    return temp;
}
@end
