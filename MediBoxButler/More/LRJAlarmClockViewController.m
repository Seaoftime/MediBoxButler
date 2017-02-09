//
//  LRJAlarmClockViewController.m
//  MediBoxButler
//
//  Created by ZhangRui on 16/6/18.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJAlarmClockViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "SYDatePicker.h"

//闹钟

#import "UserDefalutManager.h"
#import "TimeManager.h"
#import "AlarmManager.h"
#import "Router.h"


#import "LRJClockRinggMoodel.h"

#define kW self.view.frame.size.width
#define kH self.view.frame.size.height



@interface LRJAlarmClockViewController ()<SYDatePickerDelegate>
{
    NSTimer * _timer;  //定时器
}
@property (nonatomic, weak) UIDatePicker * picker;
@property (nonatomic, strong) UIAlertView * alert;
@property (nonatomic, weak) UILabel * label;

@property (nonatomic, assign) NSInteger lt;

@property (nonatomic, weak) UIButton * button;


///
@property (nonatomic, strong) UIMutableUserNotificationCategory * categorys;





//------------------------------------------------
@property (nonatomic, strong) UIView *lineV1;
@property (nonatomic, strong) UITextField *drugNameTF;

@property (nonatomic, strong) UIView *lineV2;
@property (nonatomic, strong) UITextField *drugNumTF;

@property (nonatomic, strong) UIView *lineV3;
@property (nonatomic, strong) UILabel *timeLb;

@property (nonatomic, strong) SYDatePicker *datepicker;

@property (nonatomic, copy) NSString *timeHourStr;
@property (nonatomic, copy) NSString *timeMinuStr;



////闹钟
@property (strong,nonatomic) UserDefalutManager *userDef;
@property (strong,nonatomic) TimeManager *timeManager;

@property (strong,nonatomic) LRJClockRinggMoodel *clockRingModel;


@end

@implementation LRJAlarmClockViewController


+ (LRJAlarmClockViewController *)sharedAlarmClockViewController
{
    static LRJAlarmClockViewController *alarmClockVC = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        alarmClockVC = [[self alloc] init];
    });
    
    return alarmClockVC;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加服药提醒";
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self customNavigationLeftBarItems];
    [self customNavigationRightBarItems];
    
    
    //[self loadsomeview];
    [self setupUI];

    
    ///闹钟
    self.userDef = [UserDefalutManager sharedManager];
    self.timeManager = [TimeManager sharedManager];
    

    ////
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeeClockk) name:@"closeeClocKk" object:nil];
    
    
    
}


#pragma mark - UI -


- (void)setupUI
{
    [self.view addSubview:self.drugNameTF];
    [self.view addSubview:self.drugNumTF];
    [self.view addSubview:self.timeLb];
    
    [self.view addSubview:self.lineV1];
    [self.view addSubview:self.lineV2];
    [self.view addSubview:self.lineV3];



}



- (UITextField *)drugNameTF
{
    if (_drugNameTF == nil) {
        _drugNameTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, SCREENW - 40, 50)];
        _drugNameTF.placeholder = @"请输入药品名称";
        _drugNameTF.textColor = [UIColor blackColor];
        _drugNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _drugNameTF.textAlignment = NSTextAlignmentLeft;
        _drugNameTF.font = [UIFont systemFontOfSize:17];
    }
    return _drugNameTF;
}

- (UITextField *)drugNumTF
{

    if (_drugNumTF == nil) {
        _drugNumTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, SCREENW - 40, 50)];
        _drugNumTF.placeholder = @"请输入用量";
        _drugNumTF.textColor = [UIColor blackColor];
        _drugNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _drugNumTF.textAlignment = NSTextAlignmentLeft;
        _drugNumTF.font = [UIFont systemFontOfSize:17];
    }
    return _drugNumTF;

}

- (UILabel *)timeLb
{
    if (_timeLb == nil) {
        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, SCREENW - 40, 50)];
        _timeLb.text = @"点击添加时间";
        _timeLb.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];

        
        
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.font = [UIFont systemFontOfSize:17];
        
        _timeLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_timeLBClicked)];
        [_timeLb addGestureRecognizer:tap];

        
    }
    return _timeLb;
}




- (UIView *)lineV1
{
    if (_lineV1 == nil) {
        _lineV1 = [[UIView alloc] initWithFrame:CGRectMake(20 , 200, SCREENW - 40, 1)];
        _lineV1.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        
        
    }
    return _lineV1;
}




- (UIView *)lineV2
{
    
    if (_lineV2 == nil) {
        _lineV2 = [[UIView alloc] initWithFrame:CGRectMake(20 , 250, SCREENW - 40, 1)];
        _lineV2.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        
        
    }
    return _lineV2;
    
}


