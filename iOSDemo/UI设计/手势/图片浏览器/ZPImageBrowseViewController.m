//
//  ZPImageBrowseViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/6/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPImageBrowseViewController.h"
#import <Otherframework/Otherframework.h>
#import "JFSKinManager.h"
#import "UIView+Frame.h"
#import "Masonry.h"
#import "ZPImageBrowseModel.h"
@interface ZPImageBrowseViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSPointerArray *imageViewList;
@property (nonatomic, strong) NSMutableArray *scrollImages;
@property (nonatomic, assign) NSUInteger pageNum;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;
@end

@implementation ZPImageBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat deviceWidth = [JFScreenScale getDeviceWidth];
    CGFloat deviceHeight = [JFScreenScale getDeviceHeight];
    self.imageHeight = deviceHeight-64;
    self.imageWidth = deviceWidth;
    
    
    [self loadImageData];
    
    [self loadScrollView];
    
    for (NSUInteger i = 0; i<self.imageUrlList.count; i++) {
//         UIImageView *imageView = (__bridge_transfer UIImageView *)[self.imageViewList pointerAtIndex:i];
        ZPImageBrowseModel *model = self.imageUrlList[i];
        UIImageView *imageView = self.scrollImages[i];
        UIImage *img = [UIImage imageNamed:model.imageUrl];
        imageView.image = img;
    }
}

-(void)loadImageData
{
    
    self.imageUrlList = @[@"gesture_1", @"gesture_2", @"gesture_3", @"gesture_4", @"gesture_5", @"gesture_6"];
}

-(void)loadScrollView
{
    CGFloat deviceWidth = [JFScreenScale getDeviceWidth];
    CGFloat deviceHeight = [JFScreenScale getDeviceHeight] - 64;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
//    scrollView.panGestureRecognizer.delegate = self;
    self.pageNum = 0;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
//    scrollView.maximumZoomScale=2.0;
//    scrollView.minimumZoomScale=0.5;
    scrollView.contentSize = CGSizeMake(deviceWidth * self.imageUrlList.count, deviceHeight);
    
    for (NSUInteger i = 0; i<self.imageUrlList.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(deviceWidth * i, 0, deviceWidth, deviceHeight)];
        view.clipsToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth, deviceHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinGesture:)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [view addGestureRecognizer:pin];
        [view addGestureRecognizer:tap];
        [scrollView addSubview:view];
        [self.scrollImages addObject:imageView];
    }
}


-(void)loadScrollView_M
{
    CGFloat deviceWidth = [JFScreenScale getDeviceWidth];
    CGFloat deviceHeight = [JFScreenScale getDeviceHeight];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
//    scrollView.maximumZoomScale=2.0;
//    scrollView.minimumZoomScale=0.5;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [JFSKinManager skinManager].model.frontColor;
    [scrollView addSubview:contentView];
    scrollView.contentSize = CGSizeMake(deviceWidth * self.imageUrlList.count, deviceHeight);
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(scrollView.mas_height);
        make.width.mas_greaterThanOrEqualTo(0);
    }];
    
    UIImageView *preImg = nil;
    for (NSUInteger i = 0; i<self.imageUrlList.count; i++) {

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageWidth, self.imageHeight)];
        imageView.userInteractionEnabled = YES;
        UIScrollView *imageBackView = [[UIScrollView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinGesture:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        pan.delegate = self;
        [imageBackView addGestureRecognizer:pin];
        [imageView addGestureRecognizer:pan];
        [imageBackView addSubview:imageView];
        [contentView addSubview:imageBackView];
        [imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == self.imageUrlList.count - 1) {
                make.right.equalTo(contentView);
            }
            make.left.equalTo(preImg?preImg.mas_right : contentView);
            make.top.equalTo(contentView);
            make.bottom.equalTo(contentView);
            make.width.mas_equalTo(deviceWidth);
        }];
//        [self.imageViewList addPointer:(__bridge void * _Nullable)imageView];
        [self.scrollImages addObject:imageView];
        preImg = imageView;
    }
}

