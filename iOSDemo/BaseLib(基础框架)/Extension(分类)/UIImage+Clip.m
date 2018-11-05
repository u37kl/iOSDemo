//
//  UIImage+Clip.m
//  iphoneTestRelease
//
//  Created by ww on 2018/11/1.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIImage+Clip.h"
#import "NSString+Size.h"
@implementation UIImage (Clip)

/* 将图片按指定形状进行采集
 * image: 需要裁剪的图片
 * path: 裁剪的形状
 */

+(UIImage *)clipImage:(UIImage *)image path:(UIBezierPath *)path
{
    if (image == nil || image.size.width == 0 || image.size.height == 0 || path == nil) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    [image drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/* 将图片按指定形状进行采集，不直接操作CGContext
 * image: 需要裁剪的图片
 * path: 裁剪的形状
 */

+(UIImage *)clipHiddenContextImage:(UIImage *)image path:(UIBezierPath *)path
{
    if (image == nil || image.size.width == 0 || image.size.height == 0 || path == nil) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [path addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/* 将图片按指定形状进行采集
 * image: 需要裁剪的图片
 * path: 裁剪的形状
 */
+(UIImage *)clipAndAddBorderImage:(UIImage *)image path:(UIBezierPath *)path borderWidth:(CGFloat)borderWidth
{
    if (image == nil || image.size.width == 0 || image.size.height == 0 || path == nil) {
        return nil;
    }

    CGSize allSize = CGSizeMake(image.size.width + borderWidth * 2, image.size.height + borderWidth * 2);
    UIGraphicsBeginImageContextWithOptions(allSize, NO, 0);
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, allSize.width,  allSize.height) cornerRadius:10];
    [[UIColor redColor] set];
    [borderPath fill];
    [path addClip];
    
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)drawTextToImage:(UIImage *)image text:(NSString *)title
{
    if (image == nil || image.size.width == 0 || image.size.height == 0 || title.length == 0) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointMake(0, 0)];
    CGSize size = [title getSizeFromStrFontSize:14];
    [title drawInRect:CGRectMake(image.size.width - size.width, image.size.height - size.height, size.width, size.height) withAttributes:@{NSFontAttributeName:[UIFont getPFRWithSize:14], NSForegroundColorAttributeName:[[UIColor whiteColor] colorWithAlphaComponent:0.6]}];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/* 截取屏幕中的部分变成图片
 * image: 需要截取的view中的内容
 * clipRect: 截取view中的范围
 */

+(UIImage *)clipScreenWithView:(UIView *)view rect:(CGRect)clipRect
{
    if (view == nil || clipRect.size.width == 0 || clipRect.size.height == 0) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(clipRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -clipRect.origin.x, -clipRect.origin.y);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    return nil;
}

+(UIImage *)clipScreenWithView:(UIView *)view
{
    if (view == nil) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    return nil;
}
@end
