//
//  LRJSettingController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/6.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJSettingController.h"

#import "AddressViewController.h"
#import "FavoriteViewController.h"

@interface LRJSettingController ()


@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *bgImageV1;
@property (nonatomic, strong) UIImageView *bgImageV2;
//
@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) UIButton *favourButton;
@property (nonatomic, strong) UIImageView *rightIV1;
@property (nonatomic, strong) UIImageView *rightIV2;


@end

@implementation LRJSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    
    self.title = @"设置";
    
    [self customNavigationLeftBarItems];
    [self customNavigationRightBarItems];
    [self customNavigationTitleView];

    
    [self.view addSubview:self.bgImageV1];
    [self.bgImageV1 addSubview:self.addressButton];
    [self.bgImageV1 addSubview:self.rightIV1];
    
    
    
    //
    [self.view addSubview:self.bgImageV2];
    [self.bgImageV2 addSubview:self.favourButton];
    [self.bgImageV2 addSubview:self.rightIV2];
    
    
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

}


- (void)customNavigationTitleView
{


}


- (void)addCustomNavigationItems:(NSArray *)viewItems onLeft:(BOOL)isLeft
{



}


- (UIImageView *)bgImageV1
{
    if (_bgImageV1 == nil) {
        _bgImageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREENW, 50)];
        _bgImageV1.backgroundColor = [UIColor whiteColor];
        
       
        //
        _bgImageV1.userInteractionEnabled = YES;
        
    }
    return _bgImageV1;
}


- (UIButton *)addressButton
{
    if (_addressButton == nil) {
        _addressButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENW - 50, 50)];
        _addressButton.backgroundColor = [UIColor whiteColor];
        [_addressButton setTitle:@"我的地址" forState:UIControlStateNormal];
        _addressButton.titleLabel.font = [UIFont systemFontOfSize:16];
        //_replyButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _addressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _addressButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        
        [_addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        [_addressButton addTarget:self action:@selector(addressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressButton;
}

- (UIImageView *)rightIV1
{
    if (_rightIV1 == nil) {
        _rightIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 20 , 19, 8, 15)];
        //_rightIV1.backgroundColor = [UIColor grayColor];
        _rightIV1.image = [UIImage imageNamed:@"creatReport_detail.png"];
    }
    
    return _rightIV1;

}

- (UIImageView *)bgImageV2
{
    if (_bgImageV2 == nil) {
        _bgImageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 170, SCREENW, 50)];
        _bgImageV2.backgroundColor = [UIColor whiteColor];
        
        
        //
        _bgImageV2.userInteractionEnabled = YES;
        
    }
    return _bgImageV2;
}

- (UIButton *)favourButton
{
    if (_favourButton == nil) {
        _favourButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENW - 50, 50)];
        _favourButton.backgroundColor = [UIColor whiteColor];
        [_favourButton setTitle:@"我的收藏" forState:UIControlStateNormal];
        _favourButton.titleLabel.font = [UIFont systemFontOfSize:16];
        //_replyButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _favourButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _favourButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        
        [_favourButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        [_favourButton addTarget:self action:@selector(favourButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favourButton;
}

- (UIImageView *)rightIV2
{
    if (_rightIV2 == nil) {
        _rightIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW - 20 , 19, 8, 15)];
        //_rightIV1.backgroundColor = [UIColor grayColor];
        _rightIV2.image = [UIImage imageNamed:@"creatReport_detail.png"];
    }
    
    return _rightIV2;
    
}



#pragma mark - event -

- (void)backk
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self pop];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addressButtonClick
{

    AddressViewController *addressVC = [[AddressViewController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];

}



- (void)favourButtonClick
{

    FavoriteViewController *favorVC = [[FavoriteViewController alloc] init];
    [self.navigationController pushViewController:favorVC animated:YES];


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
