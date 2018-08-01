//
//  ZPTableSlideCell.h
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/25.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kZPTableSlideCell @"ZPTableSlideCell"



@protocol ZPTableSlideCellProtocol;

@interface ZPTableSlideCell : UITableViewCell

@property (nonatomic, weak) id<ZPTableSlideCellProtocol> weakDelegate;

@end




typedef NS_ENUM(NSInteger, ZPSideslipCellActionStyle) {
    ZPSideslipCellActionStyleDefault = 0,
    ZPSideslipCellActionStyleDestructive = ZPSideslipCellActionStyleDefault, // 删除 红底
    ZPSideslipCellActionStyleNormal // 正常 灰底
};
@interface ZPSideslipCellAction : NSObject
+ (instancetype)rowActionWithStyle:(ZPSideslipCellActionStyle)style title:(nullable NSString *)title handler:(void (^)(ZPSideslipCellAction *action, NSIndexPath *indexPath))handler;
@property (nonatomic, readonly) ZPSideslipCellActionStyle style;
@property (nonatomic, copy, nullable) NSString *title;          // 文字内容
@property (nonatomic, strong, nullable) UIImage *image;         // 按钮图片. 默认无图
@property (nonatomic, assign) CGFloat fontSize;                 // 字体大小. 默认17
@property (nonatomic, strong, nullable) UIColor *titleColor;    // 文字颜色. 默认白色
@property (nonatomic, copy, nullable) UIColor *backgroundColor; // 背景颜色. 默认透明
@property (nonatomic, assign) CGFloat margin;                   // 内容左右间距. 默认15
@end


@protocol ZPTableSlideCellProtocol <NSObject>

@optional;
-(NSArray<ZPSideslipCellAction *> *)slipdeCell:(ZPTableSlideCell *)cell actionListIndexPath:(NSIndexPath *)indexPath;
-(BOOL)slipeCell:(ZPTableSlideCell *)cell canEditIndexPath:(NSIndexPath *)indexPath;

@end

@interface UITableView (ZPTableSlideCell)
- (void)resumeAllCell;
@end
