//
//  GetSmsCodeBtn.h
//  
//
//  Created by rui zhang on 15/12/10.
//  Copyright © 2015年 rui zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetSmsCodeBtnTimer : NSObject
@property (nonatomic, assign) NSInteger mBtnCanClickTime;

+ (instancetype)shareManager;
- (void)beginWithTime:(NSInteger)time;
- (void)endAndClear;
@end

@interface GetSmsCodeBtn : UIButton
- (instancetype)initWithFrame:(CGRect)frame btnCheckAndGetPhoneNumBlock:(NSString * (^)())block;
@end
