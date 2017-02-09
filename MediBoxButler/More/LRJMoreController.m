//
//  LRJMoreController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJMoreController.h"

#import "UIImage+Common.h"
#import <objc/runtime.h>
#import "LRJSettingController.h"
#import "LRJLocalNotificationViewController.h"
#import "LRJMineMediBoxHelperController.h"

#import "UIScrollView+ScalableCover.h"
#import "LRJUserNameViewController.h"

#import "LRJAlarmClockViewController.h"
#import "LRJDrugsEntityyViewController.h"
#import "LRJDrugsWorningViewController.h"
#import "LRJDrugsKnowledgeScienceViewController.h"
#import "LRJHealthyKnowledgeScienceViewController.h"
#import "ZMMeAvatarBrowser.h"

#import "LRJUserLoginnViewController.h"
#import "LRJUserNotification.h"


#define SCREENW [UIScreen mainScreen].bounds.size.width

@interface LRJMoreController ()<UITableViewDataSource,UITableViewDelegate>
{

    BOOL _isNotification;
}

@property (nonatomic, strong) UIView *topV;
//
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UITableView *mainTableView;
//
@property (nonatomic, strong) UIImageView *funcImageV1;
@property (nonatomic, strong) UILabel *funcLabel1;
@property (nonatomic, strong) UIImageView *funcImageV2;
@property (nonatomic, strong) UILabel *funcLabel2;
@property (nonatomic, strong) UIImageView *funcImageV3;
@property (nonatomic, strong) UILabel *funcLabel3;
@property (nonatomic, strong) UIImageView *funcImageV4;
@property (nonatomic, strong) UILabel *funcLabel4;
@property (nonatomic, strong) UIImageView *funcImageV5;
@property (nonatomic, strong) UILabel *funcLabel5;
@property (nonatomic, strong) UIImageView *funcImageV6;
@property (nonatomic, strong) UILabel *funcLabel6;


@end

@implementation LRJMoreController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];

    
//    LRJUserNameViewController *userNameVC = [[LRJUserNameViewController alloc] init];
//
//    [userNameVC setChangeUserNameBlock:^(NSString *str){
//
//        self.userNameLb.text = str;
//        
//    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserName:) name:@"changeName" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserImageV:) name:@"changeUserImageV" object:nil];
    
    
    NSString *loginStt = [NSUserDefaults standardUserDefaults].loginSuccessStr;
    
    if ([loginStt isEqualToString:@"lgout"]) {
        
        self.userNameLb.text = @"点击登录";
    }
    
    
    
    
    

}

//
- (void)changeUserName:(NSNotification *)sender {
    
    self.userNameLb.text = sender.userInfo[@"key"];
}

- (void)changeUserImageV:(NSNotification *)sender {
    
    
    NSString *imgStr = sender.userInfo[@"key"];
    //字符串转图片
    NSData *decodeImgData = [[NSData alloc] initWithBase64EncodedString:imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *userImg = [UIImage imageWithData:decodeImgData];
    
    self.userImageView.image = userImg;
    
}


// 移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [self.view addSubview:self.mainTableView];
    
    //self.mainTableView.tableHeaderView = self.topV;
    
    self.mainTableView.tableHeaderView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH/2 - 80)];
    
    [self.mainTableView addScalableCoverWithImage:[UIImage imageNamed:@"bgImg"]];
    
    [self.mainTableView.tableHeaderView addSubview:self.userImageView];
    [self.mainTableView.tableHeaderView addSubview:self.userNameLb];
    
    [self.mainTableView addSubview:self.funcImageV1];
    [self.mainTableView addSubview:self.funcImageV2];
    [self.mainTableView addSubview:self.funcImageV3];
    [self.mainTableView addSubview:self.funcImageV4];
    [self.mainTableView addSubview:self.funcImageV5];
    [self.mainTableView addSubview:self.funcImageV6];
    
    //    //
    [self.funcImageV1 addSubview:self.funcLabel1];
    [self.funcImageV2 addSubview:self.funcLabel2];
    [self.funcImageV3 addSubview:self.funcLabel3];
    [self.funcImageV4 addSubview:self.funcLabel4];
    [self.funcImageV5 addSubview:self.funcLabel5];
    [self.funcImageV6 addSubview:self.funcLabel6];
//
    
    
    //NSLog(@"%.2f%.2f",width,height);//iphone6    375.00  667.00
    //iphone6 P    414.00    736.00
    //iphone5      320.00    568.00

    
    
    
    //周期性的推送
    [[LRJUserNotification sharedNotification] addNotificationWithCalendarTrigger];
    
    //准时
    //[[LRJUserNotification sharedNotification] addNotificationWithTimeIntervalTrigger];
    
    
    
}


