//
//  ZPInterfaceContentCollectionView.m
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPInterfaceContentCollectionView.h"
#import "ZPBuildInterfaceViewModel.h"
#import "ZPControlOfInterfaceCollectionCell.h"
@implementation ZPInterfaceContentCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [JFSKinManager skinManager].model.backColor;

//        self.contentCollectionView.registerItemCellName = model.cellName;

    }
    return self;
}

- (void)setViewModelDelegate:(id<ZPInterfaceContentCollectionViewViewModelProtocol>)viewModelDelegate
{
    _viewModelDelegate = viewModelDelegate;
    viewModelDelegate.weakManagerView = self;
}

@end
