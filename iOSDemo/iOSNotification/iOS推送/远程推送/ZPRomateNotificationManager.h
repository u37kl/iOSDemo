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
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

@end
@interface ZPRomateNotificationManager : NSObject <ZPRomationNotificationProtocol>
+(instancetype)shareManager;
@end
