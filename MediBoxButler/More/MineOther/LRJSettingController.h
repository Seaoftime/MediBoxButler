//
//  LRJSettingController.h
//  MediBoxButler
//
//  Created by TonySheng on 16/4/6.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRJSettingController : UIViewController


- (void)customNavigationLeftBarItems;
- (void)customNavigationRightBarItems;
- (void)customNavigationTitleView;

//
- (void)addCustomNavigationItems:(NSArray *)viewItems onLeft:(BOOL)isLeft;



@end
