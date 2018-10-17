//
//  ZPMainModuleModelProtocol.h
//  iOSDemo
//
//  Created by ww on 2018/10/15.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZPMainModuleModelProtocol <NSObject>

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconNormal;
@property (nonatomic, copy) NSString *iconSelected;
@end

NS_ASSUME_NONNULL_END
