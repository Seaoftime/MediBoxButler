//
//  AppDelegate.h
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#define KNotificationActionIdentifileStar @"knotificationActionIdentifileStar"
#define KNotificationActionIdentifileComment @"kNotificationActionIdentifileComment"
#define KNotificationCategoryIdentifile @"KNOtificationCategoryIdentifile"

//
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
    BMKMapManager * _mapManager;
    
}


@property (strong, nonatomic) UIWindow *window;

//闹钟
+(NSString *)CUSTOM_NOTIFICATION_DID_ENTER_BACKGROUND;
+(NSString *)CUSTOM_NOTIFICATION_DID_BECOME_ACTIVE;
+(NSString *)CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_IN_ACTIVE;
+(NSString *)CUSTOM_NOTIFICATION_DID_RECEIVE_LOCAL_NOTIFICATION_STATE_ACTIVE;
+(NSString *)CUSTOM_NOTIFICATION_DID_FINISH_LAUNCHING_WITH_OPTIONS;



@end

