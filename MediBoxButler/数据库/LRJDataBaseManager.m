//
//  LRJDataBaseManager.m
//
//
//  Created by sky on 16-6-11.
//  Copyright (c) 2016年 LRJ. All rights reserved.
//

#import "LRJDataBaseManager.h"

#define DBPATH @"MediBoxButler"

@implementation LRJDataBaseManager


static LRJDataBaseManager * _sharedDBmanager;

+ (LRJDataBaseManager *) defaultDBManager{
    if (!_sharedDBmanager) {
        _sharedDBmanager = [[LRJDataBaseManager alloc]init];
    }
    return _sharedDBmanager;
}

- (void) dealloc{
    [self close];
}



- (id) init {
    self = [super init];
    if (self) {
        
        /**
         *  V1.0 数据库名字   ---  用户名  .sqlite
         */
        
        int state = [self initializeDBWithName:[NSString stringWithFormat:@"%@.sqlite",DBPATH]];
        
        if (state == -1) {
            NSLog(@"数据库初始化失败");
        } else {
            NSLog(@"数据库初始化成功");
        }
        
    }
    return self;
}

/**
 * @brief 初始化数据库操作
 * @param name 数据库名称
 * @return 返回数据库初始化状态， 0 为 已经存在，1 为创建成功，-1 为创建失败
 */

- (int)initializeDBWithName : (NSString *) name {
    if (!name) {
		return -1;  // 返回数据库创建失败
	}
    // 沙盒Docu目录
    NSString * docp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"docp%@",docp);
	self.dataBasePath = [docp stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    
    NSLog(@"%@",self.dataBasePath);
    
    self.databaseQueue      =   [[FMDatabaseQueue alloc] initWithPath:_dataBasePath];
    
	NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:_dataBasePath];
////    [self connect];
    if (!exist) {
        return 0;
    } else {
        return 1;          // 返回 数据库已经存在
	}
    
}

/// 关闭连接
- (void) close {
    [_databaseQueue close];
    _sharedDBmanager = nil;
    NSLog(@"已关闭");
}


@end
