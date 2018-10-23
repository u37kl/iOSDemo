//
//  ZPBaseLabel.h
//  iOSDemo
//
//  Created by ww on 2018/10/18.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPBaseLabel : UILabel
@property (nonatomic, assign, setter=setWrappingLine:) BOOL isWrappingLine; // 是否支持换行
@property (nonatomic, assign,  setter=setEllipsis:) BOOL isEllipsis;  // 是否支持省略

-(void)ssds;
@end

NS_ASSUME_NONNULL_END
