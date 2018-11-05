//
//  ZPInterfaceCollectionCellProtocol.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPInterfaceCollectionCellModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ZPInterfaceCollectionCellProtocol <NSObject>
-(void)setModel:(id<ZPInterfaceCollectionCellModelProtocol>)model;
@end

NS_ASSUME_NONNULL_END
