//
//  LRJTelphoneViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/27.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJTelphoneViewController.h"


#import "GetSmsCodeBtn.h"

@interface LRJTelphoneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgV;
@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong) UIView *bgV2;
@property (nonatomic, strong) UITextField *yanTF;
@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation LRJTelphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    self.title = @"绑定手机";
    
    self.bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 84, SCREENW, 44)];
    self.bgV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgV];
    [self.bgV addSubview:self.phoneTF];
    
    self.bgV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 148, SCREENW, 44)];
    self.bgV2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgV2];
    [self.bgV2 addSubview:self.yanTF];
    
    
    
    //验证码按钮
    WeakObj(weakSelf, self);
    self.codeBtn = [[GetSmsCodeBtn alloc] initWithFrame:CGRectMake(SCREENW/2+ 22, 0, SCREENW/2 - 22, 44) btnCheckAndGetPhoneNumBlock:^NSString *{
        return [weakSelf checkAndGetPhoneNumber];
    }];
    [self.bgV2 addSubview:self.codeBtn];
    
    
   
    
    [self.view addSubview:self.sureBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.phoneTF becomeFirstResponder];
    
}


- (UITextField *)phoneTF
{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREENW - 24, 44)];
        _phoneTF.backgroundColor = [UIColor whiteColor];
        _phoneTF.font = [UIFont fontWithName:@"Arial" size:16.0f];
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTF.placeholder = @"请输入手机号";
        _phoneTF.clearsOnBeginEditing = YES;
        _phoneTF.textAlignment = NSTextAlignmentLeft;
        _phoneTF.delegate = self;
    }
    
    return _phoneTF;
}


- (UITextField *)yanTF
{
    if (_yanTF == nil) {
        _yanTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREENW/2, 44)];
        _yanTF.backgroundColor = [UIColor whiteColor];
        _yanTF.font = [UIFont fontWithName:@"Arial" size:16.0f];
        _yanTF.clearButtonMode = UITextFieldViewModeNever;
        _yanTF.placeholder = @"请输入验证码";
        _yanTF.clearsOnBeginEditing = YES;
        _yanTF.textAlignment = NSTextAlignmentLeft;
        _yanTF.delegate = self;
    }
    
    return _yanTF;
}


- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 222, SCREENW, 44)];
        _sureBtn.backgroundColor = [UIColor whiteColor];
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}




#pragma mark --

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneTF resignFirstResponder];
    [self.yanTF resignFirstResponder];
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    if (self.phoneTF.text.length > 0) {
//        self.codeBtn.enabled = YES;
//    }else {
//        
//        self.codeBtn.enabled = NO;
//    }

}





#pragma mark - event -
- (NSString *)checkAndGetPhoneNumber{
    if (![self.phoneTF.text isPhoneNo]) {
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@",self.phoneTF.text];
}


- (void)sureBtnClicked
{
    if (![self.phoneTF.text isPhoneNo]) {
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        
    }else {
        
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        
        [NSUserDefaults standardUserDefaults].userMobilNumber = self.phoneTF.text;
        
        //self.changeUserNameBlock(_nameTF.text);
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMobileNum" object:nil userInfo:@{@"key":self.phoneTF.text}];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
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
