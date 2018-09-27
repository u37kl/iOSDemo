//
//  ZPRomateNotificationViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/8/2.
//  Copyright © 2018年 ww. All rights reserved.
//

/*
  发送推送，并添加推送页面按钮
 {
 "aps" : {
 "alert" : "Your message here.",
 "badge" : 9,
 "sound" : "default",
 "category" : "zpsss"
 },
 
 "acme1" : "bar",
 "acme2" : 42
 }
 
 */
#import "ZPPushNotificationHeader.h"
#import "ZPRomateNotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
static ZPRomateNotificationManager *_manager = nil;
@interface ZPRomateNotificationManager ()<UNUserNotificationCenterDelegate>

@end

@implementation ZPRomateNotificationManager

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ZPRomateNotificationManager alloc] init];
    });
    return _manager;
}

#pragma mark - 注册通知
- (instancetype)init
{
    
    if (self = [super init]) {
        double version = [[UIDevice currentDevice].systemVersion doubleValue];
        if(@available(iOS 10, *)){
            // 获取通知中心
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            // 设置通知中心代理
            center.delegate = self;
            // 请求用户授权
            UNAuthorizationOptions option = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"建议您开启通知功能，以便及时获取相关信息" preferredStyle:UIAlertControllerStyleAlert];
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [delegate.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
                    
                    
                }else if(settings.authorizationStatus == UNAuthorizationStatusNotDetermined || settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                    [center requestAuthorizationWithOptions:option completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        if (!error) {
                            // 如果成功，创建通知输入行为。
                            UNTextInputNotificationAction *action1 = [UNTextInputNotificationAction actionWithIdentifier:@"textApp" title:@"编辑" options:UNNotificationActionOptionForeground textInputButtonTitle:@"完成" textInputPlaceholder:@"请输入数据"];
                            // 创建通知让App进入前台的行为
                            UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"enterApp" title:@"进入应用" options:UNNotificationActionOptionForeground];
                            // 创建通知让App继续呆在后台的行为。
                            UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"destructive" title:@"忽略" options:UNNotificationActionOptionDestructive];
                            // 使用分类将通知封装在一起。通过identifier表示分类。
                            UNNotificationCategory *category1 = [UNNotificationCategory categoryWithIdentifier:kPushNotificationCategoryDefault actions:@[action1, action2, action3] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
                            
                            UNNotificationAction *likeAction = [UNNotificationAction actionWithIdentifier:@"action-like" title:@"赞" options:UNNotificationActionOptionAuthenticationRequired];
                            UNNotificationAction *collectAction = [UNNotificationAction actionWithIdentifier:@"action-collect" title:@"收藏" options:UNNotificationActionOptionAuthenticationRequired];
                            UNTextInputNotificationAction *commentAction = [UNTextInputNotificationAction actionWithIdentifier:@"action-comment" title:@"评论" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"发送" textInputPlaceholder:@"输入你的评论"];
                            
                            UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"cheer" actions:@[likeAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
                            
                            // 将分类添加到通知中心
                            [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category, nil]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[UIApplication sharedApplication] registerForRemoteNotifications];
                            });
                        }
                    }];
                }
            }];

            // 注册远程通知
        }else if (version >= 8.0) {
            // iOS8创建分类
            UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
            category.identifier = kPushNotificationCategoryDefault;
            // 创建通知行为
            UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
            action.title = @"请立即查看";
            action.activationMode = UIUserNotificationActivationModeForeground;
            action.identifier = @"open";
            action.behavior = UIUserNotificationActionBehaviorDefault;
            
            UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
            action1.title = @"后台编写";
            action1.activationMode = UIUserNotificationActivationModeBackground;
            action1.identifier = @"back";
            action1.behavior = UIUserNotificationActionBehaviorTextInput;
            // 将行为封装到分类中
            [category setActions:@[action, action1] forContext:UIUserNotificationActionContextDefault];
            // 统一请求用户推送本地、远程通知的授权
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:[NSSet setWithObject:category]];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }else if(version < 8.0){
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    return self;
}

#pragma mark - 获取DeviceToken
-(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *string = [deviceToken.description stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"device --- %@", string);
}

-(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"getDeviceFail == %@", error);
}






- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"LocalNotification - %@",dict);
}


- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"RemoteNotification - %@",userInfo);
}


#pragma mark - 静默推送
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"%@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - iOS10
// 当APP在前台时，接收到推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSLog(@"App在前台");
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

// 当APP在后台时，接收到推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {

    
    NSString *identify = response.notification.request.content.categoryIdentifier;
    if ([identify isEqualToString:@"zpsss"]) {
        if ([response.actionIdentifier isEqualToString:@"enterApp"])
        {

            NSURL *url =  response.notification.request.content.attachments[0].URL;
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            // 开启缓存，提高播放音乐的流畅性。
            [player prepareToPlay];
            [player play];
            NSLog(@"%@", response.notification.request.content.title);
            NSLog(@"enterApp");
        }else if([response.actionIdentifier isEqualToString:@"destructive"]){
            NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
            if (badge > 1) {
                [UIApplication sharedApplication].applicationIconBadgeNumber = badge - 1;
            }else{
                [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
            }
            
        }else if ([response.actionIdentifier isEqualToString:@"textApp"]){
            
            if (@available(iOS 10.0, *)) {
                UNTextInputNotificationResponse *responseText = (UNTextInputNotificationResponse *)response;
                NSLog(@"%@",responseText.userText);

                NSString *str = [NSString stringWithFormat:@"%@, %@", responseText.userText, responseText.notification.request.content.body];
                NSLog(@"%@",str);
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    completionHandler();
}


@end
