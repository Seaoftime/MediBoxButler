//
//  LRJDataBaseManager.h
//
//
//  Created by sky on 16-6-11.
//  Copyright (c) 2016年 LRJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRJDataBaseManager.h"

@interface  LRJCreateDatabase: NSObject
{
    FMDatabase * _db;
}

-(void)createDatabase;

@end
