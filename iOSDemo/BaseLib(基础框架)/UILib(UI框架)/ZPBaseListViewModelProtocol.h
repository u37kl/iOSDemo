//
//  ZPBaseListViewModelProtocol.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZPBaseListViewModelProtocol <NSObject>
@property (nonatomic, copy) NSString *registerSectionCellName;
@property (nonatomic, copy) NSString *registerItemCellName;

// 配置viewmodel管理的列表控件属性
-(void)configListView;
@end

NS_ASSUME_NONNULL_END