#pragma mark - UI -

//隐藏状态栏
//-(BOOL)prefersStatusBarHidden{
//    
//    
//    return YES;
//    
//}


//

- (UIView *)topV
{
    if (_topV == nil) {
        _topV = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREENW, SCREENH)];
        _topV.backgroundColor = [UIColor whiteColor];
    }

    return _topV;
}


- (UIImageView *)topImageView
{
    if (_topImageView == nil) {
        /**
         调节视图高度 - 20 移到导航栏
         
         - returns:
         */
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, SCREENW, SCREENH/2 - 80)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _topImageView.backgroundColor = [UIColor colorWithRed:230/255.0 green:208/255.0 blue:45/255.0 alpha:1];

        //
        _topImageView.userInteractionEnabled = YES;
        
    }
    
    return _topImageView;
}


- (UILabel *)userNameLb
{
    if (_userNameLb == nil) {
        _userNameLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, SCREENW, 50)];
        //_funcLabel1.backgroundColor = [UIColor whiteColor];
        //_userNameLb.text = @"路人甲";
        _userNameLb.textColor = [UIColor whiteColor];
        _userNameLb.textAlignment = NSTextAlignmentCenter;
        [_userNameLb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        
        
        NSString *nameStr = [NSUserDefaults standardUserDefaults].userName;

        if (nameStr == nil || nameStr == NULL || [nameStr isKindOfClass:[NSNull class]]) {
            
            _userNameLb.text = @"点击登录";
            
        }else {
        
            _userNameLb.text = nameStr;
        }
        
        //[_userNameLb sizeToFit];
        
        _userNameLb.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_userNameLbTaped)];
        
        [_userNameLb addGestureRecognizer:tap];
        

        
    }

    return _userNameLb;
}

- (UIImageView *)userImageView
{
    if (_userImageView == nil) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW/2 - 45, 45, 90, 90)];
        _userImageView.backgroundColor = [UIColor whiteColor];
        _userImageView.layer.cornerRadius = 45;
        //
        _userImageView.layer.borderWidth = 3.0;
        _userImageView.layer.borderColor = [[UIColor yellowColor] CGColor];
        _userImageView.layer.masksToBounds = YES;
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeHeaderImageLarge:)];
        _userImageView.userInteractionEnabled = YES;
        [_userImageView addGestureRecognizer:tap];
        
        //
        
       
        NSString *imgStr = [NSUserDefaults standardUserDefaults].userImageUrl;
        
        //字符串转图片
       
        if (imgStr == nil || imgStr == NULL || [imgStr isKindOfClass:[NSNull class]]) {
            
            
        }else {
        
            NSData *decodeImgData = [[NSData alloc] initWithBase64EncodedString:imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *userImg = [UIImage imageWithData:decodeImgData];
            
            _userImageView.image = userImg;
        
        }
//        NSData *decodeImgData = [[NSData alloc] initWithBase64EncodedString:imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        UIImage *userImg = [UIImage imageWithData:decodeImgData];
//        
//        _userImageView.image = userImg;
    }

    return _userImageView;
}

- (UITableView *)mainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW,SCREENH)];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        //
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"main"];
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        //_mainTableView.backgroundColor = [UIColor colorWithRed:249/255.0 green:239/255.0 blue:91/255.0 alpha:1];
    }
    return _mainTableView;
}

- (UIImageView *)funcImageV1
{
    if (_funcImageV1 == nil) {
        
        if (SCREENW < 370.000000) {
            _funcImageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, SCREENH/2 - 60, SCREENW/2 - 30, 70)];
        }else
            _funcImageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, SCREENH/2 - 90, SCREENW/2 - 30, 80)];
        
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _funcImageV1.backgroundColor = [UIColor colorWithRed:148/255.0 green:206/255.0 blue:87/255.0 alpha:1];
        _funcImageV1.layer.cornerRadius = 12.f;
        //
        _funcImageV1.layer.borderWidth = 1.4f;
        _funcImageV1.layer.borderColor = [UIColor colorWithRed:56/255.0 green:90/255.0 blue:137/255.0 alpha:1].CGColor;
        
        _funcImageV1.layer.masksToBounds = YES;
        _funcImageV1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap11)];
        [_funcImageV1 addGestureRecognizer:tap];
        
        
    }
    
    return _funcImageV1;
}

