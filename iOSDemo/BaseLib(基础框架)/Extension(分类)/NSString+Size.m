//
//  NSString+Size.m
//  iOSDemo
//
//  Created by ww on 2018/10/22.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

-(CGSize)getSizeFromStrFontSize:(CGFloat)size
{
    CGSize temp = [self boundingRectWithSize:CGSizeMake(2000, 200) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{@"NSFontAttributeName":[UIFont getPFRWithSize:size]} context:nil].size;
    return CGSizeMake(temp.width + 1, temp.height);
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize = CGSizeZero;
    if (self.length > 0) {
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    return resultSize;
}
@end
