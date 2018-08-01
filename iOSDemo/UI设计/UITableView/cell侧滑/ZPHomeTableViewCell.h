//
//  ZPHomeTableViewCell.h
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/30.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTableSlideCell.h"
#import "LYHomeCellModel.h"

#define kZPHomeTableViewCell @"ZPHomeTableViewCell"
@interface ZPHomeTableViewCell : ZPTableSlideCell
@property (nonatomic, strong) LYHomeCellModel *model;
@end
