//
//  ZPBuildInterfaceViewModel.h
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPBuildInterfaceViewModel : NSObject

@property (nonatomic, copy) NSString *registerSectionCellName;
@property (nonatomic, copy) NSString *registerItemCellName;
//@property (nonatomic, weak) ZPInterfaceContentCollectionView *weakCollectionView;
@property (nonatomic, weak) UICollectionView *weakManagerView;

-(void)getNetRequest;
@end

NS_ASSUME_NONNULL_END
