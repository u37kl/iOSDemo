//
//  ZPBuildDrawingViewModel.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBuildDrawingViewModel.h"
#import "ZPInterfaceCollectionCellProtocol.h"
#import "ZPListCellProtocol.h"
#import "ZPDrawOfInterfaceCellModel.h"
@interface ZPBuildDrawingViewModel () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray <ZPDrawOfInterfaceCellModel *> *dataSource;
@end

@implementation ZPBuildDrawingViewModel

- (void)setWeakManagerView:(UITableView *)weakManagerView
{
    _weakManagerView = weakManagerView;
}

-(void)configListView
{
   self.weakManagerView.delegate = self;
   self.weakManagerView.dataSource = self;
   [self.weakManagerView registerClass:NSClassFromString(self.registerItemCellName) forCellReuseIdentifier:self.registerItemCellName];
   self.weakManagerView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.weakManagerView.backgroundColor = [JFSKinManager skinManager].model.backColor;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZPDrawOfInterfaceCellModel *model = self.dataSource[indexPath.row];
    if (model.block) {
        model.block(model);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count > 0 ? 1: 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ZPDrawOfInterfaceCellModel *model = self.dataSource[indexPath.row];
    id<ZPListCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:@"ZPDrawOfInterfaceTableViewCell" forIndexPath:indexPath];
    [cell setModel:model];
    return (UITableViewCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JFScreenScale getHeightFromScale:110];
}

- (void)getNetRequest
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buildCALayerItem" ofType:@"plist"];
    NSArray *fileArr = [NSArray arrayWithContentsOfFile:path];
    __weak typeof(self)weakSelf = self;
    for (NSDictionary *dict in fileArr) {
        ZPDrawOfInterfaceCellModel *model = [[ZPDrawOfInterfaceCellModel alloc] init];
        model.imageName = dict[@"imageName"];
        model.titleName = dict[@"titleName"];
        model.viewControllerName = dict[@"viewControllerName"];
        model.color = [dict[@"Color"] integerValue];
        model.block = ^(ZPDrawOfInterfaceCellModel *model) {
            if (model.viewControllerName) {
                UIViewController *vc = [[NSClassFromString(model.viewControllerName) alloc] init];
                [weakSelf.weakManagerView.belongViewController.navigationController pushViewController:vc animated:YES];
            }
        };
        
        [self.dataSource addObject:model];
    }
    [self.weakManagerView reloadData];
}

- (NSMutableArray<ZPDrawOfInterfaceCellModel *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
