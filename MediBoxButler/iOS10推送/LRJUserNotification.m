//
//  LRJUserNotification.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/10/18.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJUserNotification.h"


#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "LRJUserNotificationModdel.h"

@interface LRJUserNotification ()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) NSMutableArray *muDrugsNameArray;

@property (nonatomic, strong) NSMutableArray *muDrugsTellArray;

@property (nonatomic, strong) LRJUserNotificationModdel *notificationModel;

@property (nonatomic, strong) NSString *notiTitleStr;


@end



@implementation LRJUserNotification


MImplementeSharedInstance(sharedNotification)


- (instancetype)init
{
    self = [super init];
    if (self) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        
        self.muDrugsNameArray = [NSMutableArray arrayWithObjects:@"白加黑", @"999感冒灵", @"快克", @"阿莫西林", @"感康",  nil];
        
        //self.muDrugsNameArray = [NSMutableArray arrayWithObjects:@"内科药|感冒药", @"感冒药",  nil];
        
        
    }
    return self;
}

- (void)registerNotification
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //允许
            NSLog(@"允许注册通知");
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"%@", settings);
            }];
            //注册
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }else{
            //不允许
            NSLog(@"不允许注册通知");
        }
    }];
}

#pragma mark - 添加 本地推送

- (void)addNotificationWithTimeIntervalTrigger
{
    
    int inter = arc4random() % 5;///1-4
    //int innt = arc4random() % 2;
    
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    //content.title = @"白加黑";
    
    //NSString *titlestr = [self.muDrugsNameArray objectAtIndex:inter];
    content.title = [self.muDrugsNameArray objectAtIndex:inter];
    
    self.notiTitleStr = content.title;
    
    content.subtitle = @"内科药|感冒药";
    //NSString *subtitlestr = [self.muDrugsTellArray objectAtIndex:innt];
    //content.subtitle = subtitlestr;
    
    
    content.body = @"适用于治疗和减轻感冒引起的发热、头痛、周身四肢酸痛、喷嚏、流涕、鼻塞、咳嗽等症状。口服。一次1～2片，一日3次（早、中各1～2白片，夜晚1～2片黑片）。儿童遵医嘱。";
    content.sound = [UNNotificationSound soundNamed:@"ios10notifi.caf"];
    
    /*重点开始*/
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    /*重点结束*/
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TimeInterval" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加时间戳定时推送 : %@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}

- (void)addNotificationWithCalendarTrigger
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    int inter = arc4random() % 5;///1-4
    
    //content.title = @"周期性定时推送";
    
    content.title = [self.muDrugsNameArray objectAtIndex:inter];

    self.notiTitleStr = content.title;
    
    
    content.subtitle = @"内科药|感冒药";
    content.body = @"适用于治疗和减轻感冒引起的发热、头痛、周身四肢酸痛、喷嚏、流涕、鼻塞、咳嗽等症状。口服。一次1～2片，一日3次（早、中各1～2白片，夜晚1～2片黑片）。儿童遵医嘱。";
    content.sound = [UNNotificationSound defaultSound];
    
    /*重点开始*/
    NSDateComponents *components = [[NSDateComponents alloc] init];
    //components.weekday = 4; //周三
    components.weekday = arc4random() % 7;
    
    components.hour = 8; //8点
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    /*重点结束*/
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Calendar" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加周期性定时推送 ：%@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}

- (void)addNotificationWithLocationTrigger
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"指定位置推送";
    content.subtitle = @"subtitle";
    content.body = @"Copyright © 2016年 Hong. All rights reserved.";
    content.sound = [UNNotificationSound defaultSound];
    
    /*重点开始*/
    CLLocationCoordinate2D cen = CLLocationCoordinate2DMake(39.989898,116.333404);
    CLRegion *region = [[CLCircularRegion alloc] initWithCenter:cen radius:100 identifier:@"center"];
    region.notifyOnEntry = NO;
    region.notifyOnExit = YES;
    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];
    /*重点结束*/
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Location" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加指定位置推送 ：%@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}







#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog(@"在前台 willPresentNotification");
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    
    
    
///--------------------------------------------------
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    

    
    self.notificationModel = [[LRJUserNotificationModdel alloc] init];
    
    self.notificationModel.nofi_title = self.notiTitleStr;
    self.notificationModel.nofi_subtitle = @"内科药|感冒药";
    self.notificationModel.nofi_body = @"适用于治疗和减轻感冒引起的发热、头痛、周身四肢酸痛、喷嚏、流涕、鼻塞、咳嗽等症状。口服。一次1～2片，一日3次（早、中各1～2白片，夜晚1～2片黑片）。儿童遵医嘱。";
    
    
    self.notificationModel.nofi_data = dateString;
    
    
    //插入一条数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.notificationModel save];
    });

    
    
    
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    NSLog(@"didReceiveNotificationResponse : %@", response);
    completionHandler();
    
    
///--------------------------------------------------    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    
    
    self.notificationModel = [[LRJUserNotificationModdel alloc] init];
    
    self.notificationModel.nofi_title = self.notiTitleStr;
    self.notificationModel.nofi_subtitle = @"内科药|感冒药";
    self.notificationModel.nofi_body = @"适用于治疗和减轻感冒引起的发热、头痛、周身四肢酸痛、喷嚏、流涕、鼻塞、咳嗽等症状。口服。一次1～2片，一日3次（早、中各1～2白片，夜晚1～2片黑片）。儿童遵医嘱。";
    
    
    self.notificationModel.nofi_data = dateString;
    
    
    //插入一条数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.notificationModel save];
    });
    
    

    
    
    
}

#pragma mark - AppDelegate

- (void)application:(UIApplication *)ap·plication didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"注册通知成功 device token : %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册通知失败");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSLog(@"didReceiveRemoteNotification---application.state=%ld", application.applicationState);
    
}











@end
