//
//  UIFont+Type.h
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FontType) {
    FontTypePF = 1,
};

const NSArray *__FontType = nil;
#define getFontArray (__FontType == nil ? [[NSArray alloc] initWithObjects: \
@"A",\
@"PingFangSC-Light", nil] : __FontType)

#define getFontType(Type) getFontArray[Type]
@interface UIFont ()

@end
