//
//  ZPGestureRecognizerViewController.m
//  iOSDemo
//
//  Created by ww on 2018/6/19.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPGestureRecognizerViewController.h"
#import "JFSKinManager.h"
#import "Masonry.h"
//#import "Otherframework.h"

//#import "JFScreenScale.h"
#import "JFGestureListModel.h"
@interface ZPGestureRecognizerViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation ZPGestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [JFSKinManager skinManager].model.frontColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - tableView代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JFGestureListModel *model = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    cell.textLabel.text = model.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;//    return [JFScreenScale getHeightFromScale:60];
}


#pragma mark - 数据源
- (NSArray *)dataSource
{
    if (!_dataSource) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:4];
        JFGestureListModel *model1 = [[JFGestureListModel alloc] init];
        model1.title = @"点击手势";
        model1.viewControllerName = @"";
        [arr addObject:model1];
        
        JFGestureListModel *model2 = [[JFGestureListModel alloc] init];
        model2.title = @"拖拽手势";
        model2.viewControllerName = @"";
        [arr addObject:model2];
        
        JFGestureListModel *model3 = [[JFGestureListModel alloc] init];
        model3.title = @"长按手势";
        model3.viewControllerName = @"";
        [arr addObject:model3];
        
        JFGestureListModel *model4 = [[JFGestureListModel alloc] init];
        model4.title = @"点击手势";
        model4.viewControllerName = @"";
        [arr addObject:model4];
        _dataSource = arr;
    }
    return _dataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translation = [gesture translationInView:gesture.view];
    NSLog(@"%f --- %f", translation.x, translation.y);
    return YES;
}

@end
