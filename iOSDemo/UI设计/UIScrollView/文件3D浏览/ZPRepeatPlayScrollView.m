//
//  ZPRepeatPlayScrollView.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/12.
//  Copyright © 2018年 ww. All rights reserved.
//

/* 实现效果
 * 1.创建保存需要轮播的容器
 * 2.初始化scrollView，
 *   1) 关闭水平、垂直的滚动条.
 *   2) 关闭弹簧效果.
 *   3) 设置代理方法.
 *   5) 设置contentSize，创建UIImageView并且设置在内容视图中的位置
 *   6) 定义常量，一张图片的大小、滚动方向
 * 3.添加页面标识符
 *
 * 4.添加NSTimer，设置时间
 * 5.实现scrollViewWillBeginDragging代理方法
 *   1) 关闭定时器
 * 6.实现scrollViewDidScroll代理方法
 *   1) 获取当前的偏移量，根据正负判断方向
 *   2) 如果为正方向，当滚动到最后一个图片完全显示(最后一个图片与第一张图片一样)时，将contentOff设置为0;
 *   3) 如果为负方向，当滚动到第一个图片完全显示(最后一个图片与第一张图片一样)时，将contentOff设置为(arr.count - 1) * ImageViewWidth。
 *   4) 计算现在为第几张 index= (NSUInteger)(contentOffset/imageViewWidth)
 *   5) 如果为正方向，比较index对应的UIImageView的centerX与conntentOffset大小，大：pageIndex = (index == arr.count - 1) ? 1 : index+1;
 *   6) 如果为负方向，比较index对应的UIImageView的centerX与conntentOffset大小，小：pageIndex = (index == arr.count - 1) ? 1 : index+1;
 * 7.实现scrollViewDidEndDragging代理方法
 *   1) contentOffSet.x = (page - 1)*ImageViewWidth
 * 8.实现scrollViewDidEndDecelerating代理方法
 *   1) 开启定时器
 */

#import "ZPRepeatPlayScrollView.h"
#import "UIView+Frame.h"
#import "ZPPageControl.h"
@interface ZPRepeatPlayScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSPointerArray *imgViewList;
@property (nonatomic, assign) BOOL isHasImage;
@property (nonatomic, assign) BOOL isTimerValid;
@property (nonatomic, weak) ZPPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSUInteger scrollDirection; // 内容移动方向 0:none， 1:left， 2:right；
@property (nonatomic, assign) CGFloat oldTranslation; // 旧的偏移量
@end
@implementation ZPRepeatPlayScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
//        self.pagingEnabled = YES;
        [self setDecelerationRate:200];
        self.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [self.timer invalidate];
}

-(void)setImageArr:(NSArray *)arrImg
{
    if (arrImg == nil || arrImg.count == 0) {
        return;
    }

    self.isHasImage = YES;
    self.contentSize = CGSizeMake(self.width * (arrImg.count + 1), self.height);
    self.imgViewList = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];
    for (short i = 0; i < arrImg.count; i++) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width) * i, 0, self.width, self.height)];
        imgView.image = [UIImage imageNamed:arrImg[i]];
        [self.imgViewList addPointer:(__bridge void *)imgView];
        [self addSubview:imgView];
    }
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width) * arrImg.count, 0, self.width, self.height)];
    imgView.image = [UIImage imageNamed:arrImg[0]];
    [self.imgViewList addPointer:(__bridge void *)imgView];
    [self addSubview:imgView];
    
}

