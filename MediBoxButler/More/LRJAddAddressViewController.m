//
//  LRJAddAddressViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/28.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJAddAddressViewController.h"

#import "AddressPickView.h"
#import "LRJAddAddressTableViewCell.h"
#import "LRJAddressModel.h"
#import "LRJUserAddressDB.h"
#import "LRJAddAddressDBModel.h"

@interface LRJAddAddressViewController ()<UITextFieldDelegate,UITextViewDelegate>

//@property (nonatomic, strong) UIView *bgV;
//@property (nonatomic, strong) UITextField *nameTF;
//@property (nonatomic, strong) UIView *bgV2;
//@property (nonatomic, strong) UITextField *phoneTF;
//@property (nonatomic, strong) UIView *bgV3;
//@property (nonatomic, strong) UILabel *addressLabel;
//@property (nonatomic, strong) UIView *bgV4;
////@property (nonatomic, strong) UITextView *addressDetailTV;
////@property (nonatomic, strong) UILabel *placeLb;
//@property (nonatomic, strong) UITextField *addressDetailTF;
//
//@property (nonatomic, strong) UIButton *sureBtn;
//
//
//@property (nonatomic, strong) LRJAddressModel *addressModel;
@property (nonatomic, strong) LRJAddAddressDBModel *addressModel;

@end

@implementation LRJAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //self.title = @"添加地址";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    //
    self.bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 84, SCREENW, 44)];
    self.bgV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgV];
    [self.bgV addSubview:self.nameTF];
    
    
    self.bgV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 129, SCREENW, 44)];
    self.bgV2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgV2];
    [self.bgV2 addSubview:self.phoneTF];
    
    self.bgV3 = [[UIView alloc] initWithFrame:CGRectMake(0, 174, SCREENW, 44)];
    self.bgV3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgV3];
    [self.bgV3 addSubview:self.addressLabel];
    
    self.bgV4 = [[UIView alloc] initWithFrame:CGRectMake(0, 219, SCREENW, 88)];
    self.bgV4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgV4];
    [self.bgV4 addSubview:self.addressDetailTF];
    //[self.addressDetailTV addSubview:self.placeLb];
    
    [self.view addSubview:self.sureBtn];
    
    
    //
    //self.addressModel = [[LRJAddressModel alloc] init];
    
    
}


#pragma mark - UI -
- (UITextField *)nameTF
{
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREENW - 24, 44)];
        _nameTF.backgroundColor = [UIColor whiteColor];
        _nameTF.font = [UIFont fontWithName:@"Arial" size:16.0f];
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF.placeholder = @"姓名";
        _nameTF.clearsOnBeginEditing = YES;
        _nameTF.textAlignment = NSTextAlignmentLeft;
        _nameTF.delegate = self;
    }
    
    return _nameTF;
}


- (UITextField *)phoneTF
{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREENW - 24, 44)];
        _phoneTF.backgroundColor = [UIColor whiteColor];
        _phoneTF.font = [UIFont fontWithName:@"Arial" size:16.0f];
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTF.placeholder = @"手机号码";
        _phoneTF.clearsOnBeginEditing = YES;
        _phoneTF.textAlignment = NSTextAlignmentLeft;
        _phoneTF.delegate = self;
    }
    
    return _phoneTF;
}


- (UITextField *)addressDetailTF
{
    if (_addressDetailTF == nil) {
        _addressDetailTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREENW - 24, 88)];
        _addressDetailTF.backgroundColor = [UIColor whiteColor];
        _addressDetailTF.font = [UIFont fontWithName:@"Arial" size:16.0f];
        _addressDetailTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addressDetailTF.placeholder = @"详细地址";
        _addressDetailTF.clearButtonMode = UITextFieldViewModeUnlessEditing;
        _addressDetailTF.textAlignment = NSTextAlignmentLeft;
        _addressDetailTF.delegate = self;
    }
    
    return _addressDetailTF;
}



