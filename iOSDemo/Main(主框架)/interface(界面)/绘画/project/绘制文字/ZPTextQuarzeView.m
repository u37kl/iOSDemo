//
//  ZPTextQuarzeView.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/31.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTextQuarzeView.h"
#import <CoreText/CoreText.h>
@implementation ZPTextQuarzeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [JFSKinManager skinManager].model.frontColor;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"ZPTextQuarzeView --- layoutSubviews");
}


- (void)drawRect:(CGRect)rect {
    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1;
    
    NSLog(@"ZPTextQuarzeView --- drawRect:");
    if (self.type == ZPTextQuarzeViewTypePoint) {
        [self drawTextPoint:CGPointMake(rect.origin.x, rect.origin.y)];
    }else{
        [self drawTextRect:rect];
    }
}

-(void)drawTextPoint:(CGPoint)point
{
    [self.title drawAtPoint:point withAttributes:[self getAttributes]];
}

-(void)drawTextRect:(CGRect)rect
{
    [self.title drawInRect:rect withAttributes:[self getAttributes]];
}

-(NSDictionary *)getAttributes
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:4];
    dict[NSFontAttributeName] = [UIFont getPFRWithSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    return [dict copy];
}
@end
