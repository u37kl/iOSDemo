//
//  ZPRepeatPlayScrollView.h
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/12.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPRepeatPlayScrollView : UIScrollView
@property (nonatomic, assign) NSUInteger scrollTimeInterval;
-(void)setImageArr:(NSArray *)arrImg;
-(void)startTimer;
@end
