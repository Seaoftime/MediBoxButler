//
//  LRJCustomerLoginModel.h
//  MediBoxButler
//
//  Created by ZhongMeng on 16/10/11.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "JKDBModel.h"

@interface LRJCustomerLoginModel : JKDBModel



@property(nonatomic, copy) NSString *login_userName;//用户名
@property(nonatomic, copy) NSString *login_userMobile;//手机号

@property(nonatomic, copy) NSString *login_userPassword;//用户密码

@property(nonatomic, copy) NSString *login_userAddress;//用户地址



@end
