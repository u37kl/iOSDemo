//
//  ZPMainModuleManager.h
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPMainModuleModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZPMainModuleManager : NSObject
+(NSArray <ZPMainModuleModelProtocol>*)getMainModule;
@end

NS_ASSUME_NONNULL_END
