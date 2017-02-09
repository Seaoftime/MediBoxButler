//
//  LRJAPPBaseViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJAPPBaseViewController.h"

@interface LRJAPPBaseViewController ()

@end

@implementation LRJAPPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
    //[self addNavgationTitleWithTitle:self.title];
    
}



- (void)addNavgationTitleWithTitle:(NSString *)title {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithRed:97/255.0 green:179/255.0 blue:6/255.0 alpha:1.0];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
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
