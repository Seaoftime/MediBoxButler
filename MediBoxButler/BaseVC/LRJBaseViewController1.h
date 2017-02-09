//
//  LRJBaseViewController.h
//  MediBoxButler
//
//  Created by TonySheng on 16/3/31.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRJBaseViewController1 : UIViewController



- (void)customNavigationLeftBarItems;
- (void)customNavigationRightBarItems;
- (void)customNavigationTitleView;

//
- (void)addCustomNavigationItems:(NSArray *)viewItems onLeft:(BOOL)isLeft;



@end
