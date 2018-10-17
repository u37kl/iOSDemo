//
//  ZPMainModuleManager.m
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPMainModuleManager.h"
#import "ZPMainModuleModel.h"
@implementation ZPMainModuleManager

+(NSArray <ZPMainModuleModelProtocol>*)getMainModule
{
    @autoreleasepool {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MainModule" ofType:@"plist"];
        NSArray *moduleList = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:moduleList.count];
        for (NSDictionary *dict in moduleList) {
            ZPMainModuleModel *model = [[ZPMainModuleModel alloc] initWithDict:dict];
            [tempArr addObject:model];
        }
        return tempArr;
    }

}
@end
