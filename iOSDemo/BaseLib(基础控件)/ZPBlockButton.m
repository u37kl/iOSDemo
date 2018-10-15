//
//  ZPButton.m
//  iOSDemo
//
//  Created by ww on 2018/9/28.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBlockButton.h"

@implementation ZPBlockButton

- (instancetype)initWithHandleClickEvent:(void (^)(UIButton *))handleClickEvent
{
    if (self = [super init]) {
        if (handleClickEvent) {
            if (handleClickEvent) {
                _handleClickEvent = handleClickEvent;
                [self addTarget:self action:@selector(my_handleBtnClick) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        return self;
    }
    return nil;
}

- (void)setHandleClickEvent:(void (^)(UIButton *))handleClickEvent
{
    if (handleClickEvent) {
        _handleClickEvent = handleClickEvent;
        [self addTarget:self action:@selector(my_handleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)my_handleBtnClick
{
    if (self.handleClickEvent) {
        self.handleClickEvent(self);
    }
}
@end
