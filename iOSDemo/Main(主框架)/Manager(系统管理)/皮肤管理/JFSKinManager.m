//
//  JFSKinManager.m
//  yourenPower
//
//  Created by admin on 2018/5/31.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import "JFSKinManager.h"
#import "JFDefaultSkin.h"
static JFSKinManager *_manager = nil;
@interface JFSKinManager()

@end

@implementation JFSKinManager

+(instancetype)skinManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JFSKinManager alloc] init];
    });
    return _manager;
}

- (instancetype)init
{

    if (self = [super init]) {
        
        self.model = [[JFDefaultSkin alloc] init];

    }
    return self;
}


@end
