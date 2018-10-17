//
//  UIFont+Style.m
//  yourenPower
//
//  Created by ww on 2018/6/2.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import "UIFont+Style.h"
#import <Otherframework/Otherframework.h>
@implementation UIFont (Style)

+(UIFont *)getPFRWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:[JFScreenScale getHeightFromScale:size]];
}
+(UIFont *)getPFBWithSize:(CGFloat)size
{
    
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:[JFScreenScale getHeightFromScale:size]];
}
@end
