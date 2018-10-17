//
//  JFDefaultSkin.m
//  yourenPower
//
//  Created by admin on 2018/6/1.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import "JFDefaultSkin.h"

@interface JFDefaultSkin()

@end
@implementation JFDefaultSkin

- (UIColor *)themeColor
{
   return JFColorAlpha_v(0xFB7299, 1);
}

-(UIColor *)tabBarBtnTitleNormalColor
{
    return JFColorAlpha_v(0x757575, 1);
}

- (UIColor *)backColor
{
    return JFColorAlpha_v(0xefeff4, 1);
}

- (UIColor *)frontColor
{
    return JFColorAlpha_v(0xffffff, 1);
}
                           
- (UIColor *)titleColor
{
    return JFColorAlpha_v(0x4A4A4A, 1);
}

- (UIColor *)contentDataColor
{

    return JFColorAlpha_v(0x4A4A4A, 1);
}

- (UIColor *)subTitleColor
{
    return JFColorAlpha_v(0x9B9B9B, 1);
}
- (UIColor *)flagTitleColor
{
    return JFColorAlpha_v(0x4A90E2, 1);
}

- (UIColor *)flagTitleOrangeColor
{
    return JFColorAlpha_v(0xFF9600, 1);
}

- (UIColor *)separatorLineColor
{
    return JFColorAlpha_v(0x9B9B9B, 1);
}

- (UIColor *)textViewBackColor
{
    return JFColorAlpha_v(0xF1F6F9, 1);
}

- (UIColor *)columnBtnTextColor
{
    return JFColorAlpha_v(0x1d5b8d, 1);
}

- (UIColor *)columnBtnLineColor
{
    return JFColorAlpha_v(0x1d5b8d, 1);
}
@end
