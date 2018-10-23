//
//  ZPBaseLabel.m
//  iOSDemo
//
//  Created by ww on 2018/10/18.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseLabel.h"
#import <objc/runtime.h>
@interface ZPBaseLabel ()
@property (nonatomic, weak) CATextLayer *textLayer;
@end

@implementation ZPBaseLabel

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    NSLog(@"resolveInstanceMethod:  %@", NSStringFromSelector(sel));
    
//    if (sel == @selector(speak)) {
//        class_addMethod([self class], sel, (IMP)speak, "V@:");
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector:  %@", NSStringFromSelector(aSelector));
//    Bird *bird = [[Bird alloc] init];
//    if ([bird respondsToSelector: aSelector]) {
//        return bird;
//    }
    return [super forwardingTargetForSelector: aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation: %@", NSStringFromSelector([anInvocation selector]));
//    if ([anInvocation selector] == @selector(code)) {
//        Monkey *monkey = [[Monkey alloc] init];
//        [anInvocation invokeWithTarget:monkey];
//    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"method signature for selector: %@", NSStringFromSelector(aSelector));
    if (aSelector == @selector(code)) {
        return [NSMethodSignature signatureWithObjCTypes:"V@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"doesNotRecognizeSelector: %@", NSStringFromSelector(aSelector));
//    [super doesNotRecognizeSelector:aSelector];
}


//+(BOOL)resolveInstanceMethod:(SEL)sel
//{
//    return YES;
//}

+ (Class)layerClass
{
    return [CATextLayer class];
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    super.textAlignment = NSTextAlignmentRight;
    switch (textAlignment) {
        case NSTextAlignmentRight:
        {
            self.textLayer.alignmentMode = kCAAlignmentRight;
            break;
        }
        
        case NSTextAlignmentCenter:
        {
            self.textLayer.alignmentMode = kCAAlignmentRight;
            break;
        }
            
        case NSTextAlignmentNatural:
        {
            self.textLayer.alignmentMode = kCAAlignmentNatural;
            break;
        }
            
        case NSTextAlignmentJustified:
        {
            self.textLayer.alignmentMode = kCAAlignmentJustified;
            break;
        }
            
        default:
        {
            self.textLayer.alignmentMode = kCAAlignmentLeft;
            break;
        }
    }

}


- (void)setWrappingLine:(BOOL)isWrappingLine
{
    self.textLayer.wrapped = isWrappingLine;
}

- (void)setEllipsis:(BOOL)isEllipsis
{
    self.textLayer.truncationMode = (isEllipsis == YES) ? kCATruncationEnd : kCATruncationNone;
}

- (CATextLayer *)textLayer
{
    return (CATextLayer *)self.layer;
}
- (void)setText:(NSString *)text
{
    super.text = text;
    self.textLayer.string = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    super.textColor = textColor;
    //set layer text color
    self.textLayer.foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font
{
    super.font = font;
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

@end
