//
//  LRJBaseViewController2.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/7.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBaseViewController2.h"

@interface LRJBaseViewController2 ()

@end

@implementation LRJBaseViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    //设置字体和字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //
    [self customNavigationLeftBarItems];
    
    
}



- (void)customNavigationLeftBarItems
{
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 8, 25, 25)];
    
    UIImage *image = [[UIImage imageNamed:@"iconfont-fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgV.image = image;
    
    //imgV.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    imgV.tintColor = [UIColor whiteColor];
    
    
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
