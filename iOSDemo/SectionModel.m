//
//  SectionModel.m
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self && dict) {
        _name = dict[@"description"];
        _list = [KnowledgeModel getListFromArr:dict[@"dataSource"]];
        return self;
    }
    return nil;
}
@end
