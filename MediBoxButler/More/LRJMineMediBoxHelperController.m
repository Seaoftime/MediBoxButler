//
//  LRJMineMediBoxHelperController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/26.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJMineMediBoxHelperController.h"

#import "LRJUserNameViewController.h"
#import "LRJTelphoneViewController.h"
#import "LRJMyAddressViewController.h"
#import "LRJUserLoginnViewController.h"


@interface LRJMineMediBoxHelperController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL _isNotifi;

}
@property (nonatomic, strong) UITableView *mineMBTV;

@property (nonatomic, strong) UIButton *lgoutBtn;
@property (nonatomic, strong) UIImageView *bgImgV1;
@property (nonatomic, strong) UIImageView *bgImgV2;
@property (nonatomic, strong) UIImageView *bgImgV3;
@property (nonatomic, strong) UIImageView *bgImgV4;
@property (nonatomic, strong) UIButton *userBtn;
@property (nonatomic, strong) UIButton *nameBtn;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UIButton *telphoneBtn;
@property (nonatomic, strong) UIButton *addressBtn;
@property (nonatomic, strong) UIImageView *rightIV1;
@property (nonatomic, strong) UIImageView *rightIV2;
@property (nonatomic, strong) UIImageView *rightIV3;
@property (nonatomic, strong) UIImageView *rightIV4;
@property (nonatomic, strong) UIActionSheet *selectUserIconSheet;

//
@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UILabel *userMobileLb;



@end

@implementation LRJMineMediBoxHelperController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
//    NSString *imgStr = [NSUserDefaults standardUserDefaults].userImageUrl;
//    
//    if ([imgStr isEqualToString:@""]) {
//        _isNotifi = YES;
//    }else {
//    
//        _isNotifi = NO;
//    }
    
    self.navigationItem.title = @"我的药箱助手";
    
    [self.view addSubview:self.mineMBTV];
    self.mineMBTV.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    [self.mineMBTV addSubview:self.bgImgV1];
    [self.mineMBTV addSubview:self.bgImgV2];
    [self.bgImgV1 addSubview:self.userBtn];
    [self.bgImgV1 addSubview:self.userImageView];
    
    [self.bgImgV2 addSubview:self.nameBtn];
    [self.bgImgV2 addSubview:self.telphoneBtn];
    [self.bgImgV2 addSubview:self.addressBtn];
    
    [self.userBtn addSubview:self.rightIV1];
    
    
    [self.nameBtn addSubview:self.rightIV2];
    [self.nameBtn addSubview:self.userNameLb];
    
    [self.telphoneBtn addSubview:self.rightIV3];
    [self.telphoneBtn addSubview:self.userMobileLb];
    
    [self.addressBtn addSubview:self.rightIV4];
    
    [self.mineMBTV addSubview:self.lgoutBtn];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserName:) name:@"changeName" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMobileNum:) name:@"changeMobileNum" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserImageV:) name:@"changeUserImageV" object:nil];
    
}

//
- (void)changeUserName:(NSNotification *)sender {
    
    self.userNameLb.text = sender.userInfo[@"key"];
    
}

- (void)changeMobileNum:(NSNotification *)sender {
    
    self.userMobileLb.text = sender.userInfo[@"key"];
    
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




#pragma mark - UI -
- (UITableView *)mineMBTV
{
    if (_mineMBTV == nil) {
        
        _mineMBTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _mineMBTV.backgroundColor = [UIColor clearColor];
        _mineMBTV.delegate = self;
        _mineMBTV.dataSource = self;
        _mineMBTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_mineMBTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    }
    return _mineMBTV;
}


- (UIImageView *)bgImgV1
{
    if (_bgImgV1 == nil) {
        _bgImgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREENW, 70)];
        _bgImgV1.backgroundColor = [UIColor whiteColor];
        //
        _bgImgV1.userInteractionEnabled = YES;
        
    }
    return _bgImgV1;
}

- (UIImageView *)bgImgV2
{
    if (_bgImgV2 == nil) {
        _bgImgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110, SCREENW, 40 * 3 + 2)];
        _bgImgV2.backgroundColor = [UIColor clearColor];
        //
        _bgImgV2.userInteractionEnabled = YES;
        
    }
    return _bgImgV2;
}

