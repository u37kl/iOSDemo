//
//  JFSKinManager.h
//  yourenPower
//
//  Created by admin on 2018/5/31.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFSkinModel.h"
@interface JFSKinManager : NSObject
@property (nonatomic, strong) JFSkinModel *model;
+(instancetype)skinManager;
@end
