//
//  ZPUseViewController.m
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPUseViewController.h"
#import <objc/runtime.h>
@interface ZPUseViewController () <CALayerDelegate>
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *imageName;
@property (nonatomic, weak) CAScrollLayer *layer;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ZPUseViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    CALayer *layer1 = [self replicatorLayer_Grid];
//    CALayer *layer2 = [self replicatorLayer_Wave];
//    CALayer *layer3 = [self replicatorLayer_Triangle];
//    
//    layer1.position = CGPointMake(50, 100);
//    [self.view.layer addSublayer:layer1];
//    
//    layer2.position = CGPointMake(100, 200);
//    [self.view.layer addSublayer:layer2];
//    
//    layer3.position = CGPointMake(100, 400);
//    [self.view.layer addSublayer:layer3];
    
//        [self create1];
//    [self create11];

}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.imageView removeFromSuperview];
//
//}

-(void)create11
{
    int scale = [UIScreen mainScreen].scale;
    CGRect rect = CGRectMake(0, 0, 500, 500);
    rect.origin.x *= scale;
    rect.origin.y *= scale;
    rect.size.width *= scale;
    rect.size.height *= scale;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return;
    }
    [self.view.layer renderInContext:context];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //  这里是重点, 意思是取范围内的cgimage
    ;
    for (int i= 0; i<4000/500; i++) {
        for (int j = 0; j<6000/500; j++) {
            CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(j*500, i*500, 500, 500));
            UIImage * newImage = [UIImage imageWithCGImage:cgImage];
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
            path = [path stringByAppendingFormat:@"/image_%i_%i.png",i,j];
            [UIImagePNGRepresentation(newImage) writeToFile:path atomically:YES];
        }

    }
}
-(void)create1
{
    @autoreleasepool {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"jpg"];
//            NSData *data = [NSData dataWithContentsOfFile:path];
//        UIImage *image8 = [UIImage imageNamed:@"a"];
        UIImage *image8 = [UIImage imageWithContentsOfFile:path];
        NSLog(@"%lud", sizeof(image8));
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.view addSubview:image];
        image.image = image8;
        self.imageView = image;
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    [btn1 setImage:[UIImage imageNamed:@"ui_leftNavBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    [self setLeftBarButtonItem:left];
//    [self createCATiledLayer];
}


@end
