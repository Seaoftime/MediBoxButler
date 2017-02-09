//
//  GCCreateDatabase.m
//  GongChangSupplier
//
//  Created by sky on 14-6-16.
//  Copyright (c) 2014年 郑州悉知信息技术有限公司. All rights reserved.
//



#import "LRJCreateDatabase.h"



@implementation LRJCreateDatabase{
    
}

- (id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)createDatabase{
    
   
    [self createBaseDataBase];

}

//
- (void)createBaseDataBase
{
    [[[LRJDataBaseManager defaultDBManager] databaseQueue] inDatabase:^(FMDatabase *db) {
        //
        NSString *userAddressSql = @"CREATE TABLE IF NOT EXISTS user_address (user_name VARCHAR(20) PRIMARY KEY NOT NULL, user_telnum VARCHAR(20) NOT NULL, user_address VARCHAR(20) NOT NULL)";
        
        //
        
        BOOL res = [db executeUpdate:userAddressSql];
        
        if (!res) {
            NSLog(@"用户地址表创建失败");
            NSLog(@"%@",db.lastErrorMessage);
        } else {
            NSLog(@"用户地址表创建成功");
        }
    }];


}


@end
