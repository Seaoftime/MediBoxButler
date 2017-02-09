//
//  LRJBaseDatabase.m
//  MediBoxButler
//
//  Created by ZhangRui on 16/6/17.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBaseDatabase.h"

@implementation LRJBaseDatabase


- (void)exBackgroundQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

- (void)exMainQueue:(void (^)())queue {
    dispatch_async(dispatch_get_main_queue(), queue);
}


- (void) executeUpdateSql:(NSString* )sql{
    //    [self exBackgroundQueue:^{
    [[[LRJDataBaseManager defaultDBManager] databaseQueue] inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
        if (db.hadError) {
            NSLog(@"执行sql\n%@",sql);
            NSLog(@"%@",db.lastErrorMessage);
        }
    }];
    //    }];
}




@end
