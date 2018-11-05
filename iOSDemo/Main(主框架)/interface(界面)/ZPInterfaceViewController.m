//
//  ZPInterfaceViewController.m
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPInterfaceViewController.h"
#import "Masonry.h"
#import "UIColor+Gradient.h"
#import "UIView+Frame.h"
#import <Otherframework/Otherframework.h>

#import "ZPInterfaceCollectionCell.h"
#import "ZPInterfaceCollectionCell_2.h"
#import "ZPInterfaceCollectionCellModel.h"
#import "ZPInterfaceCollectionCellModelProtocol.h"

#define kAnimationOfInterfaceViewControllerNavBottomLineLayer @"kAnimationOfInterfaceViewControllerNavBottomLineLayer"
@interface ZPInterfaceViewController () <CAAnimationDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic ,weak) CAShapeLayer *navViewBottomLineLayer;
@property (nonatomic ,weak) CADisplayLink *displayLink;
@property (nonatomic ,assign) short currentIndex;
@property (nonatomic ,assign) short nextIndex;
@property (nonatomic, strong) NSPointerArray *pointerArr;
@property (nonatomic, copy) NSString *cellName;
@property (nonatomic, strong) NSMutableArray *dateSource;
@end

@implementation ZPInterfaceViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadConfigureFile];
    [self setLeftNavigationBtn];
    [self setNavigationMiddleView];
    [self createCollectionView];
    
    NSLog(@"%@",testM);
    
}

-(void)loadConfigureFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"infaceConfigureFile" ofType:@"plist"];
    NSDictionary *fileDict = [NSDictionary dictionaryWithContentsOfFile:path];

    NSArray *arr = fileDict[@"contentList"];
    self.dateSource = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSDictionary *dict in arr) {
        ZPInterfaceCollectionCellModel *model = [[ZPInterfaceCollectionCellModel alloc] init];
        model.viewModelName = dict[@"viewModelName"];
        model.viewModelItemCellName = dict[@"viewModelItemCellName"];
        model.cellName = dict[@"cellName"];
        [self.dateSource addObject:model];
    }
}

#pragma mark - 初始化导航栏
-(void)setLeftNavigationBtn
{
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    [btn1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"ui_leftNavBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    [self setLeftBarButtonItem:left];
}

-(void)setNavigationMiddleView
{
    UIColor *normalColor = [JFSKinManager skinManager].model.navTitleNormalColor;
    UIColor *selectedColor = [JFSKinManager skinManager].model.navTitleSelectedColor;
    
    int fontSize = 14;
    CGFloat navWidth = kDeviceWidth - 100;
    CGFloat navHeight = 44;
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, navWidth, navHeight)];
    self.navigationItem.titleView = navView;
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.tag = 0;
    [btn1 setTitle:@"直播" forState:UIControlStateNormal];
    [btn1 setTitle:@"直播" forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(handleNavBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:normalColor forState:UIControlStateNormal];
    [btn1 setTitleColor:selectedColor forState:UIControlStateSelected|UIControlStateHighlighted];
    [btn1 setTitleColor:selectedColor forState:UIControlStateSelected];
    btn1.titleLabel.font = [UIFont getPFRWithSize:fontSize];
    [navView addSubview:btn1];
    [self.pointerArr addPointer:(__bridge void * _Nullable)(btn1)];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(btn1.superview);
    }];
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"绘图" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont getPFRWithSize:fontSize];
    btn2.tag = 1;
    [btn2 setTitleColor:normalColor forState:UIControlStateNormal];
    [btn2 setTitleColor:selectedColor forState:UIControlStateSelected|UIControlStateHighlighted];
    [btn2 setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(handleNavBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btn2];
    [self.pointerArr addPointer:(__bridge void * _Nullable)(btn2)];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btn2.superview);
        make.left.equalTo(btn1.mas_right);
        make.width.equalTo(btn1);
    }];
    
    UIButton *btn3 = [[UIButton alloc] init];
    [btn3 setTitle:@"直播" forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont getPFRWithSize:fontSize];
    btn3.tag = 2;
    [btn3 setTitleColor:normalColor forState:UIControlStateNormal];
    [btn3 setTitleColor:selectedColor forState:UIControlStateSelected|UIControlStateHighlighted];
    [btn3 setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(handleNavBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btn3];
    [self.pointerArr addPointer:(__bridge void * _Nullable)(btn3)];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btn3.superview);
        make.left.equalTo(btn2.mas_right);
        make.width.equalTo(btn1);
    }];
    
    UIButton *btn4 = [[UIButton alloc] init];
    [btn4 setTitle:@"直播" forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont getPFRWithSize:fontSize];
    btn4.tag = 3;
    [btn4 setTitleColor:normalColor forState:UIControlStateNormal];
    [btn4 setTitleColor:selectedColor forState:UIControlStateSelected|UIControlStateHighlighted];
    [btn4 setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn4 addTarget:self action:@selector(handleNavBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btn4];
    [self.pointerArr addPointer:(__bridge void * _Nullable)(btn4)];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btn4.superview);
        make.left.equalTo(btn3.mas_right);
        make.width.equalTo(btn1);
    }];
    
    UIButton *btn5 = [[UIButton alloc] init];
    [btn5 setTitle:@"直播" forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont getPFRWithSize:fontSize];
    btn5.tag = 4;
    [btn5 setTitleColor:normalColor forState:UIControlStateNormal];
    [btn5 setTitleColor:selectedColor forState:UIControlStateSelected|UIControlStateHighlighted];
    [btn5 setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn5 addTarget:self action:@selector(handleNavBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:btn5];
    [self.pointerArr addPointer:(__bridge void * _Nullable)(btn5)];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(btn5.superview);
        make.left.equalTo(btn4.mas_right);
        make.width.equalTo(btn1);
    }];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.lineWidth = 3;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.strokeColor = [JFSKinManager skinManager].model.frontColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat lineWidth = navWidth / 5 - 10;
    [path moveToPoint:CGPointMake(5, 0)];
    [path addLineToPoint:CGPointMake(lineWidth + 5, 0)];
    shapeLayer.path = path.CGPath;
    shapeLayer.frame = CGRectMake(0, navHeight - 5, navWidth / 5, 5);
    [navView.layer addSublayer:shapeLayer];
    [shapeLayer.presentationLayer addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleLayerRefresh)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    link.paused = YES;
    self.displayLink = link;
    self.navViewBottomLineLayer = shapeLayer;
    btn1.selected = YES;
}

