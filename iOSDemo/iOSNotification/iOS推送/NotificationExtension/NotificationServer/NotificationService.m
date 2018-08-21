//
//  NotificationService.m
//  NotificationServer
//
//  Created by ww on 2018/8/17.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "NotificationService.h"
#import "ZPPushNotificationHeader.h"
@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = self.bestAttemptContent.title;
    // 取出推送过来的图片地址
    NSString *urlString = request.content.userInfo[@"aps"][@"imageAbsoluteString"];
    NSURL *url = [NSURL URLWithString:urlString];
    // 进行网络请求获取图片
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"download attachment image error : %@", error);
        }else{
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject
                              stringByAppendingPathComponent:DOCUMENTS_FOLDER_IMAGE];
            NSFileManager *manager = [NSFileManager defaultManager];
            // 判断路径是否存在
            BOOL isDir = FALSE;
            BOOL isDirExist = [manager fileExistsAtPath:path isDirectory:&isDir];
            if (!(isDir && isDirExist)) {
                [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            }
            NSString *fileName = [NSString stringWithFormat:@"%lld.jpg", (long long)[[NSDate date] timeIntervalSince1970] * 1000];
            path = [path stringByAppendingPathComponent:fileName];//
            // 将图片保存到NotificationServer的沙盒路径中
            BOOL isSuccess = [data writeToFile:path atomically:YES];
            NSError *err = nil;
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"remote-atta1" URL:[NSURL fileURLWithPath:path] options:nil error:&err];
            // 将多媒体附件添加到通知中。
            if (attachment) {
                self.bestAttemptContent.attachments = @[attachment];
            }
        }
        
        self.contentHandler(self.bestAttemptContent);
    }];
    
    [task resume];
    
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
