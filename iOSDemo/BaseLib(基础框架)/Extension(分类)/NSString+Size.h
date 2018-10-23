//
//  NSString+Size.h
//  iOSDemo
//
//  Created by ww on 2018/10/22.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

-(CGSize)getSizeFromStrFontSize:(CGFloat)size;
//
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
