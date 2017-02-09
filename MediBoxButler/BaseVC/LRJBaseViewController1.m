//
//  LRJBaseViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/31.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBaseViewController1.h"


#import "SubLBXScanViewController.h"
#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "ScanResultViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"

#import "LRJSearchViewController.h"

#import "CCLocationManager.h"
#import "LRJMapViewController.h"

#import "LRJChooseCityyViewController.h"

#define LOCATION_CITY @"定位中"

@interface LRJBaseViewController1 ()<CLLocationManagerDelegate>{
    CLLocationManager *locationmanager;
    
}



@property (nonatomic, strong) UIImageView *imgV;


@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UIView *bgV;
@property (nonatomic, strong) UIImageView *leftImgV;
@property (nonatomic, strong) UIImageView *downImgV;


@end

@implementation LRJBaseViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    [self customNavigationLeftBarItems];
    [self customNavigationRightBarItems];
    [self customNavigationTitleView];
    
    if (IS_IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locationmanager = [[CLLocationManager alloc] init];
        [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locationmanager.delegate = self;
    }
    //
    [self getCity];
}



-(void)getCity
{
    __block __weak LRJBaseViewController1 *wself = self;
    
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation] getCity:^(NSString *cityString) {
            NSLog(@"%@",cityString);
            
            
            [wself setLabelText:cityString];
            
        }];
        
    }
    
}


-(void)setLabelText:(NSString *)text
{
    NSLog(@"text %@",text);
    _cityLabel.text = [text substringToIndex:2];
    [_cityLabel sizeToFit];
}




- (void)dealloc
{
    //[_imgV removeFromSuperview];


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //[_imgV removeFromSuperview];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    /**
     *  navigationbar 颜色
     */
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //
    //设置字体和字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}



#pragma mark - UI -
- (void)customNavigationLeftBarItems
{
    self.bgV = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    self.bgV.backgroundColor = [UIColor whiteColor];
    
    self.leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, -5, 25, 30)];
    self.leftImgV.image = [UIImage imageNamed:@"logo_meitu_1"];
    
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 40, 20)];
    self.cityLabel.textColor = [UIColor blackColor];
    self.cityLabel.font = [UIFont systemFontOfSize:11];
    self.cityLabel.text = @"定位中";
    [self.cityLabel sizeToFit];
    
    self.downImgV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 23, 15, 20)];
    self.downImgV.image = [UIImage imageNamed:@"下"];
    self.downImgV.userInteractionEnabled = YES;
    
    [self.bgV addSubview:self.leftImgV];
    [self.bgV addSubview:self.cityLabel];
    [self.bgV addSubview:self.downImgV];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.bgV];
    
    self.navigationItem.leftBarButtonItem = item;
    
    self.bgV.userInteractionEnabled = YES;
    self.leftImgV.userInteractionEnabled = YES;
    self.cityLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityLabelClicked)];
    //[self.cityLabel addGestureRecognizer:tap11];
    [self.bgV addGestureRecognizer:tap11];
    //[self.leftImgV addGestureRecognizer:tap11];
    //[self.downImgV addGestureRecognizer:tap11];

    //self.cityLabel.text = LOCATION_CITY;
    
    
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem LeftBarButtonItemWithImageName:@"icon-1460176168099" highImageName:nil title:self.cityLabel.text target:self action:@selector(leftClicked)];
    
    
}

- (void)customNavigationRightBarItems
{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"right_menu_QR@3x" highImageName:nil title:@"扫一扫" target:self action:@selector(rightClicked)];
    
}


- (void)customNavigationTitleView
{
    //_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW/2 - 80, 5, 160, 28)];
    
    _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 240, 30)];
    
    _imgV.image = [UIImage imageNamed:@"HomePageSH_searchBack_bg@2x"];
    
    _imgV.layer.borderWidth = 0.5;
    _imgV.layer.borderColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0].CGColor;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, 140, 28)];
    //label.center = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    
    
    label.text = @"请输入搜索关键字";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:13];
    [_imgV addSubview:label];
    
    self.navigationItem.titleView = _imgV;
    //[self.navigationController.navigationBar addSubview:_imgV];
    
    //
    _imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarClicked)];
    [_imgV addGestureRecognizer:tap];
    
}

- (void)addCustomNavigationItems:(NSArray *)viewItems onLeft:(BOOL)isLeft
{
    NSMutableArray *barButtonItemAry = [NSMutableArray array];
    for (UIView *view in viewItems) {
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        //view  -->UIBarButtonItem
        
        [barButtonItemAry addObject:barItem];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = barButtonItemAry;
    }else{
        
        self.navigationItem.rightBarButtonItems = barButtonItemAry;
        
    }
}



#pragma mark - event -

- (void)searchBarClicked
{
    LRJSearchViewController *search = [[LRJSearchViewController alloc] init];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    [self.navigationController pushViewController:search animated:YES];

}

- (void)leftClicked
{



}

- (void)cityLabelClicked
{
    LRJMapViewController *mapVC = [[LRJMapViewController alloc] init];
    
//    self.navigationController.navigationBarHidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:mapVC animated:YES];
//    
//    self.hidesBottomBarWhenPushed = NO;
    
    
    //LRJChooseCityyViewController *chooseCity = [[LRJChooseCityyViewController alloc] init];
    
    //[self.navigationController pushViewController:chooseCity animated:YES];
    //[self presentViewController:chooseCity animated:YES completion:nil];

    [self presentViewController:mapVC animated:YES completion:nil];

}


#pragma mark - QQ 界面 -
- (void)rightClicked
{
    
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc] init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 15;//20
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 15;//20
    
    
    //
    style.colorAngle = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    //UIImage *image = [[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImage *img = [UIImage imageWithColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0]];
    
    
    //style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_Scan_weixin_Line"];
    
    style.animationImage = img;
    
    
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom =  NO;//距离缩放
    
    
     self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];

    //
    //[self.navigationController :YES];
    
    self.hidesBottomBarWhenPushed = NO;



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
