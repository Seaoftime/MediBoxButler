//
//  ScanResultViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 15/11/17.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ScanResultViewController.h"

@interface ScanResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *scanImg;
@property (weak, nonatomic) IBOutlet UILabel *labelScanText;
@property (weak, nonatomic) IBOutlet UILabel *labelScanCodeType;
@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"扫描结果";
    [self customNavigationLeftBarItems];
    
    
    
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}



- (void)customNavigationLeftBarItems
{
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 8, 25, 25)];
    
    UIImage *image = [[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgV.image = image;
    
    imgV.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    
    //imgV.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imgV];
    
    self.navigationItem.leftBarButtonItem = item;
    
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    
    [imgV addGestureRecognizer:tap];
    
}



- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}










- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    if (!_imgScan) {
        
        _scanImg.backgroundColor = [UIColor grayColor];
    }

    _scanImg.image = _imgScan;
    _labelScanText.text = _strScan;
    _labelScanCodeType.text = [NSString stringWithFormat:@"码的类型:%@",_strCodeType];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_strScan]]];
    
}


@end
