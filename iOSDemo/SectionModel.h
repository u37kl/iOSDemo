//
//  SectionModel.h
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger row;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
