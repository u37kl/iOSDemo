//
//  ZPClipImageViewController.m
//  iphoneTestRelease
//
//  Created by ww on 2018/11/1.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPClipImageViewController.h"
#import "UIImage+Clip.h"
@interface ZPClipImageViewController ()<CAAction>
@property (weak, nonatomic) UIImageView *imageV;

//开始时手指的点
/** <#注释#> */
@property (nonatomic, assign) CGPoint startP;

/** <#注释#> */
@property (nonatomic, weak) UIView *coverV;

@end

@implementation ZPClipImageViewController

/**
 *  懒加载coverV
 *  1.能够保证超始至终只有一份
 *  2.什么时候用到什么时候才去加载
 */
-(UIView *)coverV {
    
    if (_coverV == nil) {
        
        //添加一个UIView
        UIView *coverV = [[UIView alloc] init];
        coverV.backgroundColor = [UIColor blackColor];
        coverV.alpha = 0.7;
        _coverV = coverV;
        [self.view addSubview:coverV];
    }
    return _coverV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"image_clip"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
    }];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [imageView addGestureRecognizer:pan];
    self.imageV = imageView;

    self.view.layer.actions
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    
    //判断手势的状态
    CGPoint curP = [pan locationInView:self.imageV];
    if(pan.state == UIGestureRecognizerStateBegan) {
        self.startP = curP;
    } else if(pan.state == UIGestureRecognizerStateChanged) {
        
        CGFloat x = self.startP.x;
        CGFloat y = self.startP.y;
        CGFloat w = curP.x - self.startP.x;
        CGFloat h = curP.y - self.startP.y;
        CGRect rect =  CGRectMake(x, y, w, h);
        
        //添加一个UIView
        self.coverV.frame = rect;
        
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        
        
        UIImage *image = [UIImage clipScreenWithView:self.imageV rect:self.coverV.frame];
        if (image) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
            
            [self.coverV removeFromSuperview];
        }
        
        // c创建屏幕快照
//        UIView *snapView = [self.imageV snapshotViewAfterScreenUpdates:NO];
//        [self.view addSubview:snapView];
//        [self.imageV removeFromSuperview];
        
    }
    
}

// snapshotViewAfterScreenUpdates
// drawviewhierarchyinrect

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        NSLog(@"保存图片成功，image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    }else{
        NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    }
}

@end
