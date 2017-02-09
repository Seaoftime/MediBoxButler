//
//  LRJUserLoginnViewController.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/10/11.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJUserLoginnViewController.h"


#import "LRJUserRegisterrViewController.h"
#import "LRJCustomerRegisterrModel.h"


@interface LRJUserLoginnViewController ()

@property (nonatomic, strong) UIButton *dismissBtn;
@property (nonatomic, strong) UIButton *registerBtn;


@property (nonatomic, strong) UIImageView *userProitImgV;

@property (nonatomic, strong) UIView *lineV1;
@property (nonatomic, strong) UITextField *userNameTF;

@property (nonatomic, strong) UIView *lineV2;
@property (nonatomic, strong) UITextField *passwordTF;


@property (nonatomic, strong) UIButton *loginnBtn;

@property (nonatomic, strong) UIActivityIndicatorView *waittingActivityV;



@property (nonatomic, strong) LRJCustomerRegisterrModel *registerModel;

@property (nonatomic, strong) NSArray *userRegisterArray;//用户注册信息

@property (nonatomic, copy) NSString *userName_Str;
@property (nonatomic, copy) NSString *password_Str;



@end

@implementation LRJUserLoginnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerSuccesss) name:@"registerSuccesss" object:nil];
    
}


- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

#pragma mark ---------------------------------UI

- (void)setupUI
{
    [self.view addSubview:self.dismissBtn];
    [self.view addSubview:self.userProitImgV];
    
    [self.view addSubview:self.userNameTF];
    [self.view addSubview:self.passwordTF];
    
    [self.view addSubview:self.lineV1];
    [self.view addSubview:self.lineV2];
    
    [self.view addSubview:self.loginnBtn];
    [self.view addSubview:self.registerBtn];


    
    self.userRegisterArray = [LRJCustomerRegisterrModel findAll];
    
    NSLog(@"注册信息%@",self.userRegisterArray);

    
    
    
    //系统自带旋转小菊花
    self.waittingActivityV = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.loginnBtn.size.width/2 - 20, 0, 40, 40)];
    
    [self.loginnBtn addSubview:self.waittingActivityV];
    
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



- (UIImageView *)userProitImgV
{
    if (_userProitImgV == nil) {
        _userProitImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW/2 - 40, 100, 80, 80)];
        _userProitImgV.backgroundColor = [UIColor whiteColor];
        _userProitImgV.layer.cornerRadius = 40;
        _userProitImgV.layer.masksToBounds = YES;
        
        
        NSString *imgStr = [NSUserDefaults standardUserDefaults].userImageUrl;
        
        //字符串转图片
        
        if (imgStr == nil || imgStr == NULL || [imgStr isKindOfClass:[NSNull class]]) {
            
            
        }else {
            
            NSData *decodeImgData = [[NSData alloc] initWithBase64EncodedString:imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *userImg = [UIImage imageWithData:decodeImgData];
            
            _userProitImgV.image = userImg;
            
        }
        
        
        
        //_userProitImgV.userInteractionEnabled = YES;
        //UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_userProitImgVTaped)];
        
        //[_userProitImgV addGestureRecognizer:tapp];
        
    }
    return _userProitImgV;
}




- (UITextField *)userNameTF
{
    if (_userNameTF == nil) {
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, SCREENW - 40, 50)];
        _userNameTF.placeholder = @"用户名/手机号";
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
        _lineV1 = [[UIView alloc] initWithFrame:CGRectMake(20 , 250, SCREENW - 40, 1)];
        _lineV1.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        
        
    }
    return _lineV1;
}




- (UIView *)lineV2
{

    if (_lineV2 == nil) {
        _lineV2 = [[UIView alloc] initWithFrame:CGRectMake(20 , 300, SCREENW - 40, 1)];
        _lineV2.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        
        
    }
    return _lineV2;


}






- (UITextField *)passwordTF
{

    if (_passwordTF == nil) {
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 250, SCREENW - 40, 50)];
        _passwordTF.placeholder = @"密码";
        _passwordTF.textColor = [UIColor blackColor];
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _passwordTF.textAlignment = NSTextAlignmentLeft;
        _passwordTF.font = [UIFont systemFontOfSize:17];
    }
    return _passwordTF;
}




- (UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW - 20 - 40, 20, 40, 40)];
        _registerBtn.backgroundColor = [UIColor clearColor];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        //_telphoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //_telphoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_registerBtn addTarget:self action:@selector(_registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}



- (UIButton *)loginnBtn
{

    if (_loginnBtn == nil) {
        _loginnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 350, SCREENW - 40, 40)];
        _loginnBtn.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        [_loginnBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginnBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        //_telphoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //_telphoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [_loginnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginnBtn addTarget:self action:@selector(_loginnBtnnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginnBtn;

}



- (void)registerSuccesss
{
    
    [self _dismissBtnClicked];
    
}



#pragma mark ----------------------------btn event 
- (void)_dismissBtnClicked
{

    [self dismissViewControllerAnimated:YES completion:nil];

}



- (void)_registerBtnClicked
{

    LRJUserRegisterrViewController *registerVC = [[LRJUserRegisterrViewController alloc] init];
    
    [self presentViewController:registerVC animated:YES completion:nil];


}


#pragma mark ----------------------------登录按钮
- (void)_loginnBtnnClicked
{
    
    if ([self.userNameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""]) {
        //
    }else {
    
    
    
        for (NSInteger i = 0; i < self.userRegisterArray.count; i++) {
            //
            self.registerModel = [self.userRegisterArray objectAtIndex:i];
            
            self.userName_Str = self.registerModel.register_userName;
            self.password_Str = self.registerModel.register_userPassword;
            
            
            
            
            
            if ([self.userName_Str isEqualToString:self.userNameTF.text] && [self.password_Str isEqualToString:self.passwordTF.text]) {
                //
                
                [self.loginnBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                
                //开始旋转
                [self.waittingActivityV startAnimating];
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //
                    [self.waittingActivityV stopAnimating];
                    
                    [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
                    
                    [NSUserDefaults standardUserDefaults].userName = self.userName_Str;
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:nil userInfo:@{@"key":self.userName_Str}];
                    
                    
                    //登录成功标记
                    
                    [NSUserDefaults standardUserDefaults].loginSuccessStr = @"loginSuccess";
                    
                    
                    
                    
                    [self _dismissBtnClicked];
                    
                });
                
                
                
            } else {
            
                //[SVProgressHUD showErrorWithStatus:@"请注册!"];
                
            }
            
        }
        
        

    
    
    
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