- (UILabel *)funcLabel1
{
    if (_funcLabel1 == nil) {
        
        if (SCREENW < 370.000000) {
            
            _funcLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, SCREENW/2 - 40, 40)];
            _funcLabel1.text = @"我的药箱助手";
            _funcLabel1.textColor = [UIColor whiteColor];
            _funcLabel1.textAlignment = NSTextAlignmentCenter;
            [_funcLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            [_funcLabel1 sizeToFit];
        }else {
        
            _funcLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, SCREENW/2 - 40, 40)];
            //_funcLabel1.backgroundColor = [UIColor whiteColor];
            _funcLabel1.text = @"我的药箱助手";
            _funcLabel1.textColor = [UIColor whiteColor];
            _funcLabel1.textAlignment = NSTextAlignmentCenter;
            [_funcLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
        }
        
    }
    
    return _funcLabel1;
}


- (UIImageView *)funcImageV2
{
    if (_funcImageV2 == nil) {
        
        if (SCREENW < 370.000000) {
            _funcImageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + SCREENW/2, SCREENH/2 - 60, SCREENW/2 - 30, 70)];
        }else
            _funcImageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + SCREENW/2, SCREENH/2 - 90, SCREENW/2 - 30, 80)];
        
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _funcImageV2.backgroundColor = [UIColor colorWithRed:148/255.0 green:206/255.0 blue:87/255.0 alpha:1];
        _funcImageV2.layer.cornerRadius = 12.f;
        //
        _funcImageV2.layer.borderWidth = 1.4f;
        _funcImageV2.layer.borderColor = [UIColor colorWithRed:56/255.0 green:90/255.0 blue:137/255.0 alpha:1].CGColor;
        
        _funcImageV2.layer.masksToBounds = YES;
        
        _funcImageV2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap22)];
        [_funcImageV2 addGestureRecognizer:tap];
        
    }
    
    return _funcImageV2;
}

- (UILabel *)funcLabel2
{
    if (_funcLabel2 == nil) {
        
        if (SCREENW < 370.000000) {
            
            _funcLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, SCREENW/2 - 40, 40)];
            _funcLabel2.text = @"常备药品录入";
            _funcLabel2.textColor = [UIColor whiteColor];
            _funcLabel2.textAlignment = NSTextAlignmentCenter;
            [_funcLabel2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            [_funcLabel2 sizeToFit];
            
        }else {
        
            _funcLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, SCREENW/2 - 40, 40)];
            //_funcLabel1.backgroundColor = [UIColor whiteColor];
            _funcLabel2.text = @"常备药品录入";
            _funcLabel2.textColor = [UIColor whiteColor];
            _funcLabel2.textAlignment = NSTextAlignmentCenter;
            [_funcLabel2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
        
        }
        
    }
    
    return _funcLabel2;
}


- (UIImageView *)funcImageV3
{
    if (_funcImageV3 == nil) {
        if (SCREENW < 370.000000) {
             _funcImageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, SCREENH/2 - 70 + 100 + 10 - 10, SCREENW/2 - 30, 70)];
        }else
             _funcImageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, SCREENH/2 - 70 + 100 + 10 - 30, SCREENW/2 - 30, 80)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _funcImageV3.backgroundColor = [UIColor colorWithRed:148/255.0 green:206/255.0 blue:87/255.0 alpha:1];
        _funcImageV3.layer.cornerRadius = 12.f;
        //
        _funcImageV3.layer.borderWidth = 1.4f;
        _funcImageV3.layer.borderColor = [UIColor colorWithRed:56/255.0 green:90/255.0 blue:137/255.0 alpha:1].CGColor;
        
        _funcImageV3.layer.masksToBounds = YES;
        _funcImageV3.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap33)];
        [_funcImageV3 addGestureRecognizer:tap];
        
    }
    
    return _funcImageV3;
}

- (UILabel *)funcLabel3
{
    if (_funcLabel3 == nil) {
        
        if (SCREENW < 370.000000) {
            //
            _funcLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, SCREENW/2 - 40, 40)];
            _funcLabel3.text = @"过期药品预警";
            _funcLabel3.textColor = [UIColor whiteColor];
            _funcLabel3.textAlignment = NSTextAlignmentCenter;
            [_funcLabel3 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            [_funcLabel3 sizeToFit];
        }else {
        
        
            _funcLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, SCREENW/2 - 40, 40)];
            //_funcLabel1.backgroundColor = [UIColor whiteColor];
            _funcLabel3.text = @"过期药品预警";
            _funcLabel3.textColor = [UIColor whiteColor];
            _funcLabel3.textAlignment = NSTextAlignmentCenter;
            [_funcLabel3 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
        
        }
    }
    
    return _funcLabel3;
}


