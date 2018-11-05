//
//  ZPBaseTableView.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPBaseListViewModelProtocol.h"
@class ZPBaseTableView;
NS_ASSUME_NONNULL_BEGIN

@protocol ZPInterfaceContentTableViewViewModelProtocol <NSObject,ZPBaseListViewModelProtocol>

@property (nonatomic, weak) ZPBaseTableView *weakManagerView;

-(void)getNetRequest;
@end

@interface ZPBaseTableView : UITableView
@property (nonatomic, strong) id<ZPInterfaceContentTableViewViewModelProtocol> viewModelDelegate;
@end

NS_ASSUME_NONNULL_END
