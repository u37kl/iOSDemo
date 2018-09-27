//
//  ZPLayer.m
//  iOSDemo
//
//  Created by ww on 2018/9/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPLayer.h"

@interface ZPLayer() <CALayerDelegate>
@property (nonatomic, assign) int num;
@end

@implementation ZPLayer

- (instancetype)init
{
    if (self = [super init]) {
        _num = 0;
    }
    return self;
}

- (void)displayLayer:(CALayer *)layer
{
    NSLog(@"displayLayer:方法调用");
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:[NSString stringWithFormat:@"icon%d", (self.num++)%5]].CGImage);
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"drawLayer:inContext:方法调用");
}

@end
