//
//  LRJBaseViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBaseViewController.h"

@interface LRJBaseViewController ()

@end

@implementation LRJBaseViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    //
    //设置字体和字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //
    //self.navigationController.navigationItem.
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigationTitleView];
    
    
}


- (void)customNavigationTitleView
{
    
    
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
