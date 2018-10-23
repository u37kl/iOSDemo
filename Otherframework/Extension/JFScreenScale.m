//
//  JFScreenScale.m
//  yourenPower
//
//  Created by ww on 2018/5/31.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import "JFScreenScale.h"
#import "sys/utsname.h"

typedef NS_ENUM(NSUInteger, DeviceHeightType){
    DeviceHeightTypeNone,
    DeviceHeightTypeIPhone5S,
    DeviceHeightTypeIPhone6,
    DeviceHeightTypeIPHone6P,
    DeviceHeightTypeIPhoneX
};

static JFScreenScale *_screenScale;
@interface JFScreenScale()
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double widthScale;
@property (nonatomic, assign) double heightScale;
@property (nonatomic, assign) DeviceHeightType deviceHeightType;
@end
@implementation JFScreenScale

+(JFScreenScale *)scale
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _screenScale = [[JFScreenScale alloc] init];
    });
    return _screenScale;
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
        self.heightScale = 1;
        self.widthScale = 1;
        self.deviceHeightType = DeviceHeightTypeIPhone5S;
    }else if([deviceString isEqualToString:@"iPhone7,2"] || [deviceString isEqualToString:@"iPhone8,1"] || [deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"] || [deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])    {
        if(CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)){
            self.scale = 1;
        }else{
            self.scale = 0.85;
        }
        self.heightScale = 1;
        self.widthScale = 1;
        self.deviceHeightType = DeviceHeightTypeIPhone6;
        // iphone8
    }else if ([deviceString isEqualToString:@"iPhone7,1"] || [deviceString isEqualToString:@"iPhone8,2"] || [deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"] || [deviceString isEqualToString:@"iPhone10,2"]||[deviceString isEqualToString:@"iPhone10,5"]){
        if (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) {
            self.scale = 1.104;
        }else{
            self.scale = 1;
        }
        self.heightScale = 1;
        self.widthScale = 1;
        self.deviceHeightType = DeviceHeightTypeIPHone6P;
        // iphone8P
    }else if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"]){
        self.scale = 1; // iphonex
        self.heightScale = 1;
        self.widthScale = 1;
        self.deviceHeightType = DeviceHeightTypeIPhoneX;
        
    }else if ([deviceString isEqualToString:@"iPad2,5"]||[deviceString isEqualToString:@"iPad2,6"]||[deviceString isEqualToString:@"iPad2,7"]|| [deviceString isEqualToString:@"iPad4,7"] || [deviceString isEqualToString:@"iPad4,6"] || [deviceString isEqualToString:@"iPad4,8"] || [deviceString isEqualToString:@"iPad4,9"] || [deviceString isEqualToString:@"iPad5,1"] || [deviceString isEqualToString:@"iPad5,2"]){
        self.scale = 1; // ipad mini
        self.heightScale = 1.535;
        self.widthScale = 2.048;
    }else if ([deviceString isEqualToString:@"iPad6,7"]||[deviceString isEqualToString:@"iPad6,8"]){
        self.scale = 1.334; // ipad pro 12.9
        self.heightScale = 1.535;
        self.widthScale = 2.048;
    }else if ([deviceString isEqualToString:@"iPad7,3"]||[deviceString isEqualToString:@"iPad7,4"]){
        self.scale = 1.085; // ipad pro  10.5
        self.heightScale = 1.535;
        self.widthScale = 2.048;
    }else if([deviceString isEqualToString:@"i386"] || [deviceString isEqualToString:@"x86_64"]){
        self.scale = 1; // 模拟器
        self.heightScale = 1;
        self.widthScale = 1;
    }
    
}

+(CGFloat)getBottomSafeHeight
{
    if ([JFScreenScale scale].deviceHeightType == DeviceHeightTypeIPhoneX) {
        return 22;
    }else{
        return 10;
    }
}

+(CGFloat)getTopSafeHeight
{
    if ([JFScreenScale scale].deviceHeightType == DeviceHeightTypeIPhoneX) {
        return 88;
    }else{
        return 64;
    }
}

+(CGSize)getRootViewSafeBounds
{
    if ([JFScreenScale scale].deviceHeightType == DeviceHeightTypeIPhoneX) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - [JFScreenScale getTopSafeHeight] - [JFScreenScale getBottomSafeHeight]);
    }else{
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - [JFScreenScale getTopSafeHeight]);
    }
}

+(BOOL)isIphoneXAndOver
{
    if ([JFScreenScale scale].deviceHeightType == DeviceHeightTypeIPhoneX) {
        return YES;
    }else{
        return NO;
    }
}

+(double)getFloatFromScale:(CGFloat)num
{
    return [self scale].scale * num;
}

+(double)getFloatFromScaleFloor:(CGFloat)num
{
    double temp = [self scale].scale * num;
    
    return floor(temp);
}

+(double)getFloatFromScaleCeil:(CGFloat)num
{
    double temp = [self scale].scale * num;
    return ceil(temp);
}

+(double)getWidthFromScale:(CGFloat)num
{
    JFScreenScale *scale = [self scale];
    return num * scale.scale * scale.widthScale;
}
+(double)getHeightFromScale:(CGFloat)num
{
    JFScreenScale *scale = [self scale];
    return num * scale.scale * scale.heightScale;
}

+(CGFloat)getDeviceHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}
+(CGFloat)getDeviceWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

@end
