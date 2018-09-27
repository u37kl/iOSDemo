//
//  JFNetTool.h
//  iOSDemo
//
//  Created by ww on 2018/9/25.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFNetTool : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSString *)getIPAddress_v:(BOOL)preferIPv4;
+ (NSDictionary *)getIPAddr;
+ (NSDictionary *)getIPAddresses;
+ (NSString *) getMacAddress;
+ (nonnull NSString *)currentIPAddressOf: (nonnull NSString *)device;
+ (nullable NSString *)IPv4Ntop: (in_addr_t)addr;
+ (in_addr_t)IPv4Pton: (nonnull NSString *)IPAddr;
@end
