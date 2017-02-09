//
//  LRJUserAddressDB.m
//  MediBoxButler
//
//  Created by ZhangRui on 16/6/17.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJUserAddressDB.h"

#import "LRJDataBaseManager.h"

@implementation LRJUserAddressDB


+(instancetype)sharedInstance {
    static LRJUserAddressDB *addressDB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        addressDB = [[LRJUserAddressDB alloc]init];
    });
    return addressDB;
}



- (void)saveAddress:(LRJAddressModel *)address
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[[LRJDataBaseManager defaultDBManager] databaseQueue] inDatabase:^(FMDatabase *db) {
            
            NSMutableString * query    = [NSMutableString stringWithFormat:@"INSERT INTO user_address"];
            NSMutableString * keys     = [NSMutableString stringWithFormat:@" ("];
            NSMutableString * values   = [NSMutableString stringWithFormat:@" ("];
            NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:30];
            
            [keys appendString:@"user_name,user_telnum,user_address,"];
            [values appendString:@"?,?,?,"];
            [arguments addObjectsFromArray:@[address.name,address.telnum,address.address]];
            if (address.name) {
                [keys appendString:@"user_name,"];
                [values appendString:@"?,"];
                [arguments addObject:address.name];
            }
            if (address.telnum) {
                [keys appendString:@"user_telnum,"];
                [values appendString:@"?,"];
                [arguments addObject:address.telnum];
            }
            if (address.address) {
                [keys appendString:@"user_address,"];
                [values appendString:@"?,"];
                [arguments addObject:address.address];
            }
        
            [keys appendString:@")"];
            [values appendString:@")"];
            [query appendFormat:@" %@ VALUES%@",[keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],[values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
            NSLog(@"成功插入一条地址。。。。。。");
            [db executeUpdate:query withArgumentsInArray:arguments];
            NSLog(@"%@",[db lastError]);
            
        }];
    });
    
}




@end
