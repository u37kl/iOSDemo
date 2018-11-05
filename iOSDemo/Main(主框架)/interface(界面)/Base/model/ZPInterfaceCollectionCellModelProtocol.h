//
//  ZPInterfaceCollectionCellModelProtocol.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZPInterfaceCollectionCellModelProtocol <NSObject>
@property (nonatomic, copy) NSString *viewModelName;
@property (nonatomic, copy) NSString *viewModelItemCellName;
@property (nonatomic, copy) NSString *cellName;

@end

NS_ASSUME_NONNULL_END
