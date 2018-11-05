//
//  UIImage+Clip.h
//  iphoneTestRelease
//
//  Created by ww on 2018/11/1.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Clip)
// 按指定路径裁剪图片
+(UIImage *)clipImage:(UIImage *)image path:(UIBezierPath *)path;
// 按指定路径裁剪图片
+(UIImage *)clipHiddenContextImage:(UIImage *)image path:(UIBezierPath *)path;
// 绘制图片并添加边框
+(UIImage *)clipAndAddBorderImage:(UIImage *)image path:(UIBezierPath *)path borderWidth:(CGFloat)borderWidth;
// 给图片添加水印
+(UIImage *)drawTextToImage:(UIImage *)image text:(NSString *)title;
// 从屏幕中截取部分图片
+(UIImage *)clipScreenWithView:(UIView *)view rect:(CGRect)clipRect;
// 截屏
+(UIImage *)clipScreenWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