-(void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake([JFScreenScale getDeviceWidth] - 30, [JFScreenScale getRootViewSafeBounds].height - 44 - 20);
    flowLayout.minimumLineSpacing = 30;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [JFSKinManager skinManager].model.backColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    
    for (ZPInterfaceCollectionCellModel *model in self.dateSource) {
        [collectionView registerClass:NSClassFromString(model.cellName) forCellWithReuseIdentifier:model.cellName];
    }
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dateSource.count > 0 ? 1: 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dateSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZPInterfaceCollectionCellModel *model = self.dateSource[indexPath.row];
    id<ZPInterfaceCollectionCellProtocol> cell = [collectionView dequeueReusableCellWithReuseIdentifier:model.cellName forIndexPath:indexPath];
    if (!((UICollectionViewCell *)cell).belongViewController) {
        ((UICollectionViewCell *)cell).belongViewController = self;
    }
    [cell setModel:(id<ZPInterfaceCollectionCellModelProtocol>)model];
    return (UICollectionViewCell *)cell;
}



#pragma mark - 导航栏按钮状态改变

-(void)animationStartForBtnState:(UIButton *)btn
{
    self.nextIndex = btn.tag;
    UIButton *oldBtn = [self.pointerArr pointerAtIndex:self.currentIndex];
    [oldBtn setTitleColor:[JFSKinManager skinManager].model.navTitleSelectedColor forState:UIControlStateNormal];
    oldBtn.selected = NO;
}

-(void)animationEndForBtnState
{
    UIButton *oldBtn = [self.pointerArr pointerAtIndex:self.currentIndex];
    [oldBtn setTitleColor:[JFSKinManager skinManager].model.navTitleNormalColor forState:UIControlStateNormal];
    UIButton *newBtn = [self.pointerArr pointerAtIndex:self.nextIndex];
    newBtn.selected = YES;
    [newBtn setTitleColor:[JFSKinManager skinManager].model.navTitleNormalColor forState:UIControlStateNormal];
    self.currentIndex = self.nextIndex;
}

#pragma mark - 导航栏动画
-(void)createAnimationForNavBottomLine:(UIButton *)btn
{
    CGFloat temp = btn.frame.origin.x - self.navViewBottomLineLayer.frame.origin.x;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.2 * fabs(temp/self.navViewBottomLineLayer.frame.size.width);
    animation.fromValue = @(self.navViewBottomLineLayer.position.x);
    animation.toValue = @(self.navViewBottomLineLayer.position.x + temp);
    animation.repeatCount = 1;

    animation.removedOnCompletion=NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [self.navViewBottomLineLayer addAnimation:animation forKey:kAnimationOfInterfaceViewControllerNavBottomLineLayer];
    [self.displayLink setPaused:NO];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.displayLink setPaused:YES];
    NSLog(@"%@", NSStringFromCGPoint(self.navViewBottomLineLayer.position));
    self.navViewBottomLineLayer.position = CGPointMake(self.navViewBottomLineLayer.bounds.size.width * self.nextIndex + self.navViewBottomLineLayer.bounds.size.width * 0.5, self.navViewBottomLineLayer.position.y);
    [self.navViewBottomLineLayer removeAnimationForKey:kAnimationOfInterfaceViewControllerNavBottomLineLayer];
    [self animationEndForBtnState];
}

