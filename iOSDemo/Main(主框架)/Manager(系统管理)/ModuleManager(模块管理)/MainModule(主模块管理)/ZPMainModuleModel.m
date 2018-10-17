//
//  ZPMainModuleModel.m
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPMainModuleModel.h"

@implementation ZPMainModuleModel

@synthesize className = _className;
@synthesize title = _title;
@synthesize iconNormal = _iconNormal;
@synthesize iconSelected = _iconSelected;


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.className = dict[@"className"];
        self.title = dict[@"titleName"];
        self.iconNormal = dict[@"iconNameNormal"];
        self.iconSelected = dict[@"iconNameSelected"];
    }
    return self;
}


@end