- (UILabel *)addressLabel
{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREENW - 24, 44)];
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.text = @"省、市、县";
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [_addressLabel setFont:[UIFont fontWithName:@"Arial" size:16.0f]];
        
        _addressLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressLabelTap)];
        [_addressLabel addGestureRecognizer:tap];
    }
    
    return _addressLabel;
}


//- (UITextView *)addressDetailTV
//{
//    if (_addressDetailTV == nil) {
//        _addressDetailTV = [[UITextView alloc] initWithFrame:CGRectMake(12, 0, SCREENW - 24, 88)];
//        _addressDetailTV.backgroundColor = [UIColor whiteColor];
//        _addressDetailTV.font = [UIFont fontWithName:@"Arial" size:16.0f];
//        
//        _addressDetailTV.textAlignment = NSTextAlignmentLeft;
//        _addressDetailTV.delegate = self;
//    }
//    
//    return _addressDetailTV;
//}
//
//- (UILabel *)placeLb
//{
//    if (_placeLb == nil) {
//        _placeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, -3, 100, 44)];
//        _placeLb.backgroundColor = [UIColor whiteColor];
//        _placeLb.text = @"详细地址";
//        _placeLb.textColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:206/255.0 alpha:1.0];
//        _placeLb.textAlignment = NSTextAlignmentLeft;
//        [_placeLb setFont:[UIFont fontWithName:@"Arial" size:16.0f]];
//    }
//    
//    return _placeLb;
//}

- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 330, SCREENW, 44)];
        _sureBtn.backgroundColor = [UIColor whiteColor];
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_sureBtn addTarget:self action:@selector(sureBtnClickedd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}



//#pragma mark - textViewDelegate -
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if (textView == self.addressDetailTV) {
//        [self.placeLb removeFromSuperview];
//    }
//
//
//}
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//
//
//
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//
//    if (textView == self.addressDetailTV) {
//        //[self.addressDetailTV addSubview:self.placeLb];
//    }
//
//
//}

#pragma mark - event -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneTF resignFirstResponder];
    [self.nameTF resignFirstResponder];
    [self.addressDetailTF resignFirstResponder];
    
}




- (void)addressLabelTap
{
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    
    [self.view addSubview:addressPickView];
    
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        
    };

}

- (void)sureBtnClickedd
{
    if ((self.nameTF.text.length != 0) && (self.phoneTF.text.length != 0) && (self.addressLabel.text.length != 0) && (self.addressDetailTF.text.length != 0)) {
        
//        self.addressModel.name = self.nameTF.text;
//        self.addressModel.telnum = self.phoneTF.text;
//        self.addressModel.address = [NSString stringWithFormat:@"%@%@",self.addressLabel.text,self.addressDetailTF.text];
//        //
//        [[LRJUserAddressDB sharedInstance] saveAddress:self.addressModel];
//
        
//        [NSUserDefaults standardUserDefaults].address_Name = self.nameTF.text;
//        [NSUserDefaults standardUserDefaults].address_Tel = self.phoneTF.text;
//        [NSUserDefaults standardUserDefaults].address_Ads = [NSString stringWithFormat:@"%@%@",self.addressLabel.text,self.addressDetailTF.text];
        
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"addAddress" object:self];
        
        self.addressModel = [[LRJAddAddressDBModel alloc] init];
        
        self.addressModel.userName = self.nameTF.text;
        self.addressModel.userMobile = self.phoneTF.text;
        self.addressModel.userAddress = self.addressLabel.text;
        self.addressModel.userDetailsAddress = self.addressDetailTF.text;
        
        
        if ([self.title isEqualToString:@"添加地址"]) {
            //插入一条数据
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self.addressModel save];
            });
            
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];

        }else {
        
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self.addressModel update];
            });
///还未实现
            [SVProgressHUD showSuccessWithStatus:@"编辑成功"];
            
        }
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
    }else {
    
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写所有信息" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertV show];
    
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
