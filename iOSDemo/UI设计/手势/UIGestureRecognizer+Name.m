//
//  UIGestureRecognizer+Name.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/27.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIGestureRecognizer+Name.h"
#import <objc/runtime.h>
@implementation UIGestureRecognizer (Name)

- (NSString *)gestureName{
    return objc_getAssociatedObject(self, @"gestureName");
}

- (void)setGestureName:(NSString *)gestureName
{
    return objc_setAssociatedObject(self, @"gestureName", gestureName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
