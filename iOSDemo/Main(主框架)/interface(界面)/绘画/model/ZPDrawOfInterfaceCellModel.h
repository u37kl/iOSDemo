//
//  ZPDrawOfInterfaceCellModel.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/30.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPDrawOfInterfaceCellModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *viewControllerName;
@property (nonatomic, assign) NSUInteger color;
@property (nonatomic, copy) void(^block)(id model);
@property (nonatomic, copy) void(^update)(ZPDrawOfInterfaceCellModel *model);
@end

NS_ASSUME_NONNULL_END
