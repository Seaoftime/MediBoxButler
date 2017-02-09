//
//  LRJBaseViewController3.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/26.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBaseViewController3.h"

@interface LRJBaseViewController3 ()

@end

@implementation LRJBaseViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self customNavigationLeftBarItems];

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




- (void)backk
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self pop];
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
