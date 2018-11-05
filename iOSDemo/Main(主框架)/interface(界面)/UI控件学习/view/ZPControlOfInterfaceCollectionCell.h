//
//  ZPControlOfInterfaceCollectionCell.h
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kZPControlOfInterfaceCollectionCell @"ZPControlOfInterfaceCollectionCell"
NS_ASSUME_NONNULL_BEGIN

@protocol ZPControlOfInterfaceCollectionCellModelProtocol <NSObject>

@property (nonatomic, assign) NSUInteger cellType;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *typeName;

@end

@interface ZPControlOfInterfaceCollectionCell : UICollectionViewCell

-(void)setModel:(id<ZPControlOfInterfaceCollectionCellModelProtocol>)model;
@end

NS_ASSUME_NONNULL_END
