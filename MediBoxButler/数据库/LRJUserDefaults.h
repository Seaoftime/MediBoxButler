//
//  LRJUserDefaults.h
//  
//
//  Created by LRJ on 16-6-2.
//  Copyright (c) 2016 LRJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Additions)

@property (nonatomic, strong, setter = setUserName:, getter = userName) NSString *userName;                                 //用户名
@property (nonatomic, strong, setter = setUser_id:, getter = user_id) NSString *user_id;                                 //用户ID
@property (nonatomic, strong, setter = setPassword:, getter = password) NSString *password;                                 //密码
@property (nonatomic, strong, setter = setUserEmail:, getter = userEmail) NSString *userEmail;                                 //用户的邮箱
@property (nonatomic, strong, setter = setUserMobilNum:, getter = userMobilNumber) NSString *userMobilNumber;                                 //用户手机号码

@property (nonatomic, strong, setter = setUserImageUrl:, getter = userImageUrl) NSString *userImageUrl;                                 //用户头像Url


@property (nonatomic, copy, setter = setLoginSuccessStr:, getter = loginSuccessStr) NSString *loginSuccessStr;//登录成功标记







///地址相关信息
@property (nonatomic, strong, setter = setAddress_Name:, getter = address_Name) NSString *address_Name;
@property (nonatomic, strong, setter = setAddress_Tel:, getter = address_Tel) NSString *address_Tel;
@property (nonatomic, strong, setter = setAddress_Ads:, getter = address_Ads) NSString *address_Ads;


@property (nonatomic, strong, setter = setAll_MoneyStr:, getter = all_MoneyStr) NSString *all_MoneyStr;//订单金额





//@property (nonatomic, strong, setter = setUserLeanCloudID:, getter = leanCloudID) NSString *leanCloudID;                                 //用户leanCloundID

@property (nonatomic, strong, setter=setUserAddress:,getter=userAddress) NSString *userAddress;//用户地址

//@property (nonatomic, strong, setter=setlocationCity:,getter=locationCity)NSString *locationCity;//用户所在城市

//@property (nonatomic, strong, setter=setuser_company:,getter=user_company)NSString *user_company;//用户所在公司


//@property (nonatomic, strong, setter=setuser_department:,getter=user_department)NSString *user_department;//用户部门

//@property (nonatomic, strong, setter=setuser_position:,getter=user_position)NSString *user_position;//用户职位


@property (nonatomic, strong, setter=setuser_sex:,getter=user_sex)NSString *user_sex;//用户性别


@property (assign, nonatomic,setter=setisAllowMobile:,getter=isAllowMobile) BOOL isAllowMobile;



@property (nonatomic, strong, setter = setBadgeNumTime:, getter = badgeNumTime) NSString *badgeNumTime;//角标更新时间
@property (nonatomic, strong, setter = setSToken:, getter = sToken) NSString *sToken;                                       //安全码

@property (nonatomic, strong, setter = setHomeDataDic:, getter = homeDataDic) NSDictionary*homeDataDic;                     //首页数据字典

@property (nonatomic, strong, setter = setPushToken:, getter = pushToken) NSString* pushToken;                     //推送串


@property (nonatomic, strong, setter = setPushInfo:, getter = pushInfo) NSDictionary *pushInfo;            //推送信息


@property (nonatomic, strong, setter = setDatabaseVersion:, getter = databaseVersion) NSString *databaseVersion;            //数据库版本

@property (nonatomic, strong, setter = setUnReatMessageArray:, getter = unReadMessageArray) NSMutableArray *unReadMessageArray;            //未读消息数组


@property (nonatomic, assign, setter = setNewFriendNum:, getter = newFriendNum) NSInteger  newFriendNum;            //新朋友数字

/**
 *  保存一个对象
 *
 *  @param obj obj description
 *  @param key key description
 */
-(void)saveObject:(id)obj forKey:(NSString* )key;
/**
 *  异步保存一个对象
 *
 *  @param obj obj description
 *  @param key key description
 */
-(void)saveObjectInBackground:(id)obj forKey:(NSString* )key;

@end
