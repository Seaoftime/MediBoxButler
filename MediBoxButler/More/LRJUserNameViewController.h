//
//  LRJUserNameViewController.h
//  MediBoxButler
//
//  Created by TonySheng on 16/4/27.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBaseViewController3.h"


typedef void(^ChangeUserInfoBlock) (NSString *str);

@interface LRJUserNameViewController : LRJBaseViewController3

@property (nonatomic, copy) ChangeUserInfoBlock changeUserNameBlock;

@end
