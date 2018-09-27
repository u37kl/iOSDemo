//
//  ZPBaseTableViewAnimiationController.m
//  iOSDemo
//
//  Created by ww on 2018/8/28.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseTableViewAnimiationController.h"
#import "Masonry.h"
#import "JFSKinManager.h"
#import "ZPRotateAnimiationViewController.h"
#import "ZPBaseAnimationViewController.h"
#import "ZPMoveAnimationViewController.h"
#import "ZPScaleAnimationViewController.h"
#import "ZPKeyAnimationViewController.h"
#import "ZPBezierViewController.h"
@interface ZPBaseTableViewAnimiationController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *sourceData;
@end

@implementation ZPBaseTableViewAnimiationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.equalTo(self.view);
    }];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self createSourceData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sourceData.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString* title = self.sourceData[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            ZPBaseAnimationViewController *vc = [[ZPBaseAnimationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            ZPMoveAnimationViewController *vc = [[ZPMoveAnimationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            ZPRotateAnimiationViewController *vc = [[ZPRotateAnimiationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            ZPScaleAnimationViewController *vc = [[ZPScaleAnimationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 4:
        {
            ZPKeyAnimationViewController *vc = [[ZPKeyAnimationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 5:
        {
            ZPBezierViewController *vc = [[ZPBezierViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (NSMutableArray *)sourceData
{
    if (!_sourceData) {
        _sourceData = [NSMutableArray array];
    }
    return _sourceData;
}

-(void)createSourceData{
    [self.sourceData addObject:@"CAMediaTiming协议"];
    [self.sourceData addObject:@"基础动画---平移"];
    [self.sourceData addObject:@"基础动画---旋转"];
    [self.sourceData addObject:@"基础动画---形变"];
    [self.sourceData addObject:@"关键帧动画---平移"];
    [self.sourceData addObject:@"复杂动画---贝塞尔曲线"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
