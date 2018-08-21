//
//  ZPTableSlideCell.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/25.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPTableSlideCell.h"
#import "JFSKinManager.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, ZPSideslipCellState) {
    ZPSideslipCellStateNormal,
    ZPSideslipCellStateAnimating,
    ZPSideslipCellStateOpen
};
#define kLeftMoveEdge 10
@interface ZPSideslipCellAction ()
@property (nonatomic, copy) void (^handler)(ZPSideslipCellAction *action, NSIndexPath *indexPath);
@property (nonatomic, assign) ZPSideslipCellActionStyle style;
@end
@implementation ZPSideslipCellAction
+ (instancetype)rowActionWithStyle:(ZPSideslipCellActionStyle)style title:(NSString *)title handler:(void (^)(ZPSideslipCellAction *action, NSIndexPath *indexPath))handler {
    ZPSideslipCellAction *action = [ZPSideslipCellAction new];
    action.title = title;
    action.handler = handler;
    action.style = style;
    return action;
}

- (CGFloat)margin {
    return _margin == 0 ? 15 : _margin;
}
@end




@interface ZPTableSlideCell()
@property(nonatomic, weak) UIPanGestureRecognizer *contentPan;
@property(nonatomic, assign) BOOL isSlide;
@property(nonatomic, assign) ZPSideslipCellState state;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIView *btnContainView;
@end
@implementation ZPTableSlideCell

#pragma mark - init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSlipe:)];
        pan.delegate = self;
        [self.contentView addGestureRecognizer:pan];

        self.contentPan = pan;
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
//    if (_sideslip) [self hiddenSideslip];
}


#pragma mark - 页面布局方法
- (void)layoutSubviews
{
    NSArray<UIButton *> *btnList = _btnContainView.subviews;
    CGFloat leftEdge = 0;
    for (UIButton *btn in btnList) {
        CGRect btnFrame = btn.frame;
        btnFrame.origin.x = leftEdge;
        btn.frame = btnFrame;
        leftEdge += btnFrame.size.width;
    }
    CGRect btnContainFrame = _btnContainView.frame;
    btnContainFrame.size.width = leftEdge;
    btnContainFrame.origin.x = self.frame.size.width - leftEdge;
    btnContainFrame.size.height = self.frame.size.height;
    _btnContainView.frame = btnContainFrame;
    [super layoutSubviews];
}


#pragma mark -触摸事件处理方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 如果cell处于侧滑开启状态，关闭当前cell侧滑
    if (self.isSlide) {
        [self resumeCell];
    }else{
        // 如果cell不处于侧滑开启状态，关闭当前tableView中存在的其他cell的侧滑状态
        [super touchesBegan:touches withEvent:event];
        // 因此当前被触摸cell的btnContainView，否则点击时进入选中状态，contentView透明度不为1，会将btnContainView显示出来
        _btnContainView.hidden = YES;
        [self.tableView resumeAllCell];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer != _contentPan) {
        return YES;
    }
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translation = [pan translationInView:gestureRecognizer.view];
    // touchesBegan逻辑一样
    if (self.isSlide) {
        [self resumeCellAddAnimate];
        return NO;
    }else{
        [self.tableView resumeAllCell];
    }
    BOOL shouldBegin = NO;
    // 读取代理
    // 询问代理是否需要侧滑
    if (self.weakDelegate && [self.weakDelegate respondsToSelector:@selector(slipeCell:canEditIndexPath:)]) {
        shouldBegin = [self.weakDelegate slipeCell:self canEditIndexPath:[self indexPath]];
        
    }else{
        return NO;
    }
    
    if (shouldBegin) {
        // 向代理获取侧滑展示内容数组
        if (self.weakDelegate && [self.weakDelegate respondsToSelector:@selector(slipdeCell:actionListIndexPath:)]) {
            NSArray <ZPSideslipCellAction*> *actions = [self.weakDelegate slipdeCell:self actionListIndexPath:[self indexPath]];
            if (actions == nil || actions.count == 0) {
                return NO;
            }else{
                // 设置btnContainView中的按钮
                [self setAction:actions];
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
    
    
    // 如果是移动方向与水平方向夹角180<x<135 || 0<x<45，在这个范围内，表示用户在进行水平滑动
    if (fabs(translation.y) <= fabs(translation.x)) {
        return YES;
    }
    return  NO;
}

- (void)handleSlipe:(UIPanGestureRecognizer *)gesture
{
    CGRect gestureFrame = gesture.view.frame;
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint offset = [gesture translationInView:gesture.view];
        if (gestureFrame.origin.x+offset.x > 15) {
            gestureFrame.origin.x = 15;
        }else if(gestureFrame.origin.x + offset.x < -(_btnContainView.frame.size.width + kLeftMoveEdge)){
            gestureFrame.origin.x = - (_btnContainView.frame.size.width + kLeftMoveEdge);
            
        }else{
            gestureFrame.origin.x += offset.x;
        }
//        NSLog(@"%@   %@", NSStringFromCGPoint(gestureFrame.origin), NSStringFromCGPoint(offset));
        gesture.view.frame = gestureFrame;
        [gesture setTranslation:CGPointZero inView:gesture.view];
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        if (gestureFrame.origin.x > 0) {
            [self resumeCellAddAnimate];
        }
        UIButton *btn = _btnContainView.subviews.lastObject;
        if(gestureFrame.origin.x < - btn.frame.size.width * 0.5){
            gestureFrame.origin.x = - _btnContainView.frame.size.width;
            [UIView animateWithDuration:0.25 animations:^{
                gesture.view.frame = gestureFrame;
            } completion:^(BOOL finished) {
                self.state = ZPSideslipCellStateOpen;
                // 记录当前开启侧滑状态的cell，当点击其他cell时，可以关闭该cell的侧滑状态
                objc_setAssociatedObject(self.tableView, @selector(handleSlipe:), [self indexPath], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
        }else{
            gestureFrame.origin.x = 0;
            [UIView animateWithDuration:0.25 animations:^{
                gesture.view.frame = gestureFrame;
            }];
        }
    }
}

#pragma mark - 按钮点击方法
-(void)actionBtnDidClicked:(UIButton *)btn
{
    // 向代理获取侧滑展示内容数组
    if (self.weakDelegate && [self.weakDelegate respondsToSelector:@selector(slipdeCell:actionListIndexPath:)]) {
        NSArray <ZPSideslipCellAction*> *actions = [self.weakDelegate slipdeCell:self actionListIndexPath:[self indexPath]];
        if (actions != nil || actions.count != 0) {
            ZPSideslipCellAction *action = actions[btn.tag];
            action.handler(action, [self indexPath]);
            [self resumeCell];
        }
    }
    
}

#pragma mark - cell恢复初始状态的动画
-(void)resumeCell
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setContentX:0];
    } completion:^(BOOL finished) {
        self.state = ZPSideslipCellStateNormal;
    }];
    
}

