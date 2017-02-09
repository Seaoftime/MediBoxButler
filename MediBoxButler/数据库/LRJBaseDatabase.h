//
//  LRJBaseDatabase.h
//  MediBoxButler
//
//  Created by ZhangRui on 16/6/17.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LRJDataBaseManager.h"

typedef void (^sucDic)(id sucDic);
typedef void (^errorBlock)(id error);


@interface LRJBaseDatabase : NSObject



- (void) exBackgroundQueue:(void (^)())queue;

- (void) exMainQueue:(void (^)())queue;

- (void) executeUpdateSql:(NSString* )sql;



@end
