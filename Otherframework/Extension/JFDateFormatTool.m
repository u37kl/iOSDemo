//
//  JFDataFormatTool.m
//  yourenPower
//
//  Created by admin on 2018/6/1.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import "JFDateFormatTool.h"
static JFDateFormatTool *_tool = nil;
@implementation JFDateFormatTool

+(instancetype)dateTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[JFDateFormatTool alloc] init];
        
        
    });
    return _tool;
}


+ (NSString *) getFormatData:(NSString *)str
{
    if (str == nil && str.length <= 0) {
        return nil;
    }

    //把字符串转为NSdate
    JFDateFormatTool *tool = [JFDateFormatTool dateTool];
    if ([str containsString:@":"]) {
        [tool setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *strdate = [tool dateFromString:str];
        [tool setDateFormat:@"yyyy-MM-dd"];
        return [tool stringFromDate:strdate];
    }else{
        return str;
    }
}

+ (NSString *) getFormatTime:(NSString *)str
{
    if (str == nil && str.length <= 0) {
        return nil;
    }
    JFDateFormatTool *tool = [JFDateFormatTool dateTool];
    [tool getNowDateFromatAnStr:str];
    [tool getNowDateFromatAnDate:[NSDate date]];
//    [tool setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"]];
//    NSTimeZone *time = [NSTimeZone localTimeZone];
//    [tool setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
////    tool.timeZone = time;
//    NSDate *date1 = [tool dateFromString:str];
//
//    tool.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//    NSDate *date2 = [tool dateFromString:str];
//
//    NSInteger s = time.secondsFromGMT;
//
//    NSDictionary *dict = [NSTimeZone abbreviationDictionary];
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"%@ --- %@", key, obj);
//    }];
    return nil;
}
// dateFromString，参考当前时区，计算出0时区的时间，即本初子午线时间

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

- (NSDate *)getNowDateFromatAnStr:(NSString *)anyDateStr
{
    [self setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *anyDate = [self dateFromString:anyDateStr];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//或GMT
    //设置源日期时区
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

+(NSString *)getCurrentData
{
    NSDate *date = [NSDate date];
    JFDateFormatTool *tool = [JFDateFormatTool dateTool];
    [tool setDateFormat:@"yyyy_MM_dd_HH_mm_ss"];
    return [tool stringFromDate:date];
}
@end
