//
//  UIView+ViewController.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "UIView+ViewController.h"
#import <objc/runtime.h>
@implementation UIView (ViewController)

- (void)setBelongViewController:(UIViewController *)belongViewController
{
    objc_setAssociatedObject(self, @selector(belongViewController), belongViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)belongViewController
{
    return objc_getAssociatedObject(self, _cmd);
}
@end
