//
//  LRJUserNotificationModdel.h
//  MediBoxButler
//
//  Created by ZhongMeng on 16/10/19.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "JKDBModel.h"


//iOS10 推送模型
@interface LRJUserNotificationModdel : JKDBModel


@property(nonatomic, copy) NSString *nofi_title;// 标题

@property(nonatomic, copy) NSString *nofi_subtitle;//子标题

@property(nonatomic, copy) NSString *nofi_body;//内容

@property(nonatomic, copy) NSString *nofi_data;//时间


@end