- (UIView *)lineV3
{
    
    if (_lineV3 == nil) {
        _lineV3 = [[UIView alloc] initWithFrame:CGRectMake(20 , 300, SCREENW - 40, 1)];
        _lineV3.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        
        
    }
    return _lineV3;
    
}





////-------------------------------------------
////-------------------------------------------

- (void)_timeLBClicked
{
    //[self.view endEditing:YES];
    [self.drugNameTF resignFirstResponder];
    [self.drugNumTF resignFirstResponder];
    
    
    //由于_picker是成员变量,因此注意此处一定要判断self.picker是否存在,否则将会出现重复创建的情况
    if (!self.datepicker) {
        self.datepicker = [[SYDatePicker alloc] init];
    }
    
    [self.datepicker showInView:self.view withFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300) andDatePickerMode:UIDatePickerModeTime];
    
    self.datepicker.delegate = self;



}



- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"HH:mm";
    
    
    NSString *timeStr = [fm stringFromDate:date];
    
    NSArray *timeArray = [timeStr componentsSeparatedByString:@":"];
    
    
    self.timeLb.textColor = [UIColor blackColor];
    self.timeLb.text = timeStr;
    
    self.timeHourStr = timeArray[0];
    self.timeMinuStr = timeArray[1];
    
    
    NSLog(@"闹钟时间: %@   %@",timeArray[0], timeArray[1]);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.datepicker dismiss];
}


////-------------------------------------------
////-------------------------------------------






- (void)customNavigationLeftBarItems
{
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 8, 25, 25)];
    imgV.image = [UIImage imageNamed:@"iconfont-fanhui"];
    
    //imgV.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imgV];
    
    self.navigationItem.leftBarButtonItem = item;
    
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backk)];
    
    [imgV addGestureRecognizer:tap];
    
}



- (void)customNavigationRightBarItems
{
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 50, 10, 25, 25)];
    //_addImageView.backgroundColor = [UIColor blackColor];
    UIImage *img = [[UIImage imageNamed:@"确定"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgV.image = img;
    imgV.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    //
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightbuttonClick)];
    
    [imgV addGestureRecognizer:tap];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imgV];
    
    self.navigationItem.rightBarButtonItem = item;
    
}

////-------------------------------------------
////-------------------------------------------

- (void)rightbuttonClick
{
    
    
    ///开启闹钟
    [self saveAlarmTime];
    
    [self clearAlarmTimer ];
    [self createAlarmTimer];
    [self.userDef setDefaultAlarm:YES];
    
    [self confirmNotificationAlert];
    
    
    [SVProgressHUD showSuccessWithStatus:@"定时服药提醒添加成功!"];
    [self backk];
    
    
    
}



///关闭闹钟
- (void)closeeClockk
{
    [self clearAlarmTimer];
    [self.userDef setDefaultAlarm:NO];
    [self.userDef setDisplayedAwakeAlarmView:NO];
    

}

- (void)saveAlarmTime
{
    //NSMutableDictionary *dict = [self.timeManager getAssignDate:self.alarmDatePicker.date];
    
//    [self.userDef setDefaultAlarmTime:[@{@"hour":dict[@"hour"],@"minute":dict[@"minute"]}mutableCopy] ];
    
    [self.userDef setDefaultAlarmTime:[@{@"hour":self.timeHourStr, @"minute":self.timeMinuStr }mutableCopy] ];
    
    self.clockRingModel = [[LRJClockRinggMoodel alloc] init];
    
    self.clockRingModel.clock_drugName = self.drugNameTF.text;
    self.clockRingModel.clock_drugCount = self.drugNumTF.text;
    self.clockRingModel.clock_time = self.timeLb.text;
    
    
    //插入一条数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.clockRingModel save];
    });
    
    
    NSLog(@"右: %@ %@",self.timeHourStr, self.timeMinuStr);
    
    
}


-(void)clearAlarmTimer
{
    
    AlarmManager *alarmManager = [AlarmManager sharedManager];
    
    [alarmManager clearLocalNotification ];
    
}

-(void)createAlarmTimer
{
    
    NSDate *trimDate = [self.timeManager createTrimDateFromNSDate:self.datepicker.picker.date];
    
    AlarmManager *alarmManager = [AlarmManager sharedManager];
    [alarmManager setLocalNotification:[self.timeManager convertAlarmDate:trimDate]];
    
}


-(void)confirmNotificationAlert
{
    
    if(NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1){
        return;
    }
    
    UIUserNotificationSettings *currentSettings = [[UIApplication
                                                    sharedApplication] currentUserNotificationSettings];
    
    if(currentSettings.types == UIUserNotificationTypeNone){
        
        UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"提示"
                                                                     message:@"请在设置中打开通知权限"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              
                                                          }];
        [ac addAction:okAction];
        
        [self presentViewController:ac animated:YES completion:nil];
    }
}


////-------------------------------------------
////-------------------------------------------

#pragma mark - event -

- (void)backk
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self pop];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