- (UIButton *)userBtn
{
    if (_userBtn == nil) {
        _userBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 70)];
        _userBtn.backgroundColor = [UIColor whiteColor];
        [_userBtn setTitle:@"头像" forState:UIControlStateNormal];
        _userBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _userBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _userBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [_userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_userBtn addTarget:self action:@selector(userIconClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userBtn;
}

- (UIButton *)nameBtn
{
    if (_nameBtn == nil) {
        _nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 40)];
        _nameBtn.backgroundColor = [UIColor whiteColor];
        [_nameBtn setTitle:@"用户名" forState:UIControlStateNormal];
        _nameBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _nameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [_nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_nameBtn addTarget:self action:@selector(userNameClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nameBtn;
}

- (UIButton *)telphoneBtn
{
    if (_telphoneBtn == nil) {
        _telphoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 41, SCREENW, 40)];
        _telphoneBtn.backgroundColor = [UIColor whiteColor];
        [_telphoneBtn setTitle:@"手机号" forState:UIControlStateNormal];
        _telphoneBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _telphoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _telphoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [_telphoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_telphoneBtn addTarget:self action:@selector(telphoneClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _telphoneBtn;
}


- (UILabel *)userMobileLb
{
    if (_userMobileLb == nil) {
        _userMobileLb = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW - 43 - 200, 6, 200, 30)];
        _userMobileLb.text = [NSUserDefaults standardUserDefaults].userMobilNumber;
        //[_userNameLb sizeToFit];
        _userMobileLb.textAlignment = NSTextAlignmentRight;
        
        _userMobileLb.textColor = [UIColor lightGrayColor];
        _userMobileLb.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _userMobileLb;
}



- (UIButton *)addressBtn
{
    if (_addressBtn == nil) {
        _addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 82, SCREENW, 40)];
        _addressBtn.backgroundColor = [UIColor whiteColor];
        [_addressBtn setTitle:@"我的地址" forState:UIControlStateNormal];
        _addressBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [_addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_addressBtn addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressBtn;
}


- (UIImageView *)userImageView
{
    if (_userImageView == nil) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 105, 5, 60, 60)];
        _userImageView.backgroundColor = [UIColor whiteColor];
        _userImageView.layer.cornerRadius = 30;
        //
        _userImageView.layer.borderWidth = 2.0;
        _userImageView.layer.borderColor = [[UIColor colorWithRed:249/255.0 green:239/255.0 blue:91/255.0 alpha:1] CGColor];
        _userImageView.layer.masksToBounds = YES;
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userImageViewTaped)];
        _userImageView.userInteractionEnabled = YES;
        [_userImageView addGestureRecognizer:tap];
        
       
        NSString *imgStr = [NSUserDefaults standardUserDefaults].userImageUrl;
        
        if (imgStr == nil || imgStr == NULL || [imgStr isKindOfClass:[NSNull class]]) {
            
            _userImageView.image = [UIImage imageNamed:@"addimg.jpg"];
            
        }else {
            
            NSData *decodeImgData = [[NSData alloc] initWithBase64EncodedString:imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *userImg = [UIImage imageWithData:decodeImgData];
            
            _userImageView.image = userImg;
            
        }
        
    }
    
    return _userImageView;
}


- (UIImageView *)rightIV1
{
    if (_rightIV1 == nil) {
        _rightIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 28 , 29, 8, 15)];
        _rightIV1.image = [UIImage imageNamed:@"creatReport_detail.png"];
    }
    
    return _rightIV1;
}

- (UILabel *)userNameLb
{
    if (_userNameLb == nil) {
        _userNameLb = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW - 43 - 200, 6, 200, 30)];
        //_funcLabel1.backgroundColor = [UIColor whiteColor];
        //_userNameLb.text = @"路人甲";
        
        
        
        NSString *nameStr = [NSUserDefaults standardUserDefaults].userName;
        
        if (nameStr == nil || nameStr == NULL || [nameStr isKindOfClass:[NSNull class]]) {
            
            
        }else {
            
            _userNameLb.text = nameStr;
        }
        
        
        _userNameLb.textAlignment = NSTextAlignmentRight;
        
        _userNameLb.textColor = [UIColor lightGrayColor];
        _userNameLb.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _userNameLb;
}



