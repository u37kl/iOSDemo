//
//  ZPInterfaceCollectionCell.h
//  iOSDemo
//
//  Created by ww on 2018/10/22.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZPInterfaceCollectionCellProtocol <NSObject>

@property (nonatomic, copy) NSString *viewModelName;
@property (nonatomic, copy) NSString *cellName;
@end
@interface ZPInterfaceCollectionCell : UICollectionViewCell

-(void)setModel:(id<ZPInterfaceCollectionCellProtocol>)model;

@end

NS_ASSUME_NONNULL_END
