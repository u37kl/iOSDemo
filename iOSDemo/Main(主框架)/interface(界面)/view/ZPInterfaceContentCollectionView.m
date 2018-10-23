//
//  ZPInterfaceContentCollectionView.m
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPInterfaceContentCollectionView.h"

@implementation ZPInterfaceContentCollectionView

- (void)setViewModelDelegate:(id<ZPInterfaceContentCollectionViewViewModelProtocol> _Nonnull)viewModelDelegate
{
    _viewModelDelegate = viewModelDelegate;
    viewModelDelegate.registerItemCellName = self.registerItemCellName;
    viewModelDelegate.registerSectionCellName = self.registerSectionCellName;
    viewModelDelegate.weakCollectionView = self;
}
@end
