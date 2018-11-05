//
//  ZPTextQuarzeView.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/31.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ZPTextQuarzeViewType){
    ZPTextQuarzeViewTypeRect,
    ZPTextQuarzeViewTypePoint,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZPTextQuarzeView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) ZPTextQuarzeViewType type;
@end

NS_ASSUME_NONNULL_END
