//
//  ZPButton.m
//  iOSDemo
//
//  Created by ww on 2018/6/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPButton.h"
//#import "NSString+Extension.h"

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
//    CGSize sizeOfStr = [self.normalStr getSizeFromStrFontSize:12];
    CGSize sizeOfImg = self.normalImg.size;
    return CGRectMake(self.frame.size.width *0.5 - sizeOfImg.width*0.5, 0, sizeOfImg.width, sizeOfImg.height);
}


-(CGRect)setRightImgStyle{
    CGSize sizeOfStr = CGSizeZero;//[self.normalStr getSizeFromStrFontSize:12];
    CGSize sizeOfImg = self.normalImg.size;
    return CGRectMake(sizeOfStr.width + 8, self.frame.size.height *0.5 - sizeOfImg.height*0.5, sizeOfImg.width, sizeOfImg.height);
}

-(CGRect)setBottomStrStyle{
    CGSize sizeOfStr = CGSizeZero;//[self.normalStr getSizeFromStrFontSize:12];
    CGSize sizeOfImg = self.normalImg.size;
    return CGRectMake(0, self.frame.size.height - sizeOfStr.height, self.frame.size.width, sizeOfStr.height);
}

-(CGRect)setLeftStrStyle{
    CGSize sizeOfStr = CGSizeZero;//[self.normalStr getSizeFromStrFontSize:12];
    return CGRectMake(0, self.frame.size.height *0.5 - sizeOfStr.height*0.5, sizeOfStr.width, sizeOfStr.height);
}




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

@end
