//
//  ViewController.m
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"


#import "KnowledgeModel.h"
#import "SectionModel.h"
#import "MainTableViewCell.h"
#import "iOSNotificationViewController.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, copy) NSArray<SectionModel *> *sectionModelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UITableView *mainTableView = [[UITableView alloc] init];
    mainTableView.backgroundColor = [UIColor getUIColorFromRGB:0xe5e5e5];
    [self.view addSubview:mainTableView];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    self.mainTableView = mainTableView;
    [mainTableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:kMainTableViewCell];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    mainTableView.tableFooterView = [UIView new];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, getSize(70))];
    view.backgroundColor = [UIColor redColor];
    mainTableView.tableHeaderView = view;


    ZPLog(@"");
//    NSNumber *num1 = @(12.01);
//    NSLog(@"%s", [num1 objCType]);
//    if (strcmp([num objCType], @encode(double))) {
//        return [NSString stringWithFormat:@".2%f", [num doubleValue]];
//    }else if(strcmp([num objCType], @encode(float))){
//        return [NSString stringWithFormat:@"%.2f", [num floatValue]];
//    }else{
//        return [NSString stringWithFormat:@"%ld", [num integerValue]];
//    }
}


#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel *model = self.sectionModelArray[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowledgeModel *model = self.sectionModelArray[indexPath.section].list[indexPath.row];
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMainTableViewCell];
    [cell setModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return getSize(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return getSize(30);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor getUIColorFromRGB:0xe5e5e5];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    // 对齐方式
    style.alignment = NSTextAlignmentLeft;
    // 首行缩进
    style.firstLineHeadIndent = getSize(15);
    
    SectionModel *model = self.sectionModelArray[section];
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:model.name attributes:@{
                NSParagraphStyleAttributeName : style,
                NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Light" size:getSize(12)],
                NSForegroundColorAttributeName : [UIColor grayColor]
    }];
    label.attributedText = attrText;
    return  label;
}

#pragma mark - 点击cell跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    KnowledgeModel *model = self.sectionModelArray[indexPath.section].list[indexPath.row];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(model.className) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)handleViewControllerPush:(NSInteger)row
{
    switch (row) {
        case 0:
            {
                iOSNotificationViewController *vc = [[iOSNotificationViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kfirstNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSArray<KnowledgeModel *> *)cellModelArray
//{
//    if (!_cellModelArray) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"knowledgeList" ofType:@"plist"];
//        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
//        for (NSDictionary *dict in arr) {
//            KnowledgeModel *model = [[KnowledgeModel alloc] initWithDict:dict];
//            [arrM addObject:model];
//        }
//        _cellModelArray = [arrM copy];
//    }
//    return _cellModelArray;
//}

- (NSArray<SectionModel *> *)sectionModelArray
{
    if (!_sectionModelArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SectionList" ofType:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSDictionary *dict in arr) {
            SectionModel *model = [[SectionModel alloc] initWithDict:dict];
            [arrM addObject:model];
        }
        _sectionModelArray = [arrM copy];
    }
    return _sectionModelArray;
}

@end
