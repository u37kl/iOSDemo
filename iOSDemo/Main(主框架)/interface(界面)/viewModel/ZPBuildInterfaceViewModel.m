//
//  ZPBuildInterfaceViewModel.m
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBuildInterfaceViewModel.h"
#import "ZPControlOfInterfaceCollectionCell.h"
#import "ZPBuildInterfaceCellModel.h"
@interface ZPBuildInterfaceViewModel ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray <ZPBuildInterfaceCellModel *> *dataSource;
@end

@implementation ZPBuildInterfaceViewModel

-(void)getNetRequest
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buildInterfaceItem" ofType:@"plist"];
    NSArray *fileArr = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in fileArr) {
        ZPBuildInterfaceCellModel *model = [[ZPBuildInterfaceCellModel alloc] init];
        model.cellType = [dict[@"cellType"] integerValue];
        [self.dataSource addObject:model];
    }
    [self.weakCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count > 0 ? 1 : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZPBuildInterfaceCellModel *model = self.dataSource[indexPath.row];
    ZPControlOfInterfaceCollectionCell *cell = nil;
    if (model.cellType) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.registerItemCellName forIndexPath:indexPath];
    }
//    ZPControlOfInterfaceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZPControlOfInterfaceCollectionCell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
        return 10.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([JFScreenScale getDeviceWidth] - 30 - 10)*0.5, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

- (NSMutableArray<ZPBuildInterfaceCellModel *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
