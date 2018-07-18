//
//  ZPEditTableViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/16.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPEditTableViewController.h"
#import "Masonry.h"
#import "JFSKinManager.h"
@interface ZPEditTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation ZPEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionIndexColor = [UIColor blueColor];
    tableView.sectionIndexBackgroundColor = [UIColor orangeColor];
    tableView.sectionIndexTrackingBackgroundColor = [UIColor greenColor];
    tableView.sectionIndexMinimumDisplayRowCount = 6;
    tableView.tableFooterView = [UIView new];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat deviceHeight = [UIScreen mainScreen].bounds.size.width;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth, deviceHeight)];
    backgroundView.backgroundColor = [UIColor orangeColor];
    tableView.backgroundView = backgroundView;
    
    
    if (@available(iOS 9.0, *)) {
        tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"编辑" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(openEdit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.arrM[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [tableView beginUpdates];
//    [self.arrM removeObjectAtIndex:indexPath.row];
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [tableView endUpdates];
    // 开启cell的编辑模式
    /*
    if (indexPath.row == 3) {
        [self.tableView setEditing:YES animated:YES];
    }else if(indexPath.row == 4){
        [self.tableView setEditing:NO animated:YES];
    }
     */
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"canEditRowAtIndexPath");
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"editingStyleForRowAtIndexPath");
    return  UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"commitEditingStyle");
    [self.arrM removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"moveRowAtIndexPath:toIndexPath:");
    NSString *text = self.arrM[sourceIndexPath.row];
    [self.arrM removeObjectAtIndex:sourceIndexPath.row];
    [self.arrM insertObject:text atIndex:destinationIndexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 0;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[@"A",@"B",@"C",@"D",@"E", @"F", @"G"];
}

-(void)openEdit:(UIButton *)btn
{
    if (btn.tag == 0) {
        self.tableView.editing = YES;
        btn.tag = 1;
    }else{
        self.tableView.editing = NO;
        btn.tag = 0;
    }
}

- (NSMutableArray *)arrM
{
    if (!_arrM) {
        _arrM = [NSMutableArray arrayWithCapacity:5];
        for (short i = 0; i<5; i++) {
            [_arrM addObject:[NSString stringWithFormat:@"第%d个cell", i]];
        }
    }
    return _arrM;
}
@end
