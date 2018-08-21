//
//  NotificationViewController.m
//  MyNotificationContentExtension
//
//  Created by ww on 2018/8/20.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "ZPPushNotificationHeader.h"
@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 125);
    self.headerIconView.contentMode = UIViewContentModeScaleToFill;
}

- (void)didReceiveNotification:(UNNotification *)notification  API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10, *)) {
        self.label.text = notification.request.content.title;
        if (notification.request.content.attachments.count > 0) {
            // 获取多媒体附件中的url
            NSURL *url = notification.request.content.attachments.firstObject.URL;
            // 获取当前URL对应资源的访问权限，由于不同target的沙盒路径不同，因此需要访问NotificationServer这个target的沙盒的访问权限
            if([url startAccessingSecurityScopedResource]){
                // 不能使用imageWithContentsOfFile:方法直接取出图片使用，后果是显示不完整。
                // self.headerIconView.image = [UIImage imageWithContentsOfFile:url.path];
                // 从中取出图片数据，并赋值给图片控件
                NSData * data = [NSData dataWithContentsOfFile:url.path];
                self.headerIconView.image = [UIImage imageWithData:data];
                [url stopAccessingSecurityScopedResource];
            }
            
        }else{
            // 如何获取不到显示默认图片
            self.headerIconView.image = [UIImage imageNamed:@"icon1.jpg"];
        }
        
        self.textView.text = notification.request.content.body;
    }
}

@end



