//
//  LRJUserNameViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/27.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJUserNameViewController.h"

@interface LRJUserNameViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgV;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation LRJUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];

    self.title = @"更改用户名";
    
    
    self.bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 94, SCREENW, 44)];
    self.bgV.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bgV];
    [self.bgV addSubview:self.nameTF];
    
    [self.view addSubview:self.sureBtn];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.nameTF becomeFirstResponder];

}


- (UITextField *)nameTF
{
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREENW - 20, 44)];
        _nameTF.backgroundColor = [UIColor whiteColor];
        _nameTF.font = [UIFont fontWithName:@"Arial" size:17.0f];
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF.clearsOnBeginEditing = YES;
        _nameTF.placeholder = @"请输入用户名";
        _nameTF.textAlignment = NSTextAlignmentLeft;
        _nameTF.delegate = self;
    }

    return _nameTF;
}


- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 170, SCREENW, 44)];
        _sureBtn.backgroundColor = [UIColor whiteColor];
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //_sureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}


#pragma mark - textFieldDelegate -
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];

    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nameTF resignFirstResponder];


}



#pragma mark - event -
- (void)sureBtnClick
{
    if (self.nameTF.text.length == 0) {
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填上字再提交好吗?" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertV show];
    }else {
    
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        
        
        
        [NSUserDefaults standardUserDefaults].userName = self.nameTF.text;
        
        //self.changeUserNameBlock(_nameTF.text);
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:nil userInfo:@{@"key":self.nameTF.text}];
        
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
