//
//  ZPMainModuleModel.h
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPMainModuleModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZPMainModuleModel : NSObject <ZPMainModuleModelProtocol>
//@property (nonatomic, copy) NSString *className;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *iconNormal;
//@property (nonatomic, copy) NSString *iconSelected;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