- (UIImageView *)funcImageV4
{
    if (_funcImageV4 == nil) {
        if (SCREENW < 370.000000) {
            _funcImageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + SCREENW/2, SCREENH/2 - 70 + 100 + 10 - 10, SCREENW/2 - 30, 70)];
        }else
            _funcImageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + SCREENW/2, SCREENH/2 - 70 + 100 + 10 - 30, SCREENW/2 - 30, 80)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _funcImageV4.backgroundColor = [UIColor colorWithRed:148/255.0 green:206/255.0 blue:87/255.0 alpha:1];
        _funcImageV4.layer.cornerRadius = 12.f;
        //
        _funcImageV4.layer.borderWidth = 1.4f;
        _funcImageV4.layer.borderColor = [UIColor colorWithRed:56/255.0 green:90/255.0 blue:137/255.0 alpha:1].CGColor;
        
        _funcImageV4.layer.masksToBounds = YES;
        
        _funcImageV4.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap44)];
        [_funcImageV4 addGestureRecognizer:tap];
        
        
    }
    
    return _funcImageV4;
}

- (UILabel *)funcLabel4
{
    if (_funcLabel4 == nil) {
        
        if (SCREENW < 370.000000) {
            //
            _funcLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, SCREENW/2 - 40, 40)];
            _funcLabel4.text = @"服药定时提醒";
            _funcLabel4.textColor = [UIColor whiteColor];
            _funcLabel4.textAlignment = NSTextAlignmentCenter;
            [_funcLabel4 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            [_funcLabel4 sizeToFit];
        }else {
            
            _funcLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, SCREENW/2 - 40, 40)];
            //_funcLabel1.backgroundColor = [UIColor whiteColor];
            _funcLabel4.text = @"服药定时提醒";
            _funcLabel4.textColor = [UIColor whiteColor];
            _funcLabel4.textAlignment = NSTextAlignmentCenter;
            [_funcLabel4 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
            
        }
    }
    
    return _funcLabel4;
}

- (UIImageView *)funcImageV5
{
    if (_funcImageV5 == nil) {
        if (SCREENW < 370.000000) {
            _funcImageV5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, SCREENH/2 - 70 + 200 + 10 - 20, SCREENW/2 - 30, 70)];
        }else
            _funcImageV5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, SCREENH/2 - 70 + 200 + 10 - 30, SCREENW/2 - 30, 80)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _funcImageV5.backgroundColor = [UIColor colorWithRed:148/255.0 green:206/255.0 blue:87/255.0 alpha:1];
        _funcImageV5.layer.cornerRadius = 12.f;
        //
        _funcImageV5.layer.borderWidth = 1.4f;
        _funcImageV5.layer.borderColor = [UIColor colorWithRed:56/255.0 green:90/255.0 blue:137/255.0 alpha:1].CGColor;
        
        _funcImageV5.layer.masksToBounds = YES;
        _funcImageV5.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap55)];
        [_funcImageV5 addGestureRecognizer:tap];
        
    }
    
    return _funcImageV5;
}

- (UILabel *)funcLabel5
{
    if (_funcLabel5 == nil) {
        
    
        if (SCREENW < 370.000000) {
            //
            _funcLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, SCREENW/2 - 40, 40)];
            _funcLabel5.text = @"药品知识科普";
            _funcLabel5.textColor = [UIColor whiteColor];
            _funcLabel5.textAlignment = NSTextAlignmentCenter;
            [_funcLabel5 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            [_funcLabel5 sizeToFit];
        }else {
            
            _funcLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, SCREENW/2 - 40, 40)];
            //_funcLabel1.backgroundColor = [UIColor whiteColor];
            _funcLabel5.text = @"药品知识科普";
            _funcLabel5.textColor = [UIColor whiteColor];
            _funcLabel5.textAlignment = NSTextAlignmentCenter;
            [_funcLabel5 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
            
        }
        
        
    }
    
    return _funcLabel5;
}



