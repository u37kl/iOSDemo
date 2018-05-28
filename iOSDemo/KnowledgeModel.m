//
//  KnowledgeModel.m
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "KnowledgeModel.h"

@implementation KnowledgeModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self && dict) {
        _name = dict[@"name"];
        _descriptions = dict[@"description"];
        return self;
    }
    return nil;
}
@end
