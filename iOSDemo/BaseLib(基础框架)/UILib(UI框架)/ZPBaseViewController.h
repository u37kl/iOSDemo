//
//  ZPViewController.h
//  iOSDemo
//
//  Created by ww on 2018/9/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPBaseViewController : UIViewController
@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, assign) BOOL isHiddleNavBar;


-(void)setLeftBarButtonItem:(UIBarButtonItem *)leftBar;
-(void)setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarList;
-(void)setRightBarButtonItem:(UIBarButtonItem *)rightBar;
-(void)setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarList;

@end
