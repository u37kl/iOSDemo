//
//  ZPButton.h
//  iOSDemo
//
//  Created by ww on 2018/9/28.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPBlockButton : UIButton

@property (nonatomic, copy) void(^handleClickEvent)(UIButton *btn);

- (instancetype)initWithHandleClickEvent:(void (^)(UIButton *))handleClickEvent;
@end
