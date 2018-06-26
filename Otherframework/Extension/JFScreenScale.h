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
+(double)scale;
+(double)getFloatFromScale:(CGFloat)num;
+(double)getFloatFromScaleFloor:(CGFloat)num;
+(double)getFloatFromScaleCeil:(CGFloat)num;

+(double)getHeightFromScale:(CGFloat)num;
+(double)getWidthFromScale:(CGFloat)num;
@end
