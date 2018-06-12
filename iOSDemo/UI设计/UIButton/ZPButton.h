//
//  ZPButton.h
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZPButtonStyle){
    ZPButtonStyleNone,
    ZPButtonStyleImgTop,
    ZPButtonStyleImgLeft,
    ZPButtonStyleImgRight
};

@interface ZPButton : UIButton
@property (nonatomic, assign) ZPButtonStyle btnStyle;

@end
