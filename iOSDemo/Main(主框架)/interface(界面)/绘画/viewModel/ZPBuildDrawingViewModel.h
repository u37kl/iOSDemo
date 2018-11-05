//
//  ZPBuildDrawingViewModel.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPBuildDrawingViewModel : NSObject
@property (nonatomic, copy) NSString *registerSectionCellName;
@property (nonatomic, copy) NSString *registerItemCellName;
//@property (nonatomic, weak) ZPInterfaceContentCollectionView *weakCollectionView;
@property (nonatomic, weak) UITableView *weakManagerView;

-(void)getNetRequest;
@end

NS_ASSUME_NONNULL_END