- (UIImageView *)rightIV2
{
    if (_rightIV2 == nil) {
        _rightIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 28 , 14, 8, 15)];
        _rightIV2.image = [UIImage imageNamed:@"creatReport_detail.png"];
    }
    
    return _rightIV2;
}

- (UIImageView *)rightIV3
{
    if (_rightIV3 == nil) {
        _rightIV3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 28 , 14, 8, 15)];
        _rightIV3.image = [UIImage imageNamed:@"creatReport_detail.png"];
    }
    
    return _rightIV3;
}

- (UIImageView *)rightIV4
{
    if (_rightIV4 == nil) {
        _rightIV4 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 28 , 14, 8, 15)];
        _rightIV4.image = [UIImage imageNamed:@"creatReport_detail.png"];
    }
    
    return _rightIV4;
}



- (UIButton *)lgoutBtn
{
    if (_lgoutBtn == nil) {
        _lgoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 270, SCREENW, 44)];
        _lgoutBtn.backgroundColor = [UIColor whiteColor];
        [_lgoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _lgoutBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _lgoutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_lgoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_lgoutBtn addTarget:self action:@selector(lgoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lgoutBtn;
}

#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return SCREENH;
}



#pragma mark - event -
- (void)userIconClick
{
    self.selectUserIconSheet =[[UIActionSheet alloc]
                          initWithTitle:Nil
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:Nil
                          otherButtonTitles:@"拍照",@"选择本地图片",nil];
    
    [self.selectUserIconSheet showInView:self.view];
    

}

- (void)userNameClick
{
    LRJUserNameViewController *userNameV = [[LRJUserNameViewController alloc] init];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userNameV animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    
}

- (void)userImageViewTaped
{
    self.selectUserIconSheet =[[UIActionSheet alloc]
                               initWithTitle:Nil
                               delegate:self
                               cancelButtonTitle:@"取消"
                               destructiveButtonTitle:Nil
                               otherButtonTitles:@"拍照",@"选择本地图片",nil];
    
    [self.selectUserIconSheet showInView:self.view];

}

- (void)telphoneClick
{
    LRJTelphoneViewController *userNameV = [[LRJTelphoneViewController alloc] init];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userNameV animated:YES];
    self.hidesBottomBarWhenPushed = YES;

}

- (void)addressClick
{

    LRJMyAddressViewController *userNameV = [[LRJMyAddressViewController alloc] init];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userNameV animated:YES];
    self.hidesBottomBarWhenPushed = YES;

}


#pragma mark -------------------------------退出登录
- (void)lgoutBtnClick
{

    [NSUserDefaults standardUserDefaults].loginSuccessStr = @"lgout";
    [NSUserDefaults standardUserDefaults].userName = @"点击登录";
    
    [SVProgressHUD showSuccessWithStatus:@"已退出!"];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
    
    LRJUserLoginnViewController *login = [[LRJUserLoginnViewController alloc] init];
    
    
     [self presentViewController:login animated:YES completion:nil];
    
    
    
    
    

}



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://拍照
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                //设置拍照后的图片可被编辑
                picker.allowsEditing = YES;
                picker.sourceType = sourceType;
                [self presentViewController:picker animated:YES completion:^{
                    
                }];
            }else
            {
                NSLog(@"模拟其中无法打开照相机,请在真机中使用");
            }
        }
            break;
        case 1://相册
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            //设置选择后的图片可被编辑
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:^{
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                
                
            }];
        }
            break;
        default:
            break;
    }
}
#pragma mark ------- UIImageViewControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *tempImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    //senderImage = [UIImage imageWithData:UIImageJPEGRepresentation(tempImage, .2f) ];
    [SVProgressHUD showSuccessWithStatus:@"设置头像成功"];
    
    //图片转字符串
    NSData *data = UIImageJPEGRepresentation(tempImage, .2f);
    NSString *encodeImgStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [NSUserDefaults standardUserDefaults].userImageUrl = encodeImgStr;
    //
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserImageV" object:nil userInfo:@{@"key":encodeImgStr}];
    
    self.userImageView.image = tempImage;
    
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
