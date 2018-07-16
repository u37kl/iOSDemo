//
//  ZPScrollViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/9.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPScrollViewController.h"
#import "ZPButton.h"
@interface ZPScrollViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ZPScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1023, 1447)];
    imageView.image = [UIImage imageNamed:@"gesture_4"];
    self.imageView = imageView;
    [scrollView addSubview:imageView];
    self.scrollView = scrollView;
    
    // 测试属性
    scrollView.contentSize =CGSizeMake(1023, 1447);
    scrollView.alwaysBounceVertical = YES;
    scrollView.alwaysBounceHorizontal = YES;
//    scrollView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    scrollView.directionalLockEnabled = YES;
    scrollView.contentOffset = CGPointZero;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tap.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;
    
    //
    scrollView.maximumZoomScale = 2;
    scrollView.minimumZoomScale = 0.5;
    scrollView.delegate = self;
    
//    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidZoom");
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"scrollViewWillBeginZooming");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"scrollViewDidEndZooming");
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
//        [scrollView flashScrollIndicators];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}



- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

-(void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    if (self.scrollView.zoomScale > 1.0) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }else{
        CGPoint point = [gesture locationInView:gesture.view];
//        CGFloat x = point.x - 50;
//
//        CGFloat y = point.y - 50;
//        [self.scrollView zoomToRect:CGRectMake(x, y, 50, 50) animated:YES];
        CGRect rect = [self getRectWithScale:self.scrollView.maximumZoomScale andCenter:point];
        [self.scrollView zoomToRect:rect animated:YES];
    }
    
}

- (CGRect)getRectWithScale:(CGFloat)scale andCenter:(CGPoint)center{
    CGRect newRect = CGRectZero;
    newRect.size.width =  _scrollView.frame.size.width/scale;
    newRect.size.height = _scrollView.frame.size.height/scale;
    newRect.origin.x = center.x - newRect.size.width * 0.5;
    newRect.origin.y = center.y - newRect.size.height * 0.5;
    
    return newRect;
}


-(void)test1{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f", self.scrollView.zoomScale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
