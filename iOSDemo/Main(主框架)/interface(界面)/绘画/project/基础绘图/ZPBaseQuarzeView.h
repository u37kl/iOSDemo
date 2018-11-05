//
//  ZPBaseQuarzeView.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/30.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZPBaseQuarzeViewType){
    ZPBaseQuarzeViewTypeLine,
    ZPBaseQuarzeViewTypeRects,
    ZPBaseQuarzeViewTypeCircle,
    ZPBaseQuarzeViewTypeOval,
    ZPBaseQuarzeViewTypeRoundRect,
    ZPBaseQuarzeViewTypeDashed,
    ZPBaseQuarzeViewTypeHalfRound,
    ZPBaseQuarzeViewTypeCurveLine
};
NS_ASSUME_NONNULL_BEGIN

@interface ZPBaseQuarzeView : UIView

@property (nonatomic, assign) ZPBaseQuarzeViewType type;
@end

NS_ASSUME_NONNULL_END
