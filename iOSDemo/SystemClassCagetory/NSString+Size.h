//
//  NSString+Size.h
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface NSString (Size)

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
