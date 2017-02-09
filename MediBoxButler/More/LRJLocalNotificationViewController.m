//
//  LRJLocalNotificationViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/18.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJLocalNotificationViewController.h"

#import "CuiPickerView.h"
#import "LRJAlarmClockViewController.h"
#import "LRJClockkRinggTableViewCell.h"
#import "LRJClockRinggMoodel.h"

@interface LRJLocalNotificationViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *bgImageView2;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) UITextField *addTF;
@property (nonatomic, strong) CuiPickerView *cuiPickerView;
@property (nonatomic, strong) NSString *dataString;
//

@property (nonatomic, strong) NSTimer *paintingTimer;

/////////
@property (nonatomic, strong) UITableView *clockkTableView;
@property (nonatomic, strong) NSArray *clockArray;

@property (nonatomic, strong) LRJClockRinggMoodel *clockModel;

@property (nonatomic, strong) UILabel *tisiLb;


@end

@implementation LRJLocalNotificationViewController

- (void) stopPainting{
    if (self.paintingTimer != nil){
        // 定时器调用invalidate后，就会自动执行release方法。不需要在显示的调用release方法
        [self.paintingTimer invalidate];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [self stopPainting];// 停止定时器
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"服药定时提醒";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    [self customNavigationLeftBarItems];
    [self customNavigationRightBarItems];
    
    
    self.clockArray = [LRJClockRinggMoodel findAll];
    

    [self.view addSubview:self.clockkTableView];
    

    [self.view addSubview:self.tisiLb];
    
    
//
//    [self.view addSubview:self.bgImageView2];
//    [self.bgImageView2 addSubview:self.addImageView];
//    //[self.bgImageView2 addSubview:self.addLabel];
//    [self.bgImageView2 addSubview:self.addTF];
//    
//    //
//    _addTF.delegate = self;
//    
//    _cuiPickerView = [[CuiPickerView alloc]init];
//    _cuiPickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
//    
//    //这一步很重要
//    _cuiPickerView.myTextField = _addTF;
//    
//    _cuiPickerView.delegate = self;
//    _cuiPickerView.curDate=[NSDate date];
//    [self.view addSubview:_cuiPickerView];
//    
//    
//    /**
//     *  LocalNotification
//     */
////    [self createLocalNotification];
//    
//    
//    self.paintingTimer = [NSTimer timerWithTimeInterval:1.0
//                                                 target:self
//                                               selector:@selector(upadte)
//                                               userInfo:nil
//                                                repeats:YES];
//    
//    
//    //
//    [[NSRunLoop currentRunLoop] addTimer:self.paintingTimer forMode:NSDefaultRunLoopMode];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.clockArray = [LRJClockRinggMoodel findAll];
    
    if (self.clockArray.count == 0) {
        
        self.tisiLb.hidden = NO;
        
    } else {
    
    
        self.tisiLb.hidden = YES;

    }
    
    [self.clockkTableView reloadData];
    
    
    
}


#pragma mark - UI -

- (UILabel *)tisiLb
{
    if (_tisiLb == nil) {
        _tisiLb = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENH/2 - 50, SCREENW , 50)];
        _tisiLb.text = @"点击右上角添加";
        _tisiLb.textColor = [UIColor blackColor];
        
        _tisiLb.textAlignment = NSTextAlignmentCenter;
        _tisiLb.font = [UIFont systemFontOfSize:17];
        
        
    }
    return _tisiLb;
}


- (UITableView *)clockkTableView
{
    if (_clockkTableView == nil) {
        
        _clockkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _clockkTableView.backgroundColor = [UIColor clearColor];
        _clockkTableView.delegate = self;
        _clockkTableView.dataSource = self;
        _clockkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"LRJClockkRinggTableViewCell" bundle:nil];
        [_clockkTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        
    }
    return _clockkTableView;
}



#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.clockArray.count;
    //return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRJClockkRinggTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, SCREENW, 1)];
    vi.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [cell addSubview:vi];
    
    
    LRJClockRinggMoodel *model = [self.clockArray objectAtIndex:indexPath.row];
    
    
    cell.drugNameLb.text = model.clock_drugName;
    
    cell.drugCountLb.text = model.clock_drugCount;
    
    cell.drugTimeLb.text = model.clock_time;
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 83;
    //return SCREENH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
    
}






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
    
