//
//  LRJUserRegisterrViewController.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/10/11.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJUserRegisterrViewController.h"


#import "LRJCustomerRegisterrModel.h"



@interface LRJUserRegisterrViewController ()

@property (nonatomic, strong) UIButton *dismissBtn;

@property (nonatomic, strong) UIView *lineV1;
@property (nonatomic, strong) UITextField *userNameTF;

@property (nonatomic, strong) UIView *lineV2;
@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UIView *lineV3;
@property (nonatomic, strong) UITextField *passwordAgainTF;



@property (nonatomic, strong) UIButton *registerBtn;



@property (nonatomic, strong) UIActivityIndicatorView *waittingActivityV;


@property (nonatomic, strong) LRJCustomerRegisterrModel *registerModel;


@property (nonatomic, strong) NSArray *userRegisterArray;//用户注册信息




@end

@implementation LRJUserRegisterrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    
    self.userRegisterArray = [LRJCustomerRegisterrModel findAll];
    
    NSLog(@"注册信息%@",self.userRegisterArray);
    
    
}




#pragma mark ---------------------------------UI

- (void)setupUI
{
    [self.view addSubview:self.dismissBtn];
    
    [self.view addSubview:self.userNameTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.passwordAgainTF];

    
    
    
    [self.view addSubview:self.lineV1];
    [self.view addSubview:self.lineV2];
    [self.view addSubview:self.lineV3];
    
    [self.view addSubview:self.registerBtn];

    
    
    //系统自带旋转小菊花
    self.waittingActivityV = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.registerBtn.size.width/2 - 20, 0, 40, 40)];
    
    [self.registerBtn addSubview:self.waittingActivityV];
    
    self.waittingActivityV.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    
    
    
    
    
    
}

- (UIButton *)dismissBtn
{
    if (_dismissBtn == nil) {
        
        _dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
        _dismissBtn.backgroundColor = [UIColor clearColor];
        
        [_dismissBtn setBackgroundImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        
        
        
        [_dismissBtn addTarget:self action:@selector(_dismissBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
    
}




- (UITextField *)userNameTF
{
    if (_userNameTF == nil) {
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, SCREENW - 40, 50)];
        _userNameTF.placeholder = @"请输入用户名/手机号";
        _userNameTF.textColor = [UIColor blackColor];
        _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _userNameTF.textAlignment = NSTextAlignmentLeft;
        _userNameTF.font = [UIFont systemFontOfSize:17];
    }
    return _userNameTF;
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






- (UITextField *)passwordTF
{
    
    if (_passwordTF == nil) {
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, SCREENW - 40, 50)];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.textColor = [UIColor blackColor];
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _passwordTF.textAlignment = NSTextAlignmentLeft;
        _passwordTF.font = [UIFont systemFontOfSize:17];
    }
    return _passwordTF;
}


- (UITextField *)passwordAgainTF
{
    
    if (_passwordAgainTF == nil) {
        _passwordAgainTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 250, SCREENW - 40, 50)];
        _passwordAgainTF.placeholder = @"请再次输入密码";
        _passwordAgainTF.textColor = [UIColor blackColor];
        _passwordAgainTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
        _passwordAgainTF.textAlignment = NSTextAlignmentLeft;
        _passwordAgainTF.font = [UIFont systemFontOfSize:17];
    }
    return _passwordAgainTF;
}


- (UIView *)lineV3
{
    
    if (_lineV3 == nil) {
        _lineV3 = [[UIView alloc] initWithFrame:CGRectMake(20 , 300, SCREENW - 40, 1)];
        _lineV3.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        
        
    }
    return _lineV3;
    
}


- (UIButton *)registerBtn
{
    
    if (_registerBtn == nil) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 350, SCREENW - 40, 40)];
        _registerBtn.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_registerBtn addTarget:self action:@selector(_registerBtnnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
    
}




#pragma mark ----------------------------btn event
- (void)_dismissBtnClicked
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (void)_registerBtnnClicked
{

#pragma mark ------------------------------ 用户注册
    
    NSString *userNameStr = self.userNameTF.text;
    NSString *passwordStr = self.passwordTF.text;
    NSString *passwordStr22 = self.passwordAgainTF.text;
    
    
    
    for (NSInteger i = 0; i < self.userRegisterArray.count; i++) {
        //
        self.registerModel = [self.userRegisterArray objectAtIndex:i];
        
        NSString *userName_Str = self.registerModel.register_userName;
        
        NSLog(@"%@",userName_Str);
        
        
        if ([userName_Str isEqualToString:userNameStr]) {
            
            [SVProgressHUD showErrorWithStatus:@"用户名已被注册,请换个名字"];
            
            return;
        }
        
        
    }
    
    

    
    
    if ([userNameStr isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入用户名/手机号"];
    } else if ([passwordStr isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
    } else if ( [passwordStr22 isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
    } else if (![passwordStr isEqualToString:passwordStr22]) {
        
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致!"];
    }else {
    
    
        [_registerBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        //开始旋转
        [self.waittingActivityV startAnimating];
        
        self.registerModel = [[LRJCustomerRegisterrModel alloc] init];
        
        self.registerModel.register_userName = userNameStr;
        self.registerModel.register_userPassword = passwordStr22;
        
        //插入一条数据
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self.registerModel save];
        });

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            //停止旋转
            [self.waittingActivityV stopAnimating];
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
        });
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //
            [self _dismissBtnClicked];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"registerSuccesss" object:nil];
            
        });
        
    
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
