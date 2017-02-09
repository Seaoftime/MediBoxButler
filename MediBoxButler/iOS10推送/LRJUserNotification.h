//
//  LRJUserNotification.h
//  MediBoxButler
//
//  Created by ZhongMeng on 16/10/18.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Macro.h"

typedef NS_ENUM(NSUInteger, AttachmentType) {
    AttachmentTypeImage,
    AttachmentTypeImageGif,
    AttachmentTypeAudio,
    AttachmentTypeMovie
};



@interface LRJUserNotification : NSObject


MInterfaceSharedInstance(sharedNotification)

- (void)registerNotification;

#pragma mark - 添加 本地推送

- (void)addNotificationWithTimeIntervalTrigger;

- (void)addNotificationWithCalendarTrigger;

- (void)addNotificationWithLocationTrigger;




#pragma mark - AppDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;





@end
