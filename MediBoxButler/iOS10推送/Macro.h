//
//  Macro.h
//  MediBoxButler
//
//  Created by ZhongMeng on 16/10/18.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//


#ifndef Macro_h
#define Macro_h

#define MInterfaceSharedInstance(methodName) \
+ (instancetype)methodName;

#define MImplementeSharedInstance(methodName)  \
+ (instancetype)methodName{ \
    static dispatch_once_t onceToken; \
    static id instance; \
    dispatch_once(&onceToken, ^{ \
    instance = [[[self class] alloc] init]; \
    }); \
    return instance; \
} \



#endif /* Macro_h */
