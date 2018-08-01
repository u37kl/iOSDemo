//
//  ZPCellSlideTableViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/18.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPCellSlideTableViewController.h"
#import "ZPHomeTableViewCell.h"
#import "JFSKinManager.h"
#import "Masonry.h"
#import "LYHomeCellModel.h"
@interface ZPCellSlideTableViewController ()<UITableViewDataSource, UITableViewDelegate, ZPTableSlideCellProtocol>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<LYHomeCellModel *> *listArr;
@end

@implementation ZPCellSlideTableViewController

static const char MJRefreshReloadDataBlockKey1 = '\0';
static const char MJRefreshReloadDataBlockKey2 = '\0';
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:235/255.0 blue:243/255.0 alpha:1];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[ZPHomeTableViewCell class] forCellReuseIdentifier:kZPHomeTableViewCell];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    NSLog(@"%p, %p", &MJRefreshReloadDataBlockKey1, &MJRefreshReloadDataBlockKey2);
    self.listArr = [LYHomeCellModel requestDataArray];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZPHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kZPHomeTableViewCell forIndexPath:indexPath];
    cell.weakDelegate = self;
    [cell setModel:self.listArr[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor redColor];
//}
//
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [UIView animateWithDuration:0.25 animations:^{
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//    }];
//}

- (BOOL)slipeCell:(ZPTableSlideCell *)cell canEditIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<ZPSideslipCellAction *> *)slipdeCell:(ZPTableSlideCell *)cell actionListIndexPath:(NSIndexPath *)indexPath{
    ZPSideslipCellAction *action1 = [ZPSideslipCellAction rowActionWithStyle:ZPSideslipCellActionStyleNormal title:@"取消关注" handler:^(ZPSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"取消关注");
        //        [sideslipCell hiddenAllSideslip];
    }];
    ZPSideslipCellAction *action2 = [ZPSideslipCellAction rowActionWithStyle:ZPSideslipCellActionStyleDestructive title:@"删除" handler:^(ZPSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
        //        [_dataArray removeObjectAtIndex:indexPath.row];
        //        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    ZPSideslipCellAction *action3 = [ZPSideslipCellAction rowActionWithStyle:ZPSideslipCellActionStyleNormal title:@"置顶" handler:^(ZPSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"置顶");
        //        [sideslipCell hiddenAllSideslip];
    }];
    
    NSArray *array = @[action1, action2, action3];
    return array;
}


@end
