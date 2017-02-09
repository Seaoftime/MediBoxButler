//
//  LRJAlarmClockViewController.h
//  MediBoxButler
//
//  Created by ZhangRui on 16/6/18.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>


@protocol AlarmClockViewControllerDelegate <NSObject>

- (void)ViewControllerSendTime:(NSInteger)time;

@end


@interface LRJAlarmClockViewController : UIViewController

@property (nonatomic, strong) AVAudioPlayer * player;
@property (nonatomic, assign) NSUInteger num;
@property (nonatomic, assign) id<AlarmClockViewControllerDelegate>delegate;


+ (LRJAlarmClockViewController *)sharedAlarmClockViewController;

@end
