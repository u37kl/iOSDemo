//
//  ZPImageQuarzeView.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/31.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPImageQuarzeView.h"

@implementation ZPImageQuarzeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [JFSKinManager skinManager].model.frontColor;
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    self.layer.borderColor = [JFSKinManager skinManager].model.separatorLineColor.CGColor;
    self.layer.borderWidth = .5;
    
    NSLog(@"ZPTextQuarzeView --- drawRect:");
    if (self.type == ZPImageQuarzeViewTypePoint) {
        [self drawImagePoint:CGPointMake(rect.origin.x, rect.origin.y)];
    }else{
        [self drawImageRect:rect];
    }
}
/*
    设置绘制的左上角位置，会根据图片的原始尺寸进行绘制，当图片的尺寸与控件尺寸不一致时，就会出现留白现象
 */
-(void)drawImagePoint:(CGPoint)point
{
    
    [self.image drawAtPoint:point];
}

/*
 设置绘制的范围，会对t团时图片进行缩放，保证不会出现留白现象。图片存在压缩的现象
 */
-(void)drawImageRect:(CGRect)rect
{
    [self.image drawInRect:rect];
}

@end
