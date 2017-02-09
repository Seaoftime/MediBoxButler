//
//  LRJTabBarController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJTabBarController.h"

#import "LRJMoreController.h"
#import "LRJFirstPageController.h"
#import "LRJAPPBaseViewController.h"
#import "LRJOrderController.h"

@interface LRJTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LRJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    [self createTabBarControllers];
    
    [self createLaunchImageAnimation];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
}

//禁止tab多次点击
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIViewController *tbselect=tabBarController.selectedViewController;
    if([tbselect isEqual:viewController]){
        return NO;
    }
    return YES;
}


#pragma mark - 启动动画效果


//自定义的启动动画
- (void)createLaunchImageAnimation {
    //增加一个 程序加载时候的启动动画。下面使我们自己实现的一个 隐藏的动画效果
    UIImageView * startView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    startView.image=[UIImage imageNamed:@"launch.jpg"];
    
    //tabr 的视图上。
    [self.view addSubview:startView];
    
    [UIView animateWithDuration:3 animations:^{
        
        startView.bounds = CGRectMake(startView.bounds.origin.x-80, startView.bounds.origin.y-80, startView.bounds.size.width+80, startView.bounds.size.height+80);
        
    } completion:^(BOOL finished) {
        
        [startView removeFromSuperview];
        
    }];
    
}



- (void)createTabBarControllers {
    
    
    NSArray *vcArray = @[@"LRJFirstPageController",
                         @"LRJOrderController",
                         @"LRJMoreController",
                         ];
    NSArray *titles = @[@"首页", @"订单", @"我的"];
    NSArray *imageArray = @[@[@"iconfont-shouye@3x", @"iconfont-shouye@3x"],
                            @[@"iconfont-dingdan@3x", @"iconfont-dingdan@3x"],
                            @[@"iconfont-wode@3x", @"iconfont-wode@3x"],
                            ];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < vcArray.count; i++) {
        
        
        Class cls = NSClassFromString(vcArray[i]);
        
        LRJAPPBaseViewController *bvc = [[cls alloc] init];
        
        UIImage *normalImage = [[UIImage imageNamed:imageArray[i][0]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //1.
        UIImage *selectImage = [[UIImage imageNamed:imageArray[i][1]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:normalImage selectedImage:selectImage];
        
        
        
        bvc.tabBarItem = item;
        
        //改变tabbaritem 未选中时的颜色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        
        //选中时
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:bvc];
        
        bvc.tabBarItem.title = titles[i];
        
        
        //设置tabbar背景色
        UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        [self.tabBar insertSubview:bgView atIndex:0];
        self.tabBar.opaque = YES;
        
        //设置tabbaritem选择颜色
        //2.
        self.tabBar.tintColor = [UIColor whiteColor];
        //3.
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor]
                                                            } forState:UIControlStateSelected];

        
        [controllers addObject:navController];
        
    }
    
    self.viewControllers = controllers;
    
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
