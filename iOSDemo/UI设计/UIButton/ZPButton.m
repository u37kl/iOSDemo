//
//  ZPButton.m
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPButton.h"
#import <Otherframework/NSString+Extension.h>


@interface ZPButton()
@property(nonatomic, weak) UIImage *normalImg;
@property(nonatomic, weak) UIImage *selectedImg;
@property(nonatomic, weak) UIImage *hightedImg;
@property(nonatomic, weak) UIImage *disabledImg;

@property(nonatomic, weak) NSString *normalStr;
@property(nonatomic, weak) NSString *selectedStr;
@property(nonatomic, weak) NSString *hightedStr;
@property(nonatomic, weak) NSString *disabledStr;
@end

@implementation ZPButton


- (CGRect)contentRectForBounds:(CGRect)bounds
{
    NSLog(@"内容边界：%@", NSStringFromCGRect(bounds));
    return bounds;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    switch (self.btnStyle) {
        case ZPButtonStyleImgTop:
        {
            return [self setTopImgStyle];
            break;
        }
        case ZPButtonStyleImgLeft:
        {
            return [super imageRectForContentRect:contentRect];
            break;
        }
        case ZPButtonStyleImgRight:
        {
            return [self setRightImgStyle];
            break;
        }
            
        default:
            return [super imageRectForContentRect:contentRect];
            break;
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    switch (self.btnStyle) {
        case ZPButtonStyleImgTop:
        {
            return [self setBottomStrStyle];
            break;
        }
        case ZPButtonStyleImgLeft:
        {
            return [super titleRectForContentRect:contentRect];
            break;
        }
        case ZPButtonStyleImgRight:
        {
            return [self setLeftStrStyle];
            break;
        }

        default:
            return [super imageRectForContentRect:contentRect];
            break;
    }
    
}

-(CGRect)setTopImgStyle{
    
    CGSize sizeOfImg = self.normalImg.size;
    return CGRectMake(self.frame.size.width *0.5 - sizeOfImg.width*0.5, self.imgAndSuperTopEdge, sizeOfImg.width, sizeOfImg.height);
}

-(CGRect)setBottomStrStyle{
    CGSize sizeOfStr = [self.normalStr getSizeFromStrFontSize:12];
    CGSize sizeOfImg = self.normalImg.size;
    return CGRectMake(0, sizeOfImg.height + self.titleAndImgEdge, self.frame.size.width, sizeOfStr.height);
}



-(CGRect)setRightImgStyle{
    CGSize sizeOfStr = [self.normalStr getSizeFromStrFontSize:12];
    CGSize sizeOfImg = self.normalImg.size;
    return CGRectMake(sizeOfStr.width + self.titleAndImgEdge, self.frame.size.height *0.5 - sizeOfImg.height*0.5, sizeOfImg.width, sizeOfImg.height);
}

-(CGRect)setLeftStrStyle{
    CGSize sizeOfStr = [self.normalStr getSizeFromStrFontSize:20];
    return CGRectMake(self.titleAndSuperLeftEdge, self.frame.size.height *0.5 - sizeOfStr.height*0.5, sizeOfStr.width, sizeOfStr.height);
}


#pragma mark - 设置按钮的文字和图片

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    switch (state) {
        case UIControlStateNormal:
        {
            self.normalStr = title;
            break;
        }
        case UIControlStateSelected:
        {
            self.selectedStr = title;
            break;
        }
        case UIControlStateHighlighted:
        {
            self.hightedStr = title;
            break;
        }
        case UIControlStateDisabled:
        {
            self.disabledStr = title;
            break;
        }
            
        default:
            break;
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    switch (state) {
        case UIControlStateNormal:
        {
            self.normalImg = image;
            break;
        }
        case UIControlStateSelected:
        {
            self.normalImg = image;
            break;
        }
        case UIControlStateHighlighted:
        {
            self.normalImg = image;
            break;
        }
        case UIControlStateDisabled:
        {
            self.normalImg = image;
            break;
        }
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan:");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled:");
}

@end
