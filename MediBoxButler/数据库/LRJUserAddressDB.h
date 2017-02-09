//
//  LRJUserAddressDB.h
//  MediBoxButler
//
//  Created by ZhangRui on 16/6/17.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBaseDatabase.h"

#import "LRJAddressModel.h"

@interface LRJUserAddressDB : LRJBaseDatabase

+ (instancetype)sharedInstance;

//保存一条地址信息
- (void)saveAddress:(LRJAddressModel *)address;




@end
