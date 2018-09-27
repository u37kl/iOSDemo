//
//  ZPRomateNotificationViewController.h
//  iOSDemoiPhone
//
//  Created by ww on 2018/8/2.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZPRomationNotificationProtocol <NSObject>
-(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
-(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
// iOS10以下的远程推送调用
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;
// iOS静默推送调用
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

@end
@interface ZPRomateNotificationManager : NSObject <ZPRomationNotificationProtocol>
+(instancetype)shareManager;
@end
