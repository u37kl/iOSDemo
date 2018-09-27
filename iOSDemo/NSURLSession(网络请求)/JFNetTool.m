//
//  JFNetTool.m
//  iOSDemo
//
//  Created by ww on 2018/9/25.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "JFNetTool.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#define IOS_CELLULAR @"pdp_ip0"
#define IOS_WIFI @"en0"
#define IP_ADDR_IPv4 @"ipv4"
#define IP_ADDR_IPv6 @"ipv6"

@implementation JFNetTool

+ (NSString *)getMacAddress

{
    
    int mgmtInfoBase[6];
    
    char *msgBuffer = NULL;
    
    size_t length;
    
    unsigned char macAddress[6];
    
    struct if_msghdr *interfaceMsgStruct;
    
    struct sockaddr_dl *socketStruct;
    
    NSString *errorFlag = NULL;
    
    
    
    // Setup the management Information Base (mib)
    
    mgmtInfoBase[0] = CTL_NET; // Request network subsystem
    
    mgmtInfoBase[1] = AF_ROUTE; // Routing table info
    
    mgmtInfoBase[2] = 0;
    
    mgmtInfoBase[3] = AF_LINK; // Request link layer information
    
    mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
    
    
    
    // With all configured interfaces requested, get handle index
    
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        
        errorFlag = @"if_nametoindex failure";
    
    else
        
    {
        
        // Get the size of the data available (store in len)
        
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            
            errorFlag = @"sysctl mgmtInfoBase failure";
        
        else
            
        {
            
            // Alloc memory based on above call
            
            if ((msgBuffer = malloc(length)) == NULL)
                
                errorFlag = @"buffer allocation failure";
            
            else
                
            {
                
                // Get system information, store in buffer
                
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    
                    errorFlag = @"sysctl msgBuffer failure";
                
            }
            
        }
        
    }
    
    
    
    // Befor going any further...
    
    if (errorFlag != NULL)
        
    {
        
        NSLog(@"Error: %@", errorFlag);
        
        return errorFlag;
        
    }
    
    
    
    // Map msgbuffer to interface message structure
    
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    
    
    // Map to link-level socket structure
    
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    
    
    // Copy link layer address data in socket structure to an array
    
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    
    
    // Read from char array into a string object, into traditional Mac address format
    
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  
                                  macAddress[0], macAddress[1], macAddress[2],
                                  
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    NSLog(@"Mac Address: %@", macAddressString);
    
    
    
    // Release the buffer memory
    
    free(msgBuffer);
    
    
    
    return macAddressString;
}

//获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
//获取所有相关IP信息
+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}


+ (NSString *) macaddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}
@end
