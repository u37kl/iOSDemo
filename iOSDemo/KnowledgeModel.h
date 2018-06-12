//
//  KnowledgeModel.h
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KnowledgeModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *className;

- (instancetype)initWithDict:(NSDictionary *)dict;
+(NSArray<KnowledgeModel *> *)getListFromArr:(NSArray *)arr;
@end