-(void)resumeCellAddAnimate
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setContentX:-10];
    } completion:^(BOOL finished) {
        [self resumeCell];
    }];
}


#pragma mark - contentView的x值、action的设置方法
-(void)setContentX:(CGFloat)XValue
{
    CGRect frame = self.contentView.frame;
    frame.origin.x = XValue;
    self.contentView.frame = frame;
}

-(void)setAction:(NSArray<ZPSideslipCellAction *> *)arrList
{
    if (arrList == nil || arrList.count == 0) {
        return;
    }
    if (_btnContainView) {
        [_btnContainView removeFromSuperview];
    }
    _btnContainView = [UIView new];
    [self insertSubview:_btnContainView atIndex:0];
//    [self insertSubview:_btnContainView belowSubview:self.contentView];
    for (int i = 0; i<arrList.count;i++) {
        ZPSideslipCellAction *action = arrList[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:action.title forState:UIControlStateNormal];
        [btn setTitle:action.title forState:UIControlStateHighlighted];
        
        if (action.backgroundColor) {
            btn.backgroundColor = action.backgroundColor;
        } else {
            btn.backgroundColor = action.style == ZPSideslipCellActionStyleNormal? [UIColor colorWithRed:200/255.0 green:199/255.0 blue:205/255.0 alpha:1] : [UIColor redColor];
        }
        
        if (action.fontSize != 0) {
            btn.titleLabel.font = [UIFont systemFontOfSize:action.fontSize];
        }
        
        if (action.titleColor) {
            [btn setTitleColor:action.titleColor forState:UIControlStateNormal];
        }
        
        CGFloat width = [action.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : btn.titleLabel.font} context:nil].size.width;
        width += (action.image ? action.image.size.width : 0);
        btn.frame = CGRectMake(0, 0, width + action.margin*2, self.frame.size.height);
        
        btn.tag = i;
        [btn addTarget:self action:@selector(actionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btnContainView addSubview:btn];
    }
}

- (void)setState:(ZPSideslipCellState)state {
    _state = state;
    
    if (state == ZPSideslipCellStateNormal) {
        self.tableView.scrollEnabled = YES;
        self.tableView.allowsSelection = YES;
        self.isSlide = NO;
//        for (ZPTableSlideCell *cell in self.tableView.visibleCells) {
//            if ([cell isKindOfClass:ZPTableSlideCell.class]) {
//                cell.sideslip = NO;
//            }
//        }
        
    } else if (state == ZPSideslipCellStateAnimating) {
        
    } else if (state == ZPSideslipCellStateOpen) {
        //处于侧滑开启状态时，关闭tableView滚动和选中，保证当关闭侧滑时，cell出现selected状态；并且保证滚动前关闭所有cell的侧滑状态
        self.isSlide = YES;
        self.tableView.scrollEnabled = NO;
        self.tableView.allowsSelection = NO;
//        for (ZPSideslipCell *cell in self.tableView.visibleCells) {
//            if ([cell isKindOfClass:ZPSideslipCell.class]) {
//                cell.sideslip = YES;
//            }
//        }
    }
}


#pragma mark - get方法
- (UITableView *)tableView {
    if (!_tableView) {
        id view = self.superview;
        while (view && [view isKindOfClass:[UITableView class]] == NO) {
            view = [view superview];
        }
        _tableView = (UITableView *)view;
    }
    return _tableView;
}

- (NSIndexPath *)indexPath {
    return [self.tableView indexPathForCell:self];
}

@end

@implementation UITableView (ZPTableSlideCell)
- (void)resumeAllCell {
    NSIndexPath *index = objc_getAssociatedObject(self, @selector(handleSlipe:));
    ZPTableSlideCell *cell = [self cellForRowAtIndexPath:index];
    [cell resumeCell];
}
@end

