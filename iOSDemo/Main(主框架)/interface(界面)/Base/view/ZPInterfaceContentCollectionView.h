//
//  ZPInterfaceContentCollectionView.h
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPBaseListViewModelProtocol.h"
@class ZPInterfaceContentCollectionView;
NS_ASSUME_NONNULL_BEGIN

@protocol ZPInterfaceContentCollectionViewViewModelProtocol <NSObject, ZPBaseListViewModelProtocol>
@property (nonatomic, weak) ZPInterfaceContentCollectionView *weakManagerView;

-(void)getNetRequest;
@end

@interface ZPInterfaceContentCollectionView : UICollectionView
@property (nonatomic, strong) id<ZPInterfaceContentCollectionViewViewModelProtocol> viewModelDelegate;


@end

NS_ASSUME_NONNULL_END
