//
//  ZPPushNotificationViewController.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/8/14.
//  Copyright © 2018年 ww. All rights reserved.
//
#import "ZPPushNotificationHeader.h"
#import "ZPPushNotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import "Masonry.h"
@interface ZPPushNotificationViewController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation ZPPushNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.dataList[section];
    return [dict[@"list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dict = self.dataList[indexPath.section];
    NSString *title = dict[@"list"][indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = self.dataList[section];
    return dict[@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            [self pushLocalNotication8];
        }else if(indexPath.row == 1){
            
        }else if(indexPath.row == 2){
            
        }
    }else if(indexPath.section == 2){
        
    }else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            [self pushLocalNotication10];
        }else if(indexPath.row == 1){
            [self pushLocalNotication10_Vedio];
        }else if(indexPath.row == 2){
            [self pushLocalNotication10_Calendar_Image];
        }else if(indexPath.row == 3){
            [self pushLocalNotication10_ChangeNotification];
        }else if(indexPath.row == 4){
            [self pushLocalNotication10_CustomUI];
        }
        
    }
}


-(void)pushLocalNotication8{
    
    // 每天的17:30发送推送
    UILocalNotification *notication = [[UILocalNotification alloc] init];
    notication.alertBody = @"iOS8本地推送内容";
    notication.alertTitle = @"iOS8本地推送标题";
    notication.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    notication.alertAction = @"打开app";
    notication.repeatInterval = kCFCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *component = [[NSDateComponents alloc] init];
    component.hour = 17;
    component.minute = 30;
    NSDate *date = [calendar dateFromComponents:component];
    notication.fireDate = date;
    notication.timeZone = [NSTimeZone defaultTimeZone];
    notication.category = kPushNotificationCategoryDefault;
    [[UIApplication sharedApplication] scheduleLocalNotification:notication];
}

-(void)pushLocalNotication10
{
    if (@available(iOS 10, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10本地推送";
        content.body = @"iOS10本地推送内容为我也不知道你是谁";
         NSInteger badgeNum = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        content.badge = [NSNumber numberWithInteger:badgeNum];
        content.sound = [UNNotificationSound defaultSound];
        content.subtitle = @"这个为副标题";
        NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"icon1" withExtension:@"jpg"];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        // 附件 可以是音频、图片、视频 这里是一张图片
        content.attachments = @[attachment];
        content.categoryIdentifier = kPushNotificationCategoryDefault;
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:8 repeats:NO];
        // 设置本地推送ID，如果相同的话，会被系统视为一条推送，小红点也不会增加。
        NSString *requestID = [NSString stringWithFormat:@"UNTimeIntervalNotificationTrigger%li", badgeNum];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestID content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"本地推送错误--%@", error);
            }else{
                NSLog(@"本地推送成功 --- iOS10");
            }
        }];
    }
}

-(void)pushLocalNotication10_Vedio
{
    if (@available(iOS 10, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10本地推送";
        content.body = @"iOS10本地推送内容为我也不知道你是谁";
        NSInteger badgeNum = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        content.badge = [NSNumber numberWithInteger:badgeNum];
        content.sound = [UNNotificationSound defaultSound];
        content.subtitle = @"这个为副标题";
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"Resource"ofType:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
        NSURL *imageUrl = [resourceBundle URLForResource:@"minion_10" withExtension:@"mp4"];
        
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        // 附件 可以是音频、图片、视频 这里是一张图片
        content.attachments = @[attachment];
        content.categoryIdentifier = kPushNotificationCategoryDefault;
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:8 repeats:NO];
        // 设置本地推送ID，如果相同的话，会被系统视为一条推送，小红点也不会增加。
        NSString *requestID = [NSString stringWithFormat:@"UNTimeIntervalNotificationTrigger%li", badgeNum];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestID content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"本地推送错误--%@", error);
            }else{
                NSLog(@"本地推送成功 --- iOS10");
            }
        }];
    }
}

