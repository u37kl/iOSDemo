//
//  ZPBaseTableView.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseTableView.h"

@implementation ZPBaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setViewModelDelegate:(id<ZPInterfaceContentTableViewViewModelProtocol>)viewModelDelegate
{
    _viewModelDelegate = viewModelDelegate;
    viewModelDelegate.weakManagerView = self;
    [viewModelDelegate configListView];
}

@end
