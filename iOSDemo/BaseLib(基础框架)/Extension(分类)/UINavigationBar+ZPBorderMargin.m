//
//  UINavigationBar+ZPBorderMargin.m
//  iOSDemo
//
//  Created by ww on 2018/10/20.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UINavigationBar+ZPBorderMargin.h"
#import <objc/runtime.h>
void swizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    if (class_addMethod(cls, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UINavigationBar (ZPBorderMargin)

+ (void)load {
    if (@available(iOS 11.0, *)) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            swizzleInstanceMethod(self, @selector(layoutSubviews), @selector(zp_layoutSubviews));
        });
    }else{
        
    }
}

- (void)zp_layoutSubviews {
    [self zp_layoutSubviews];
    
    for (UIView *view in self.subviews) {
        for (UIView *stackView in view.subviews) {
            if (@available(iOS 9.0, *)) {
                if ([stackView isKindOfClass: [UIStackView class]]) {
                    stackView.superview.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
                    break;
                }
            }
        }
    }
}



@end
