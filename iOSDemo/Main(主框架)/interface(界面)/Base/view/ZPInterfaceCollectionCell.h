//
//  ZPInterfaceCollectionCell.h
//  iOSDemo
//
//  Created by ww on 2018/10/22.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPInterfaceCollectionCellProtocol.h"

#define kZPInterfaceCollectionCell @"ZPInterfaceCollectionCell"
NS_ASSUME_NONNULL_BEGIN

@interface ZPInterfaceCollectionCell : UICollectionViewCell <ZPInterfaceCollectionCellProtocol>

-(void)setModel:(id<ZPInterfaceCollectionCellProtocol>)model;

@end

NS_ASSUME_NONNULL_END
