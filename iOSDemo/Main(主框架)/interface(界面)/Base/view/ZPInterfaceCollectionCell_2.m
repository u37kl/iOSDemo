//
//  ZPInterfaceCollectionCell_2.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPInterfaceCollectionCell_2.h"
#import "ZPInterfaceCollectionCellModelProtocol.h"
#import "ZPBaseListViewModelProtocol.h"
#import "ZPBaseTableView.h"
@interface ZPInterfaceCollectionCell_2 ()
@property (nonatomic, weak) ZPBaseTableView *contentTableView;

@end

@implementation ZPInterfaceCollectionCell_2


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [JFSKinManager skinManager].model.frontColor;
        ZPBaseTableView *contentTableView = [[ZPBaseTableView alloc] init];
        [self.contentView addSubview:contentTableView];
        _contentTableView = contentTableView;
        [contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
        }];
        
    }
    return self;
}

-(void)setModel:(id<ZPInterfaceCollectionCellModelProtocol>)model;
{
    if (!self.contentTableView.belongViewController) {
        self.contentTableView.belongViewController = self.belongViewController;
    }
    id<ZPBaseListViewModelProtocol> viewModelDelegate = [[NSClassFromString(model.viewModelName) alloc] init];
    viewModelDelegate.registerItemCellName = model.viewModelItemCellName;
    self.contentTableView.viewModelDelegate = viewModelDelegate;
    [self.contentTableView.viewModelDelegate getNetRequest];
}

@end
