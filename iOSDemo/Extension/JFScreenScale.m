//
//  JFScreenScale.m
//  yourenPower
//
//  Created by ww on 2018/5/31.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import "JFScreenScale.h"
#import "sys/utsname.h"

static JFScreenScale *_screenScale;
@interface JFScreenScale()
@property (nonatomic, assign) double scale;
@end
@implementation JFScreenScale

+(double)scale
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _screenScale = [[JFScreenScale alloc] init];
    });
    return _screenScale.scale;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self getPhoneScale];
    }
    return self;
}

-(void)getPhoneScale
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone5,1"] || [deviceString isEqualToString:@"iPhone5,2"] || [deviceString isEqualToString:@"iPhone5,3"] || [deviceString isEqualToString:@"iPhone5,4"] || [deviceString isEqualToString:@"iPhone6,1"]||[deviceString isEqualToString:@"iPhone6,2"] || [deviceString isEqualToString:@"iPhone8,4"]){
        
        self.scale = 0.85;
    }else if([deviceString isEqualToString:@"iPhone7,2"] || [deviceString isEqualToString:@"iPhone8,1"] || [deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"] || [deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])    {
        if(CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)){
            self.scale = 1;
        }else{
            self.scale = 0.85;
        }
            // iphone8
    }else if ([deviceString isEqualToString:@"iPhone7,1"] || [deviceString isEqualToString:@"iPhone8,2"] || [deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"] || [deviceString isEqualToString:@"iPhone10,2"]||[deviceString isEqualToString:@"iPhone10,5"]){
        if (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) {
            self.scale = 1.104;
        }else{
            self.scale = 1;
        }
         // iphone8P
    }else if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"]){
        self.scale = 1; // iphonex
    }else if ([deviceString isEqualToString:@"iPad2,5"]||[deviceString isEqualToString:@"iPad2,6"]||[deviceString isEqualToString:@"iPad2,7"]|| [deviceString isEqualToString:@"iPad4,7"] || [deviceString isEqualToString:@"iPad4,6"] || [deviceString isEqualToString:@"iPad4,8"] || [deviceString isEqualToString:@"iPad4,9"] || [deviceString isEqualToString:@"iPad5,1"] || [deviceString isEqualToString:@"iPad5,2"]){
        self.scale = 1; // ipad mini
    }else if([deviceString isEqualToString:@"i386"] || [deviceString isEqualToString:@"x86_64"]){
        self.scale = 1.104; // 模拟器
    }
    
}
+(double)getFloatFromScale:(CGFloat)num
{
    return [self scale] * num;
}

+(double)getFloatFromScaleFloor:(CGFloat)num
{
    double temp = [self scale] * num;
    
    return floor(temp);
}

+(double)getFloatFromScaleCeil:(CGFloat)num
{
    double temp = [self scale] * num;
    return ceil(temp);
}

@end