//    UIButton *rightB = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW - 50, 8, 40, 30)];
//    
//    [rightB setTitle:@"添加" forState:UIControlStateNormal];
//    [rightB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [rightB addTarget:self action:@selector(rightbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 50, 10, 25, 25)];
    //_addImageView.backgroundColor = [UIColor blackColor];
    UIImage *img = [[UIImage imageNamed:@"iconfont-jiahao (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgV.image = img;
    imgV.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    //
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightbuttonClick)];
    
    [imgV addGestureRecognizer:tap];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imgV];
    
    self.navigationItem.rightBarButtonItem = item;
    
}



- (UIImageView *)bgImageView2
{
    if (_bgImageView2 == nil) {
        _bgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENW, 44)];
        _bgImageView2.backgroundColor = [UIColor whiteColor];
        
        _bgImageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapp)];
        [_bgImageView2 addGestureRecognizer:tapp];
        
    }
    return _bgImageView2;
}


- (UIImageView *)addImageView
{
    if (_addImageView == nil) {
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 25, 25)];
        //_addImageView.backgroundColor = [UIColor blackColor];
        UIImage *img = [[UIImage imageNamed:@"iconfont-jiahao (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _addImageView.image = img;
        _addImageView.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        
        //
        _addImageView.userInteractionEnabled = YES;
        
    }
    return _addImageView;
}

//- (UILabel *)addLabel
//{
//    if (_addLabel == nil) {
//        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 150, 34)];
//        _addLabel.text = @"添加服药定时提醒";
//        _addLabel.textColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
//        _addLabel.textAlignment = NSTextAlignmentLeft;
//        _addLabel.font = [UIFont systemFontOfSize:15];
//    }
//    return _addLabel;
//}


- (UITextField *)addTF
{
    if (_addTF == nil) {
        _addTF = [[UITextField alloc] initWithFrame:CGRectMake(60, 5, 150, 34)];
        _addTF.placeholder = @"添加服药定时提醒";
        _addTF.textColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        _addTF.textAlignment = NSTextAlignmentLeft;
        _addTF.font = [UIFont systemFontOfSize:15];
    }
    return _addTF;
}


- (void)createLocalNotification
{
    UILocalNotification *notifity=[[UILocalNotification alloc] init];
    NSDateFormatter *formattr=[[NSDateFormatter alloc] init];
    //格式化时间
    [formattr setDateFormat:@"HH:mm"];
    //触发通知时间
    NSDate *now=[formattr dateFromString:[NSString stringWithFormat:@"%@",self.addTF]];
    notifity.fireDate=now;
    //时区
    notifity.timeZone=[NSTimeZone defaultTimeZone];
    //通知重复提示的单位,可以是周(NSWeekdayCalendarUnit)分钟(NSMinuteCalendarUnit)秒（NSSecondCalendarUnit）月（NSMonthCalendarUnit）年(NSYearCalendarUnit)
    
    notifity.repeatInterval = NSDayCalendarUnit;
    
    //通知内容
    notifity.alertBody=@"服药定时提醒:已到服药时间";
    //通知触发时播放的声音
    notifity.soundName = UILocalNotificationDefaultSoundName;
    //执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notifity];
    //
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"定时提醒" message:@"您已到服药时间" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    
    [alertview show];
    
    



}

#pragma mark - event -

- (void)backk
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self pop];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightbuttonClick
{
    
    LRJAlarmClockViewController *alarmVC = [LRJAlarmClockViewController sharedAlarmClockViewController];
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:alarmVC animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
    

}

- (void)tapp
{
    [_cuiPickerView showInView:self.view];


}


//开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    [_cuiPickerView showInView:self.view];
}

//赋值给textField
-(void)didFinishPickView:(NSString *)date
{
    self.dataString = date;
    _addTF.text = date;
}




-(void)upadte
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    
    if ([dateString isEqualToString:self.addTF.text]) {
        
        [self createLocalNotification];
        //
        [self stopPainting];
        
    }
    
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
