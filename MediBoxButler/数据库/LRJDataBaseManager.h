//
//  LRJDataBaseManager.h
//  
//
//  Created by sky on 16-6-11.
//  Copyright (c) 2016年 LRJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
//#import "FMDatabaseAdditions.h"

/**
 * @brief 对数据链接进行管理，包括链接，关闭连接
 * 可以建立长连接 长连接
 */


@interface LRJDataBaseManager : NSObject

- (int)initializeDBWithName : (NSString *) name;
// 数据库操作对象，当数据库被建立时，会存在次至
//@property (nonatomic, readonly) FMDatabase * dataBase;  // 数据库操作对象
@property (nonatomic, strong)   FMDatabaseQueue* databaseQueue;
@property (nonatomic, copy)     NSString* dataBasePath;

// 单例模式
+(LRJDataBaseManager *) defaultDBManager;

// 关闭数据库
- (void) close;
@end

