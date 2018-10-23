//
//  ZPInterfaceContentCollectionView.h
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class ZPInterfaceContentCollectionView;

@protocol ZPInterfaceContentCollectionViewViewModelProtocol <NSObject>

@property (nonatomic, copy) NSString *registerSectionCellName;
@property (nonatomic, copy) NSString *registerItemCellName;
@property (nonatomic, weak) ZPInterfaceContentCollectionView *weakCollectionView;

-(void)getNetRequest;
@end

@interface ZPInterfaceContentCollectionView : UICollectionView
@property (nonatomic, copy) NSString *registerSectionCellName;
@property (nonatomic, copy) NSString *registerItemCellName;
@property (nonatomic, strong) id<ZPInterfaceContentCollectionViewViewModelProtocol> viewModelDelegate;


@end

NS_ASSUME_NONNULL_END
