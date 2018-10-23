//
//  ZPInterfaceCollectionCell.m
//  iOSDemo
//
//  Created by ww on 2018/10/22.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPInterfaceCollectionCell.h"
#import "Masonry.h"
#import "ZPInterfaceContentCollectionView.h"

@interface ZPInterfaceCollectionCell ()
@property (nonatomic, weak) ZPInterfaceContentCollectionView *contentCollectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ZPInterfaceCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout = flowLayout;
        
        ZPInterfaceContentCollectionView *contentCollectionView = [[ZPInterfaceContentCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        contentCollectionView.backgroundColor = [JFSKinManager skinManager].model.flagTitleColor;
        [self.contentView addSubview:contentCollectionView];
        _contentCollectionView = contentCollectionView;
        [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

//- (instancetype)init
//{
//    if (self = [super init]) {
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.minimumLineSpacing = 15;
//        flowLayout.minimumInteritemSpacing = 10;
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
//
//        UICollectionView *contentTableView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//        contentTableView.backgroundColor = [JFSKinManager skinManager].model.flagTitleColor;
//        [self.contentView addSubview:contentTableView];
//        _contentTableView = contentTableView;
//        [contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self.contentView);
//        }];
//    }
//    return self;
//}

-(void)setModel:(id<ZPInterfaceCollectionCellProtocol>)model;
{
    id<UICollectionViewDataSource, UICollectionViewDelegate> viewModel = [[NSClassFromString(model.viewModelName) alloc] init];
    [self.contentCollectionView registerClass:NSClassFromString(model.cellName) forCellWithReuseIdentifier:model.cellName];
    
    self.contentCollectionView.registerItemCellName = model.cellName;
    self.contentCollectionView.viewModelDelegate = (id<ZPInterfaceContentCollectionViewViewModelProtocol>)viewModel;
    self.contentCollectionView.delegate = viewModel;
    self.contentCollectionView.dataSource = viewModel;
    
    [self.contentCollectionView.viewModelDelegate getNetRequest];
}
@end
