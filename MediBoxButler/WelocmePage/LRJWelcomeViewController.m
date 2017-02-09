//
//  LRJWelcomeViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJWelcomeViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LRJWelcomeViewController ()

@end

@implementation LRJWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UIImage *image = [UIImage imageNamed:@"launch.jpg"];
    imageView.image = image;
    
    [self.view addSubview:imageView];
    
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
