//
//  ZPBuildInterfaceCellModel.h
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPBuildInterfaceCellModel : NSObject

@property (nonatomic, assign) NSUInteger cellType;  // cell类型，section的界面还是item界面
@property (nonatomic, copy) NSString *imageName; // 图片
@property (nonatomic, copy) NSString *titleName; // 标题
@property (nonatomic, copy) NSString *typeName;  // 内容类型
@end

NS_ASSUME_NONNULL_END
