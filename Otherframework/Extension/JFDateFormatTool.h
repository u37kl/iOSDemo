//
//  JFDataFormatTool.h
//  yourenPower
//
//  Created by admin on 2018/6/1.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFDateFormatTool : NSDateFormatter
+ (NSString *) getFormatTime:(NSString *)str;
+ (NSString *) getFormatData:(NSString *)str;
@end