#pragma mark - 监听动画过程
-(void)handleLayerRefresh
{
    NSLog(@"%@", NSStringFromCGRect(self.navViewBottomLineLayer.presentationLayer.frame));
    CGFloat width = self.navViewBottomLineLayer.presentationLayer.frame.size.width;
    NSInteger index = self.navViewBottomLineLayer.presentationLayer.frame.origin.x / width;
    if (self.pointerArr.count > index+1) {
        if (index >= self.nextIndex) {   // 底部横杠往左滑
            UIButton *leftBtn = [self.pointerArr pointerAtIndex:index];
            UIButton *rightBtn = [self.pointerArr pointerAtIndex:index + 1];
            CGFloat scale = (rightBtn.frame.origin.x - self.navViewBottomLineLayer.presentationLayer.frame.origin.x) / width;
            NSLog(@"右到左 --- %f  --- %f", self.navViewBottomLineLayer.presentationLayer.frame.origin.x, scale);
            UIColor *endColor = [JFSKinManager skinManager].model.navTitleSelectedColor;
            UIColor *beginColor = [JFSKinManager skinManager].model.navTitleNormalColor;
            UIColor *currentColor =[UIColor colorFromBeginColor:beginColor toEndColor:endColor scale:scale];
            
            if (leftBtn.isSelected) {
                [leftBtn setTitleColor:currentColor forState:UIControlStateSelected];
            }else{
                [leftBtn setTitleColor:currentColor forState:UIControlStateNormal];
            }
            beginColor = [JFSKinManager skinManager].model.navTitleSelectedColor;
            endColor = [JFSKinManager skinManager].model.navTitleNormalColor;
            
            currentColor =[UIColor colorFromBeginColor:beginColor toEndColor:endColor scale:scale];
            if (rightBtn.isSelected) {
                [rightBtn setTitleColor:currentColor forState:UIControlStateSelected];
            }else{
                [rightBtn setTitleColor:currentColor forState:UIControlStateNormal];
            }
            
        }else if (index < self.nextIndex){                             // 底部横杠往右滑
            UIButton *leftBtn = [self.pointerArr pointerAtIndex:index];
            UIButton *rightBtn = [self.pointerArr pointerAtIndex:index + 1];
            CGFloat scale = (self.navViewBottomLineLayer.presentationLayer.frame.origin.x - leftBtn.frame.origin.x) / width;
            NSLog(@"左到右 --- %f  --- %f", self.navViewBottomLineLayer.presentationLayer.frame.origin.x, scale);
            UIColor *beginColor = [JFSKinManager skinManager].model.navTitleSelectedColor;
            UIColor *endColor = [JFSKinManager skinManager].model.navTitleNormalColor;
            
            UIColor *currentColor =[UIColor colorFromBeginColor:beginColor toEndColor:endColor scale:scale];
            
            if (leftBtn.isSelected) {
                [leftBtn setTitleColor:currentColor forState:UIControlStateHighlighted];
            }else{
                [leftBtn setTitleColor:currentColor forState:UIControlStateNormal];
            }
            endColor = [JFSKinManager skinManager].model.navTitleSelectedColor;
            beginColor = [JFSKinManager skinManager].model.navTitleNormalColor;

            currentColor =[UIColor colorFromBeginColor:beginColor toEndColor:endColor scale:scale];
            if (rightBtn.isSelected) {
                [rightBtn setTitleColor:currentColor forState:UIControlStateSelected];
            }else{
                [rightBtn setTitleColor:currentColor forState:UIControlStateNormal];
            }
        }
        
    }
    
}

#pragma mark - 导航栏按钮点击处理
-(void)handleNavBarBtnClick:(UIButton *)btn
{
    if (btn.tag == self.currentIndex || [self.navViewBottomLineLayer animationForKey:kAnimationOfInterfaceViewControllerNavBottomLineLayer]) {
        return;
    }

    CGRect frame = self.navViewBottomLineLayer.frame;
    frame.origin.x = btn.tag * frame.size.width;
    [self animationStartForBtnState:btn];
    [self createAnimationForNavBottomLine:btn];
}

#pragma mark - 数据结构
- (NSPointerArray *)pointerArr
{
    if (!_pointerArr) {
        _pointerArr = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];
    }
    return _pointerArr;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
 
 -(void)test1{
 [self.navigationController popViewControllerAnimated:YES];
 }
 
 -(void)test{
 
 [self.view setNeedsDisplay];
 return;
 ZPInterfaceViewController *vc = [[ZPInterfaceViewController alloc] init];
 vc.index = self.index + 1;
 vc.title = [NSString stringWithFormat:@"哈哈%ld", vc.index];
 NSInteger i = vc.index % 6;
 switch (i) {
 case 0:
 {
 vc.isHiddleNavBar = true;
 break;
 }
 
 case 1:
 {
 vc.isHiddleNavBar = false;
 break;
 }
 
 case 2:
 {
 vc.isHiddleNavBar = true;
 break;
 }
 
 case 3:
 {
 vc.isHiddleNavBar = false;
 break;
 }
 
 case 4:
 {
 vc.isHiddleNavBar = true;
 break;
 }
 case 5:
 {
 vc.isHiddleNavBar = false;
 break;
 }
 default:
 break;
 }
 
 [self.navigationController pushViewController:vc animated:YES];
 }
*/

@end
