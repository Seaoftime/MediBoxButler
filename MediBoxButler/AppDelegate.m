//
//  AppDelegate.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "AppDelegate.h"


#import "LRJWelcomeViewController.h"
#import "LRJTabBarController.h"
#import <AVFoundation/AVFoundation.h>
#import "LRJAlarmClockViewController.h"

////
#import "LRJUserNotification.h"

////闹钟
#import "UserDefalutManager.h"
#import "AlarmManager.h"
#import "Router.h"
#import "memorandumModel.h"



#define BaiduMapKey @"nObNY7PA1xuQMgMqlE59nL9EO1qcnb73"



////闹钟
static NSString *DID_ENTER_BACKGROUND = @"CustomNotificationApplicationDidEnterBackground";
static NSString *DID_BECOME_ACTIVE = @"CustomNotificationApplicationDidBecomeActive";
static NSString *DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE = @"CustomNotificationDidReceiveLocalNotificationInActive";
static NSString *DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE = @"CustomNotificationDidReceiveLocalNotificationStateActive";
static NSString *DID_FINISH_LAUNCHING_WITH_OPTIONS = @"CustomNotificationDidFinishLaunchingWithOptions";





@interface AppDelegate ()


@property (nonatomic, strong) UIMutableUserNotificationCategory * categorys;

@end

@implementation AppDelegate

+(NSString *)CUSTOM_NOTIFICATION_DID_ENTER_BACKGROUND{
    return DID_ENTER_BACKGROUND;
}

+(NSString *)CUSTOM_NOTIFICATION_DID_BECOME_ACTIVE{
    return DID_BECOME_ACTIVE;
}

+(NSString *)CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE{
    return DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE;
}

+(NSString *)CUSTOM_NOTIFICATION_DID_FINISH_LAUNCHING_WITH_OPTIONS{
    return DID_FINISH_LAUNCHING_WITH_OPTIONS;
}

+(NSString *)CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE{
    return DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE;
}






- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    //推送通知 适配 ios8

    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        
        // iOS8.0
        UIUserNotificationType types =
        UIUserNotificationTypeBadge|
        UIUserNotificationTypeSound|
        UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [application registerUserNotificationSettings:mySettings];
    }
    
    [[AlarmManager sharedManager] setBgm];

    
    
    
    
    
    
    
    /////iOS10注册通知
    [[LRJUserNotification sharedNotification] registerNotification];
    
    
    
    
    
    
    
    ///注册百度地图
    //BaiDuMap 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BaiduMapKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LRJTabBarController *tbc = [[LRJTabBarController alloc] init];
   
    self.window.rootViewController = tbc;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].delegate = self;
    
    return YES;
}




////////////////////////////////ios10 通知
#pragma mark - Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[LRJUserNotification sharedNotification] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[LRJUserNotification sharedNotification] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [[LRJUserNotification sharedNotification] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


////////////////////////////////






- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[NSNotificationCenter defaultCenter]
     postNotification:[NSNotification notificationWithName:DID_ENTER_BACKGROUND
                                                    object:self]];
}




#pragma mark 进入前台后设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
    
    
    ///取消闹铃
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeeClocKk" object:nil];
    
    
    NSLog(@"闹钟___进入前台");
}




#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"33333");
    
}

#pragma mark --- 调用过用户注册通知方法后执行
//如果加通知  跳出界面就会添加通知
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"111111");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[NSNotificationCenter defaultCenter]
     postNotification:[NSNotification notificationWithName:DID_BECOME_ACTIVE
                                                    object:self]];
    
    
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    // 图标上的数字设置为0
    NSLog(@"noti: %@",notification.userInfo);
    application.applicationIconBadgeNumber = 0;
    
    
    
    
    NSArray *arr=[notification.userInfo allKeys];
    
    if (![arr containsObject:@"isAlarm"])
    {
        NSMutableArray *array =[memorandumModel getdataArray];
        for (memorandumModel *model in array) {
            
            if ([model.modelId isEqualToString:notification.userInfo[@"modelId"]])
            {
                
                [[[UIAlertView alloc] initWithTitle:model.title message:model.subTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                
                [array removeObject:model];
                
                break;
            }
        }
        
        return;
    }
    
    if(application.applicationState == UIApplicationStateActive) {
        
        [[NSNotificationCenter defaultCenter]
         postNotification:[NSNotification notificationWithName:DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE
                                                        object:self]];
        
    }
    
    if(application.applicationState == UIApplicationStateInactive) {
        [[NSNotificationCenter defaultCenter]
         postNotification:[NSNotification notificationWithName:DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE
                                                        object:self]];
    }
    
}








- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
