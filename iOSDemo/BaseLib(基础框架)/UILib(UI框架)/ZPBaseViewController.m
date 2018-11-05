//
//  ZPViewController.m
//  iOSDemo
//
//  Created by ww on 2018/9/11.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPBaseViewController.h"
#import "JFSKinManager.h"
#import "ZPBaseNavigationController.h"
@interface ZPBaseViewController ()

@end

@implementation ZPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [JFSKinManager skinManager].model.backColor;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setIsHiddleNavBar:(BOOL)isHiddleNavBar
{
    _isHiddleNavBar = isHiddleNavBar;
}

-(void)setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarList
{
    
    if (leftBarList == nil || leftBarList.count == 0) {
        return;
    }
    
    if (@available(iOS 11.0 , *)) {
        self.navigationItem.leftBarButtonItems = leftBarList;
    }else{
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        item.width = -8;
        NSMutableArray<UIBarButtonItem *> *arrM = [NSMutableArray arrayWithCapacity:leftBarList.count];
        [arrM addObject:item];
        [arrM addObjectsFromArray:leftBarList];
        self.navigationItem.leftBarButtonItems = arrM;
    }

}

-(void)setLeftBarButtonItem:(UIBarButtonItem *)leftBar
{
    
    if (leftBar == nil) {
        return;
    }
    
    if (@available(iOS 11.0 , *)) {
        self.navigationItem.leftBarButtonItem = leftBar;
    }else{
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        item.width = -16;
        NSMutableArray<UIBarButtonItem *> *arrM = [NSMutableArray arrayWithCapacity:2];
        [arrM addObject:item];
        [arrM addObject:leftBar];
        self.navigationItem.leftBarButtonItems = arrM;
    }
}

-(void)setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarList
{
    
    if (rightBarList == nil || rightBarList.count == 0) {
        return;
    }
    
    if (@available(iOS 11.0 , *)) {
        self.navigationItem.rightBarButtonItems = rightBarList;
    }else{
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        item.width = -8;
        NSMutableArray<UIBarButtonItem *> *arrM = [NSMutableArray arrayWithCapacity:rightBarList.count];
        [arrM addObjectsFromArray:rightBarList];
        [arrM addObject:item];
        self.navigationItem.rightBarButtonItems = arrM;
    }
    
}

-(void)setRightBarButtonItem:(UIBarButtonItem *)rightBar
{
    
    if (rightBar == nil) {
        return;
    }
    
    if (@available(iOS 11.0 , *)) {
        self.navigationItem.rightBarButtonItem = rightBar;
    }else{
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        item.width = -8;
        NSMutableArray<UIBarButtonItem *> *arrM = [NSMutableArray arrayWithCapacity:2];
        [arrM addObject:rightBar];
        [arrM addObject:item];
        self.navigationItem.rightBarButtonItems = arrM;
    }
}

@end
