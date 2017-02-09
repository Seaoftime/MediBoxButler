//
//  NSString+Extension.h
//
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;




//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo;
- (BOOL)isEmail;


@end
