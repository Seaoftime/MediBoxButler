//
//  GetSmsCodeBtn.m
//
//
//  Created by rui zhang on 15/12/10.
//  Copyright © 2015年 rui zhang. All rights reserved.
//
typedef enum : NSUInteger {
    btn_state_nomal,
    btn_state_reget,
    btn_state_getting,
} btn_state;
#import "GetSmsCodeBtn.h"

@interface GetSmsCodeBtn ()
{
    NSString * (^ _block)();
    BOOL _neverGetSmsNum;
    NSString * _phoneNum;
}

@end

@implementation GetSmsCodeBtn

- (instancetype)initWithFrame:(CGRect)frame btnCheckAndGetPhoneNumBlock:(NSString * (^)())block{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setTitleColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addTarget:self action:@selector(getSmsNum) forControlEvents:UIControlEventTouchUpInside];
        _block = [block copy];
        if ([GetSmsCodeBtnTimer shareManager].mBtnCanClickTime > 0) {
            self.enabled = NO;
            NSString * title = [NSString stringWithFormat:@"%lds重新获取",(long)[GetSmsCodeBtnTimer shareManager].mBtnCanClickTime];
            [self setTitle:title forState:UIControlStateDisabled];
            
            
        }
        [[GetSmsCodeBtnTimer shareManager] addObserver:self forKeyPath:@"mBtnCanClickTime" options:NSKeyValueObservingOptionNew context:nil];
        _neverGetSmsNum = YES;
    }
    return self;
}

- (void)getSmsNum{
    _neverGetSmsNum = NO;
    _phoneNum = _block();
    if (_phoneNum) {
        [[GetSmsCodeBtnTimer shareManager] beginWithTime:60];
        [self getSmsCode];
    }
}

//获取短信验证码
- (void)getSmsCode{
    
//    [[DHFNetwork_SessionManager shareManager] POSTToPath:kDHF_URL_GET_VERIFY_CODE parameters:@{@"mobile":_phoneNum} success:^(id responseObject) {
//        [NetworkUtils getSuccessDataInfoFromDic:responseObject];
//        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码获取成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//    } failure:^(NSError *error) {
//        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//    }];
    
    [SVProgressHUD  showWithStatus:@"模拟数据,验证码这步可以忽略,直接点击确定"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSInteger newNum = [[change objectForKey:@"new"] integerValue];
    NSLog(@"%ld",(long)newNum);
    if (newNum>0) {
        [self setBtnWithState:btn_state_getting];
    }else{
        if (_neverGetSmsNum) {
            [self setBtnWithState:btn_state_nomal];
        }else{
            [self setBtnWithState:btn_state_reget];
        }
    }
}

- (void)setBtnWithState:(btn_state)state{
    switch (state) {
        case btn_state_nomal:{
            [self setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.enabled = YES;
        }
            break;
        case btn_state_reget:{
            [self setTitle:@"重新获取" forState:UIControlStateNormal];
            self.enabled = YES;
        }
            break;
        case btn_state_getting:{
            self.enabled = NO;
            NSString * title = [NSString stringWithFormat:@"%lds重新获取",(long)[GetSmsCodeBtnTimer shareManager].mBtnCanClickTime];
            [self setTitle:title forState:UIControlStateDisabled];
        }
            break;
        default:
            break;
    }
}

- (void)dealloc{
    [[GetSmsCodeBtnTimer shareManager] removeObserver:self forKeyPath:@"mBtnCanClickTime"];
    _block = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@interface GetSmsCodeBtnTimer ()
{
    NSTimer * _timer;
}
@end

@implementation GetSmsCodeBtnTimer

+ (instancetype)shareManager{
    static GetSmsCodeBtnTimer * timerManager = nil;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        timerManager = [[GetSmsCodeBtnTimer alloc] init];
    });
    return timerManager;
}

- (void)beginWithTime:(NSInteger)time{
    self.mBtnCanClickTime = time;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setNewTimeString) userInfo:nil repeats:YES];
}

- (void)setNewTimeString{
    if (self.mBtnCanClickTime>0) {
         self.mBtnCanClickTime -= 1;
    }else{
        [_timer invalidate];
    }
}
- (void)endAndClear{
    [_timer invalidate];
    self.mBtnCanClickTime = 0;
}

@end