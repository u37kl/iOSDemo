//
//  ZPEditTableViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/16.
//  Copyright © 2018年 ww. All rights reserved.
//


/*
 * tableView分编辑模式和非编辑模式
 * tableView通过设置editing属性进入编辑模式，通过设置调用tableView:canEditRowAtIndexPath:代理方法，设置所有cell进入编辑模式。
 * 编辑模式分为两种一种是移动cell，一种增删。通过tableView:editingStyleForRowAtIndexPath:代理方法判断是哪一种模式，返回UITableViewCellEditingStyleNone表示为移动，其他类型为增删。
 * 在做增删操作时，调用tableView:commitEditingStyle：forRowAtIndexPath:完成数据源的增删和cell的删除。
 * 在做移动操作时，调用tableView:moveRowAtIndexPath:toIndexPath:方法完成数据源的移动。
 * 不实现tableView:editingStyleForRowAtIndexPath:，默认为删除，如果第一次返回UITableViewCellEditingStyleNone，第二次返回UITableViewCellEditingStyleDelete，则编辑模式下即支持删除，又支持移动。
 */
#import "ZPEditTableViewController.h"
#import "Masonry.h"
#import "JFSKinManager.h"
#import "ZPEditTableViewCell.h"
@interface ZPEditTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, assign) BOOL isDelete; // 设置编辑模式下是否为删除。
@property (nonatomic, assign) CGFloat oldContentOffY; // 旧的contentOffset的Y
@property (nonatomic, assign) NSUInteger scrollDirction; // 0:none，1:手指上滑，2:手指下滑
@end

@implementation ZPEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [self setTableViewProperty];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"编辑" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(openEdit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
#pragma mark - 初始化tableView属性
- (void)setTableViewProperty
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 设置索引
    self.tableView.sectionIndexColor = [UIColor blueColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor orangeColor];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor greenColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 6;
    // 设置tableFooterView
    self.tableView.tableFooterView = [UIView new];
    // 注册cell
    [self.tableView registerClass:[ZPEditTableViewCell class] forCellReuseIdentifier:kZPEditTableViewCell];
    // 设置tableView的背景view
    CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat deviceHeight = [UIScreen mainScreen].bounds.size.width;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth, deviceHeight)];
    backgroundView.backgroundColor = [UIColor orangeColor];
    self.tableView.backgroundView = backgroundView;
    
    if (@available(iOS 9.0, *)) {
        self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kZPEditTableViewCell forIndexPath:indexPath];
    cell.textLabel.text = self.arrM[indexPath.row];
    return cell;
}


#pragma mark - 代理方法 -- cell显示与隐藏

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.oldContentOffY = scrollView.contentOffset.y;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"-%f --- %f", scrollView.contentOffset.y, self.oldContentOffY);
    if(scrollView.contentOffset.y - self.oldContentOffY > 0){
        self.scrollDirction = 1;
    }else if(scrollView.contentOffset.y - self.oldContentOffY < 0){
        self.scrollDirction = 2;
    }else{
        self.scrollDirction = 0;
    }
    self.oldContentOffY = scrollView.contentOffset.y;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.scrollDirction == 1) {
        cell.backgroundColor = [UIColor redColor];
    }else if(self.scrollDirction == 2){
        cell.backgroundColor = [UIColor greenColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"didEndDisplayingCell");
}

#pragma mark - cell高亮效果
/*
 * 重写- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated方法。
 * 设置cell的selectionStyle为UITableViewCellSelectionStyleNone
 */
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 设置cell右侧小图标
/*
 * 当cell右侧小图标为UITableViewCellAccessoryDetailButton时，可以点击，点击后调用tableView:accessoryButtonTappedForRowWithIndexPath:
 * 当自定义右侧小图标时，通过accestion
 */
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryDetailButton;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"accessoryButtonTappedForRowWithIndexPath");
}



#pragma mark - 编辑模式
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"canEditRowAtIndexPath");
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"editingStyleForRowAtIndexPath");
    if (self.isDelete) {
        
        return  UITableViewCellEditingStyleDelete;
    }else{
         return  UITableViewCellEditingStyleNone;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"editActionsForRowAtIndexPath");
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"添加" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action1.backgroundColor = [UIColor greenColor];
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action2.backgroundColor = [UIColor redColor];
    
    return @[action1, action2];
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

/*
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 0;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[@"A",@"B",@"C",@"D",@"E", @"F", @"G"];
}
 */

#pragma mark - 打开编辑模式
-(void)openEdit:(UIButton *)btn
{
    if (btn.tag == 0) {
        // 先设置editing属性，再设置isDelete属性，第一次打开编辑模式为移动，第二次打开编辑模式为移动+删除
        self.tableView.editing = YES;
        self.isDelete = YES;
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
        for (short i = 0; i<50; i++) {
            [_arrM addObject:[NSString stringWithFormat:@"第%d个cell", i]];
        }
    }
    return _arrM;
}
@end
