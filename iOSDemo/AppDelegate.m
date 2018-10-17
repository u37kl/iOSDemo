//
//  AppDelegate.m
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "AppDelegate.h"

#import "ZPTabBarViewController.h"

#import "ViewController.h"
#import "ZPRomateNotificationManager.h"
#import <BuglyHotfix/Bugly.h>
#import <BuglyHotfix/BuglyMender.h>
#import "JPEngine.h"
#import "ZPPushNotificationHeader.h"
#import "ZPCALayerViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    ZPTabBarViewController *vc = [[ZPTabBarViewController alloc] init];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
     self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    [self load3DTouch];
    
    [self setSystemData];
    
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    AppDelegate *delegate = (AppDelegate *)app.delegate;
    UINavigationController *vc = delegate.window.rootViewController;
    ZPCALayerViewController *vc1 = [[ZPCALayerViewController alloc] init];
    [vc pushViewController:vc1 animated:YES];
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

-(void)setSystemData
{
   [ZPRomateNotificationManager shareManager];
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{

}



-(void)load3DTouch
{
    if(@available(iOS 9.0, *)){
        UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"item1" localizedTitle:@"我的消息" localizedSubtitle:nil icon:nil userInfo:nil];
        
        UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
        UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"item2" localizedTitle:@"发布动态" localizedSubtitle:nil icon:icon2 userInfo:nil];
        
        UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3d_icon"];
        UIApplicationShortcutItem *item3= [[UIApplicationShortcutItem alloc] initWithType:@"item3" localizedTitle:@"搜索寻味师" localizedSubtitle:nil icon:icon3 userInfo:nil];
        [[UIApplication sharedApplication] setShortcutItems:@[item3,item2,item1]];
    }

    
}

#pragma mark - 获取deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[ZPRomateNotificationManager shareManager] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[ZPRomateNotificationManager shareManager] didFailToRegisterForRemoteNotificationsWithError:error];
}

#pragma mark - iOS10以下接收远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[ZPRomateNotificationManager shareManager] didReceiveRemoteNotification:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSDictionary *dict = userInfo[@"aps"][kBackgroundFetch];
    [[ZPRomateNotificationManager shareManager] didReceiveRemoteNotification:dict fetchCompletionHandler:completionHandler];
}
#pragma mark - iOS10以下接收本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[ZPRomateNotificationManager shareManager] didReceiveLocalNotification:notification];
}

#pragma mark - iOS8推送消息点击处理方法
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{

    completionHandler();
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    completionHandler();
}

#pragma mark - iOS9推送消息点击处理方法
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler{
    
    completionHandler();
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler{
    
    completionHandler();
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)configBugly {
    //初始化 Bugly 异常上报
    BuglyConfig *config = [[BuglyConfig alloc] init];
    
    config.delegate = self;
    config.debugMode = YES;
    config.reportLogLevel = BuglyLogLevelInfo;
    [Bugly startWithAppId:@"ebbb5873b9"
     
#ifdef MyTestRelease
        developmentDevice:YES
#endif
                   config:config];
    
    //捕获 JSPatch 异常并上报
    [JPEngine handleException:^(NSString *msg) {
        NSException *jspatchException = [NSException exceptionWithName:@"Hotfix Exception" reason:msg userInfo:nil];
        [Bugly reportException:jspatchException];
    }];
    
    NSDictionary *dict = [BuglyMender sharedMender].currentPatchInfo;
    NSLog(@"%@ --- %@",dict[@"patchVersion"], dict[@"patchDesc"]);
    //检测补丁策略
    [[BuglyMender sharedMender] checkRemoteConfigWithEventHandler:^(BuglyHotfixEvent event, NSDictionary *patchInfo) {
        //有新补丁或本地补丁状态正常
        if (event == BuglyHotfixEventPatchValid || event == BuglyHotfixEventNewPatch) {
            //获取本地补丁路径
            NSString *patchDirectory = [[BuglyMender sharedMender] patchDirectory];
            if (patchDirectory) {
                //指定执行的 js 脚本文件名
                NSString *patchFileName = @"main.js";
                NSString *patchFile = [patchDirectory stringByAppendingPathComponent:patchFileName];
                //执行补丁加载并上报激活状态
                if ([[NSFileManager defaultManager] fileExistsAtPath:patchFile] &&
                    [JPEngine evaluateScriptWithPath:patchFile] != nil) {
                    BLYLogInfo(@"evaluateScript success");
                    [[BuglyMender sharedMender] reportPatchStatus:BuglyHotfixPatchStatusActiveSucess];
                }else {
                    BLYLogInfo(@"evaluateScript failed");
                    [[BuglyMender sharedMender] reportPatchStatus:BuglyHotfixPatchStatusActiveFail];
                }
            }
        }
    }];
}

@end
