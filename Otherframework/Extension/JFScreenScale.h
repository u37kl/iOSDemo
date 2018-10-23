//
//  JFScreenScale.h
//  yourenPower
//
//  Created by ww on 2018/5/31.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface JFScreenScale : NSObject
+(JFScreenScale *)scale;
+(double)getFloatFromScale:(CGFloat)num;
+(double)getFloatFromScaleFloor:(CGFloat)num;
+(double)getFloatFromScaleCeil:(CGFloat)num;

// 宽度缩放比例
+(double)getWidthFromScale:(CGFloat)num;
// 高度缩放比例
+(double)getHeightFromScale:(CGFloat)num;
// 获取设备底部的安全区域
+(CGFloat)getBottomSafeHeight;
// 获取设备顶部的安全区域
+(CGFloat)getTopSafeHeight;
// 获取rootView安全区域
+(CGSize)getRootViewSafeBounds;

// 是否是iphoneX及以上
+(BOOL)isIphoneXAndOver;

+(CGFloat)getDeviceHeight;
+(CGFloat)getDeviceWidth;
@end