-(void)handleTapGesture:(UITapGestureRecognizer *)gesture
{
    UIImageView *image = self.scrollImages[self.pageNum];
    CGPoint p = [gesture locationInView:gesture.view];
    image.transform = CGAffineTransformScale(image.transform, 2, 2);
    CGFloat tx = (image.width-self.imageWidth)*0.5 * (self.imageWidth *0.5-p.x)/(self.imageWidth *0.5);
    CGFloat ty = (image.height-self.imageHeight)*0.5 * (self.imageHeight *0.5-p.x)/(self.imageHeight *0.5);
    image.transform = CGAffineTransformTranslate(image.transform, tx, ty);
}
-(void)handlePinGesture:(UIPinchGestureRecognizer *)gesture
{
    UIImageView *image = self.scrollImages[self.pageNum];
    if (gesture.numberOfTouches == 2) {
        CGPoint p1 = [gesture locationOfTouch:0 inView:image.superview];
        CGPoint p2 = [gesture locationOfTouch:1 inView:image.superview];
        NSLog(@"%@ --- %@", NSStringFromCGPoint(p1),NSStringFromCGPoint(p2));
    }
    if(gesture.state == UIGestureRecognizerStateBegan){
  
    }else if (gesture.state == UIGestureRecognizerStateChanged) {

        image.transform = CGAffineTransformScale(image.transform, gesture.scale, gesture.scale);
       
        gesture.scale = 1;
    }else if(gesture.state == UIGestureRecognizerStateEnded){
        if (image.width < self.imageWidth) {
            image.transform = CGAffineTransformIdentity;
//            image.width = self.imageWidth;
//            image.height = self.imageHeight;
//            image.center = image.superview.center;
        }
    }
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    UIImageView *image = self.scrollImages[self.pageNum];
    NSLog(@"x = %f; y = %f",image.x, image.y);
    NSLog(@"tx = %f; ty = %f",image.transform.tx, image.transform.ty);
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint xy = [gesture translationInView:gesture.view];
        if (image.x+xy.x >= 0) {
            image.x = 0;
            return;
        }else if(image.y+xy.y >= 0){
            image.y = 0;
            return;
        }else if (image.bottom+xy.y <= image.superview.bottom){
            image.bottom = image.superview.bottom;
            return;
        }else if (image.right+xy.x <= image.superview.right){
            image.right = image.superview.right;
            return;
        }

        image.transform = CGAffineTransformTranslate(image.transform, xy.x, xy.y);
        [gesture setTranslation:CGPointZero inView:gesture.view];
    }else if(gesture.state == UIGestureRecognizerStateEnded){
        if (image.x >= 0 || image.right <= image.superview.width) {
            self.scrollView.scrollEnabled = YES;
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        UIImageView *imageView = self.scrollImages[self.pageNum];
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint p = [pan velocityInView:gestureRecognizer.view];
        if (p.x > 20) {
            if (imageView.x >= 0) {
                self.scrollView.scrollEnabled = YES;
                return NO;
            }else{
               self.scrollView.scrollEnabled = NO;
                return YES;
            }
        }else if(p.x < -20){
            if (imageView.right <= imageView.superview.width) {
                self.scrollView.scrollEnabled = YES;
                return NO;
            }else{
                self.scrollView.scrollEnabled = NO;
                return YES;
            }
        }else{
            return NO;
        }

    }
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return  YES;
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidScroll");
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewWillBeginDragging");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
//    NSLog(@"");
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidEndDecelerating");
    CGFloat temp = 0;
//    CGFloat allImageWidth = 0;
    CGPoint scrollOffset = scrollView.contentOffset;
//
    for (short i = 0; i<self.imageUrlList.count; i++) {
        if (temp == scrollOffset.x) {
            self.pageNum = i;
        }
//        ZPImageBrowseModel *model = self.imageUrlList[i];
        temp += self.imageWidth;
//        allImageWidth += model.imageWidth;
    }
//    ZPImageBrowseModel *model = self.imageUrlList[self.pageNum];
//    scrollView.contentSize = CGSizeMake(allImageWidth, model.imageHeight);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    NSLog(@"");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
//    UIImageView *imageView = self.scrollImages[self.pageNum];
//    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//
//    }];
//    imageView.center = self.scrollView.center;
    
//    NSLog(@"scrollViewDidZoom");
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.scrollImages[self.pageNum];
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
//    UIImageView *imageView = self.scrollImages[self.pageNum];
//
//    CGFloat deviceWidth = [JFScreenScale getDeviceWidth];
//    CGFloat deviceHeight = [JFScreenScale getDeviceHeight];
//    ZPImageBrowseModel *model = self.imageUrlList[self.pageNum];
//    if (imageView.width <= self.imageWidth) {
//        model.imageWidth = self.imageWidth;
//        model.imageHeight = self.imageHeight;
//    }else{
//        model.imageWidth = imageView.width;
//        model.imageHeight = imageView.height;
//    }
//
//    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(model.imageWidth);
//        make.height.mas_equalTo(model.imageHeight);
//    }];
//    CGFloat temp = 0;
//    for (short i = 0; i<self.imageUrlList.count; i++) {
//
//        ZPImageBrowseModel *model = self.imageUrlList[i];
//        temp += model.imageWidth;
//    }

//    scrollView.contentSize = CGSizeMake(temp, model.imageHeight);
}

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//
//}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)scrollImages
{
    if (!_scrollImages) {
        _scrollImages = [NSMutableArray arrayWithCapacity:self.imageUrlList.count];
    }
    return _scrollImages;
}

- (NSPointerArray *)imageViewList
{
    if (!_imageViewList) {
        _imageViewList = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsWeakMemory];
    }
    return _imageViewList;
}

- (void)setImageUrlList:(NSArray *)imageUrlList
{
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:imageUrlList.count];
    for (NSString *urlString in imageUrlList) {
        ZPImageBrowseModel *model = [[ZPImageBrowseModel alloc] init];
        model.imageUrl = urlString;
        model.imageHeight = self.imageHeight;
        model.imageWidth = self.imageWidth;
        [arrM addObject:model];
    }
    _imageUrlList = [arrM copy];
}

@end