- (UIImageView *)funcImageV6
{
    if (_funcImageV6 == nil) {
        
        if (SCREENW < 370.000000) {
            _funcImageV6 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + SCREENW/2, SCREENH/2 - 70 + 200 + 10 - 20, SCREENW/2 - 30, 70)];
        }else
            _funcImageV6 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + SCREENW/2, SCREENH/2 - 70 + 200 + 10 - 30, SCREENW/2 - 30, 80)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _funcImageV6.backgroundColor = [UIColor colorWithRed:148/255.0 green:206/255.0 blue:87/255.0 alpha:1];
        _funcImageV6.layer.cornerRadius = 12.f;
        //
        _funcImageV6.layer.borderWidth = 1.4f;
        _funcImageV6.layer.borderColor = [UIColor colorWithRed:56/255.0 green:90/255.0 blue:137/255.0 alpha:1].CGColor;
        
        _funcImageV6.layer.masksToBounds = YES;
        _funcImageV6.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap66)];
        [_funcImageV6 addGestureRecognizer:tap];
        
    }
    
    return _funcImageV6;
}


- (UILabel *)funcLabel6
{
    if (_funcLabel6 == nil) {
        
        if (SCREENW < 370.000000) {
            //
            _funcLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, SCREENW/2 - 40, 40)];
            _funcLabel6.text = @"家庭健康知识";
            _funcLabel6.textColor = [UIColor whiteColor];
            _funcLabel6.textAlignment = NSTextAlignmentCenter;
            [_funcLabel6 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            [_funcLabel6 sizeToFit];
            
        }else {
            
            
            _funcLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, SCREENW/2 - 40, 40)];
            //_funcLabel1.backgroundColor = [UIColor whiteColor];
            _funcLabel6.text = @"家庭健康知识";
            _funcLabel6.textColor = [UIColor whiteColor];
            _funcLabel6.textAlignment = NSTextAlignmentCenter;
            [_funcLabel6 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
   
        }
        
    }
    
    return _funcLabel6;
}





#pragma mark - tableViewDelegate && dataSource -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
    
//    FirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
//    
//    
//    //设置cell 的选中状态
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    //cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 10;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark - event -

- (void)userImageViewTaped
{

    LRJSettingController *settingVC = [[LRJSettingController alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController pushViewController:settingVC animated:YES];

    //[self presentViewController:settingVC animated:YES completion:nil];


}


- (void)tap11
{
    NSString *loginsuccess = [NSUserDefaults standardUserDefaults].loginSuccessStr;
    
    
    if (loginsuccess == nil || loginsuccess == NULL || [loginsuccess isKindOfClass:[NSNull class]]) {
        
        [SVProgressHUD showErrorWithStatus:@"请登录!"];
        
    }else {
        
        if ([loginsuccess isEqualToString:@"loginSuccess"]) {
            //
            LRJMineMediBoxHelperController *localNVC = [[LRJMineMediBoxHelperController alloc] init];
            [self.navigationController setNavigationBarHidden:NO];
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:localNVC animated:YES];
            
            self.hidesBottomBarWhenPushed = NO;
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"请登录!"];
            
        }

    }
    
}

- (void)tap22
{
    
    LRJDrugsEntityyViewController *drugsEntityVC = [[LRJDrugsEntityyViewController alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:drugsEntityVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)tap33
{
    
    LRJDrugsWorningViewController *drugsWorningVC = [[LRJDrugsWorningViewController alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:drugsWorningVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}


- (void)tap44
{
    LRJLocalNotificationViewController *localNVC = [[LRJLocalNotificationViewController alloc] init];
    
    //LRJAlarmClockViewController *localNVC = [[LRJAlarmClockViewController alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO];

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:localNVC animated:YES];

    self.hidesBottomBarWhenPushed = NO;

}

- (void)tap55
{
    
    LRJDrugsKnowledgeScienceViewController *konwledgeSinVC = [[LRJDrugsKnowledgeScienceViewController alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:konwledgeSinVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}


- (void)tap66
{
    
    LRJHealthyKnowledgeScienceViewController *healthyVC = [[LRJHealthyKnowledgeScienceViewController alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:healthyVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}



#pragma mark ----------------------------登录界面

- (void)_userNameLbTaped
{

    LRJUserLoginnViewController *login = [[LRJUserLoginnViewController alloc] init];


    [self presentViewController:login animated:YES completion:nil];
}





- (void)makeHeaderImageLarge:(UITapGestureRecognizer *)ges
{
    
    NSString *imgStr = [NSUserDefaults standardUserDefaults].userImageUrl;
    
    //字符串转图片
    
    if (imgStr == nil || imgStr == NULL || [imgStr isKindOfClass:[NSNull class]]) {
        
        [self _userNameLbTaped];
        
    }else {
        
        [ZMMeAvatarBrowser showImage:self.userImageView];
        
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