-(void)pushLocalNotication10_Calendar_Image
{
    if (@available(iOS 10, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10本地推送";
        content.body = @"iOS10本地推送内容为我也不知道你是谁";
        NSInteger badgeNum = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        content.badge = [NSNumber numberWithInteger:badgeNum];
        content.sound = [UNNotificationSound defaultSound];
        content.subtitle = @"这个为副标题";
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"Resource"ofType:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
        NSURL *imageUrl = [resourceBundle URLForResource:@"minion_10" withExtension:@"mp4"];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        // 附件 可以是音频、图片、视频 这里是一张图片
        content.attachments = @[attachment];
        content.categoryIdentifier = kPushNotificationCategoryDefault;
        // 每天的16:34进行本地推送
        NSDateComponents *component = [[NSDateComponents alloc] init];
        component.hour = 16;
        component.minute = 34;
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:component repeats:NO];
        // 设置本地推送ID，如果相同的话，会被系统视为一条推送，小红点也不会增加。
        NSString *requestID = [NSString stringWithFormat:@"UNTimeIntervalNotificationTrigger%li", badgeNum];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestID content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"本地推送错误--%@", error);
            }else{
                NSLog(@"本地推送成功 --- iOS10");
            }
        }];
    }
}

-(void)pushLocalNotication10_ChangeNotification
{
    if (@available(iOS 10, *)) {
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10本地推送--修改";
        content.body = @"iOS10本地推送内容为我说作者";
        content.sound = [UNNotificationSound defaultSound];
        content.subtitle = @"这个为副标题";
        NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"icon1" withExtension:@"jpg"];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        // 附件 可以是音频、图片、视频 这里是一张图片
        content.attachments = @[attachment];
        content.categoryIdentifier = kPushNotificationCategoryDefault;
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:8 repeats:NO];
        // 设置本地推送ID，如果相同的话，会被系统视为一条推送，小红点也不会增加。
        NSString *requestID = [NSString stringWithFormat:@"UNTimeIntervalNotificationTrigger%li", [UIApplication sharedApplication].applicationIconBadgeNumber];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestID content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"本地推送错误--%@", error);
            }else{
                NSLog(@"本地推送成功 --- iOS10");
            }
        }];
    }
}

-(void)pushLocalNotication10_RemoveSendedNotification
{
    if (@available(iOS 10, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10本地推送";
        content.body = @"iOS10本地推送内容为我也不知道你是谁";
        NSInteger badgeNum = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        content.badge = [NSNumber numberWithInteger:badgeNum];
        content.sound = [UNNotificationSound defaultSound];
        content.subtitle = @"这个为副标题";
        NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"icon1" withExtension:@"jpg"];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        // 附件 可以是音频、图片、视频 这里是一张图片
        content.attachments = @[attachment];
        content.categoryIdentifier = kPushNotificationCategoryDefault;
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:8 repeats:NO];
        // 设置本地推送ID，如果相同的话，会被系统视为一条推送，小红点也不会增加。
        NSString *requestID = [NSString stringWithFormat:@"UNTimeIntervalNotificationTrigger%li", badgeNum];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestID content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"本地推送错误--%@", error);
            }else{
                NSLog(@"本地推送成功 --- iOS10");
            }
        }];
    }
}


-(void)pushLocalNotication10_CustomUI
{
    if (@available(iOS 10, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10本地推送";
        content.body = @"iOS10本地推送内容为我也不知道你是谁";
        content.categoryIdentifier = @"myNotificationCategory";
        NSInteger badgeNum = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        content.badge = [NSNumber numberWithInteger:badgeNum];
        content.sound = [UNNotificationSound defaultSound];
        content.subtitle = @"这个为副标题";
        NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"icon1" withExtension:@"jpg"];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
        // 附件 可以是音频、图片、视频 这里是一张图片
        content.attachments = @[attachment];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:8 repeats:NO];
        // 设置本地推送ID，如果相同的话，会被系统视为一条推送，小红点也不会增加。
        NSString *requestID = [NSString stringWithFormat:@"UNTimeIntervalNotificationTrigger%li", badgeNum+1];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestID content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"本地推送错误--%@", error);
            }else{
                NSLog(@"本地推送成功 --- iOS10");
            }
        }];
    }
}

-(NSArray *)dataList
{
    if (!_dataList) {
        _dataList = @[@{@"title":@"iOS7本地推送", @"list":@[@"本地推送1",@"本地推送2",@"本地推送3"]},
                      @{@"title":@"iOS8本地推送", @"list":@[@"本地推送1",@"本地推送2",@"本地推送3"]},
                      @{@"title":@"iOS9本地推送", @"list":@[@"本地推送1",@"本地推送2",@"本地推送3"]},
                      @{@"title":@"iOS10本地推送", @"list":@[@"本地推送1-图片",@"本地推送2-视频",@"本地推送3--当前时间后一定时间", @"本地推送1-修改通知", @"本地推送1-自定义UI"]}];
    }
    return _dataList;
}



@end
