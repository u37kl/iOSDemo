//
//  ZPImageQuarzeViewController.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/31.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPImageQuarzeViewController.h"
#import "ZPImageQuarzeView.h"
#import "UIImage+Clip.h"
@interface ZPImageQuarzeViewController ()
@property (nonatomic, weak) ZPImageQuarzeView * view1_1;
@property (nonatomic, weak) ZPImageQuarzeView * view1_2;

@property (nonatomic, weak) ZPImageQuarzeView * view2_1;
@property (nonatomic, weak) ZPImageQuarzeView * view2_2;

@property (nonatomic, weak) ZPImageQuarzeView * view3_1;
@property (nonatomic, weak) ZPImageQuarzeView * view3_2;
@end

@implementation ZPImageQuarzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createImageView];
    [self createWaterImage];
    [self createAddBorderImageView];
}

#pragma mark - 绘制图片
-(void)createImageView
{
    UIImage *image = [UIImage imageNamed:@"Quarze_drawImage_1"];
    ZPImageQuarzeView *view0 = [[ZPImageQuarzeView alloc] init];
    view0.type = ZPImageQuarzeViewTypePoint;
    view0.image = image;
    self.view1_1 = view0;
    [self.view addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.height.equalTo(view0.mas_width);
    }];
    
    ZPImageQuarzeView *view1 = [[ZPImageQuarzeView alloc] init];
    view1.image = image;
    self.view1_2 = view1;
    view1.type = ZPImageQuarzeViewTypeRect;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.left.equalTo(view0.mas_right);
        make.width.equalTo(view0);
        make.height.equalTo(view1.mas_width);
    }];
}



#pragma mark - 图片水印
-(void)createWaterImage
{
    
    ZPImageQuarzeView *view0 = [[ZPImageQuarzeView alloc] init];
    view0.type = ZPImageQuarzeViewTypePoint;
//    view0.image = image;
    self.view2_1 = view0;
    [self.view addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.height.equalTo(view0.mas_width);
        make.top.equalTo(self.view1_1.mas_bottom);
    }];
    
    ZPImageQuarzeView *view1 = [[ZPImageQuarzeView alloc] init];
//    view1.image = image;
    self.view2_2 = view1;
    view1.type = ZPImageQuarzeViewTypeRect;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1_1.mas_bottom);
        make.right.equalTo(self.view);
        make.left.equalTo(view0.mas_right);
        make.width.equalTo(view0);
        make.height.equalTo(view1.mas_width);
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [UIImage imageNamed:@"Quarze_drawImage_2"];
        image = [UIImage drawTextToImage:image text:@"小小App"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view2_1.image = image;
            self.view2_2.image = image;
        });
    });
}

#pragma mark - 裁剪图片并添加边框
-(void)createAddBorderImageView
{
    UIImage *image = [UIImage imageNamed:@"Quarze_drawImage_2"];
    ZPImageQuarzeView *view0 = [[ZPImageQuarzeView alloc] init];
    view0.type = ZPImageQuarzeViewTypePoint;
    view0.image = image;
    self.view3_1 = view0;
    [self.view addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.height.equalTo(view0.mas_width);
        make.top.equalTo(self.view2_1.mas_bottom);
    }];
    
    ZPImageQuarzeView *view1 = [[ZPImageQuarzeView alloc] init];
    view1.image = image;
    self.view3_2 = view1;
    view1.type = ZPImageQuarzeViewTypeRect;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view2_1.mas_bottom);
        make.right.equalTo(self.view);
        make.left.equalTo(view0.mas_right);
        make.width.equalTo(view0);
        make.height.equalTo(view1.mas_width);
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        UIImage *image = [UIImage imageNamed:@"Quarze_drawImage_3"];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(5, 5, image.size.width, image.size.height) cornerRadius:10];
        image = [UIImage clipAndAddBorderImage:image path:path borderWidth:5];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view3_1.image = image;
            self.view3_2.image = image;
        });
    });
    
    [self.view drawViewHierarchyInRect:CGRectZero afterScreenUpdates:YES];
    [self.view snapshotViewAfterScreenUpdates:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self snapShotView];
}

-(void)snapShotView
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *imageName = [NSString stringWithFormat:@"%@.png",[JFDateFormatTool getCurrentData]];
    path =[path stringByAppendingPathComponent:imageName];
    [data writeToFile:path atomically:YES];
}

-(void)snapShotView1
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *imageName = [NSString stringWithFormat:@"%@.png",[JFDateFormatTool getCurrentData]];
    path =[path stringByAppendingPathComponent:imageName];
    [data writeToFile:path atomically:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