-(void)startTimer
{
    if (self.isHasImage == NO) {
        return;
    }
    
    // 添加页码提示控件
    ZPPageControl *pageControl = [[ZPPageControl alloc] initWithFrame:CGRectMake(0, (self.y + self.height) - 30, self.width, 30)];
    pageControl.pageIndicatorTintColor =[UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControl.numberOfPages = self.imgViewList.count - 1;
    pageControl.currentPage = 0;
    [self.superview addSubview:pageControl];
    self.pageControl = pageControl;
    //    pageControl.defersCurrentPageDisplay = YES;
//    [pageControl addTarget:self action:@selector(pageChanged:)forControlEvents:UIControlEventValueChanged];
    
    __weak typeof(self)weakSelf = self;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSUInteger index = (NSUInteger)(weakSelf.contentOffset.x/weakSelf.width);
        if (index + 1 == weakSelf.imgViewList.count - 1) {
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf setContentOffset:CGPointMake((index + 1) * weakSelf.width, 0) animated:NO];
            } completion:^(BOOL finished) {
                [weakSelf setContentOffset:CGPointMake(0, 0) animated:NO];
            }];
        }else if(index + 1 > weakSelf.imgViewList.count - 1){
            [weakSelf setContentOffset:CGPointMake(0, 0) animated:NO];
            [weakSelf setContentOffset:CGPointMake(self.width, 0) animated:YES];
        }else{
            
            [weakSelf setContentOffset:CGPointMake((index + 1) * self.width, 0) animated:YES];
        }
        
        weakSelf.pageControl.currentPage = (index == weakSelf.imgViewList.count - 2) ? 0 : index+1;
    }];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollTimeInterval]];
    self.isTimerValid = YES;
    self.timer = timer;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate distantFuture]];
    self.isTimerValid = NO;
    CGPoint contentOffSet;
    if (scrollView.contentOffset.x >= scrollView.width * (self.imgViewList.count - 1)) {
        contentOffSet = CGPointMake(scrollView.contentOffset.x - .5, scrollView.contentOffset.y);
    }else{
        contentOffSet = CGPointMake(scrollView.contentOffset.x + .5, scrollView.contentOffset.y);
    }
    [scrollView setContentOffset:contentOffSet animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (self.isTimerValid) {
        return;
    }
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
    NSLog(@"%@", NSStringFromCGPoint(point));
    
    // 内容视图向左移动
    if (point.x - self.oldTranslation < 0) {
        self.scrollDirection = 1;
        if (scrollView.contentOffset.x >= scrollView.width * (self.imgViewList.count - 1)) {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }else{
        // 内容视图向右移动
        self.scrollDirection = 2;
        if (scrollView.contentOffset.x <= 0) {
            [scrollView setContentOffset:CGPointMake(scrollView.width * (self.imgViewList.count-1), 0) animated:NO];
        }
    }
    self.oldTranslation = point.x;
    NSUInteger index = (NSUInteger)(scrollView.contentOffset.x/scrollView.width);
    UIImageView *imgView = [self.imgViewList pointerAtIndex:index];
    if (scrollView.contentOffset.x >= imgView.center_X) {
        self.pageControl.currentPage = (index == self.imgViewList.count - 2) ? 0 : index+1;
    }else{
        self.pageControl.currentPage = index;
    }
}



-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {

        NSUInteger index = (NSUInteger)(self.contentOffset.x/self.width);
        UIImageView *temp = (__bridge UIImageView *)[self.imgViewList pointerAtIndex:index];
        if (scrollView.contentOffset.x >= temp.center_X) {
            [UIView animateWithDuration:0.25 animations:^{
                [scrollView setContentOffset:CGPointMake((index + 1) * scrollView.width, 0) animated:YES];
            } completion:^(BOOL finished) {
                NSUInteger index = (NSUInteger)(scrollView.contentOffset.x/scrollView.width);
                self.pageControl.currentPage = (index == self.imgViewList.count - 2) ? 0 : index+1;
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                [scrollView setContentOffset:CGPointMake((index) * scrollView.width, 0) animated:YES];
            } completion:^(BOOL finished) {
                NSUInteger index = (NSUInteger)(scrollView.contentOffset.x/scrollView.width);
                self.pageControl.currentPage = (index == self.imgViewList.count - 2) ? 0 : index+1;
            }];
        }
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollTimeInterval]];
        self.scrollDirection = 0;
        self.isTimerValid = YES;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = (NSUInteger)(self.contentOffset.x/self.width);
    
    if (self.scrollDirection == 2) {
        [UIView animateWithDuration:0.25 animations:^{
            
            [scrollView setContentOffset:CGPointMake(index * scrollView.width, 0) animated:YES];
        } completion:^(BOOL finished) {
            NSUInteger index = (NSUInteger)(scrollView.contentOffset.x/scrollView.width);
            self.pageControl.currentPage = (index == self.imgViewList.count - 2) ? self.imgViewList.count - 1 : index;
        }];
    }else if(self.scrollDirection == 1){
        [UIView animateWithDuration:0.25 animations:^{
            [scrollView setContentOffset:CGPointMake((index + 1) * scrollView.width, 0) animated:YES];
        } completion:^(BOOL finished) {
            NSUInteger index = (NSUInteger)(scrollView.contentOffset.x/scrollView.width);
            self.pageControl.currentPage = (index == self.imgViewList.count - 2) ? 0 : index+1;
        }];
    }
    self.scrollDirection = 0;
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollTimeInterval]];
    self.isTimerValid = YES;

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

// 点击PageControl中的小点点。
-(void)pageChanged:(UIPageControl *)page
{
    [self.pageControl updateCurrentPageDisplay];
}

- (NSUInteger)scrollTimeInterval
{
    if (_scrollTimeInterval) {
        return _scrollTimeInterval;
    }else{
        return 2;
    }
}

@end
