//
//  ZPImageQuarzeView.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/31.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ZPImageQuarzeViewType){
    ZPImageQuarzeViewTypeRect,
    ZPImageQuarzeViewTypePoint,
};
NS_ASSUME_NONNULL_BEGIN

@interface ZPImageQuarzeView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) ZPImageQuarzeViewType type;
@end

NS_ASSUME_NONNULL_END
