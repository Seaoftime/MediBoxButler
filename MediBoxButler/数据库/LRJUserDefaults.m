//
//  LRJUserDefaults.m
//
//
//  Created by LRJ on 16-6-2.
//  Copyright (c) 2016 LRJ. All rights reserved.
//

#import "LRJUserDefaults.h"

NSString* const defaultsPassword            = @"password";
NSString* const defaultsUserName            = @"userName";
NSString* const defaultsUserTrueName        = @"userTrueName";
NSString* const defaultsUserID              = @"userID-test";
NSString* const defaultsUserEmail           = @"userEmail";
NSString* const defaultsUserPhoneNum        = @"userPhoneNum";
NSString* const defaultsLeanCloudID         = @"leanCloudID-test";
NSString* const defaultBadgeNumTime         = @"badgeNumtime";
NSString* const defaultsSToken              = @"sToken-test";
NSString* const defaultsHomeDataDic         = @"homeDataDic";
NSString* const defaultUserImageUrl         = @"userImageUrl";
NSString* const defaultsPushInfo            = @"pushInfo";
NSString* const defaultsPushToken           = @"pushToken";
NSString* const defaultsDatabaseVersion     = @"databaseVersion";
NSString* const defaultsUnReadMessageArray  = @"unReadMessageArray";
NSString* const defaultsUserAddress         = @"userAddress";

///
NSString* const defaultsAddress_Name         = @"address_Name";
NSString* const defaultsAddress_Tel         = @"address_Tel";
NSString* const defaultsAddress_Ads         = @"address_Ads";



//NSString* const defaultslocationCity        = @"locationCity";
//NSString* const defaultsCompany             = @"user_company";
//NSString* const defaultsPosition            = @"user_positon";
//NSString* const defaultsDepartment          = @"user_department";
NSString* const defaultsUserSex             = @"user_sex";
NSString* const defaultsUserIsAllowMobile   =
    @"user_isAllowMobiel";
NSString* const defaultsUserNewfriendNum    = @"user_NewfriendsNum";

NSString* const defaultsAll_MoneyStr    = @"all_MoneyStr";

NSString* const defaultsLoginSuccessStr    = @"loginSuccessStr";



@implementation NSUserDefaults (Additions)

/*------------ 以下是登陆所需的信息 -------------*/


#pragma mark - userName

- (void)setUserName:(NSString *)userName
{
    [self setObject:userName forKey:defaultsUserName];
    [self synchronize];
}

- (NSString *)userName
{
    return [self stringForKey:defaultsUserName];
    
}
#pragma mark - userTrueName
- (void)setUserTureName:(NSString *)userTrueName
{
    [self setObject:userTrueName forKey:defaultsUserTrueName];
    [self synchronize];
}

- (NSString *)userTrueName
{
    return [self stringForKey:defaultsUserTrueName];
    
}

#pragma mark - userID

- (void)setUser_id:(NSString *)user_id
{
    [self setObject:user_id forKey:defaultsUserID];
    [self synchronize];
}

- (NSString *)user_id
{
    return [self stringForKey:defaultsUserID];
    
}
//#pragma mark - leanCloudID
//
//- (void)setUserLeanCloudID:(NSString *)leanCloudID
//{
//    [self setObject:leanCloudID forKey:defaultsLeanCloudID];
//    [self synchronize];
//}
//
//- (NSString *)leanCloudID
//{
//    return [self stringForKey:defaultsLeanCloudID];
//    
//}

#pragma mark - userImageUrl

- (void)setUserImageUrl:(NSString *)userImageUrl
{
    [self setObject:userImageUrl forKey:defaultUserImageUrl];
    [self synchronize];
}

- (NSString *)userImageUrl
{
    return [self stringForKey:defaultUserImageUrl];
    
}

#pragma mark -- userAddress

- (void)setUserAddress:(NSString *)userAddress
{
    [self setObject:userAddress forKey:defaultsUserAddress];

    [self synchronize];


}

- (NSString *)userAddress
{
    return [self stringForKey:defaultsUserAddress];
}


///
- (void)setAddress_Name:(NSString *)address_Name
{
    [self setObject:address_Name forKey:defaultsAddress_Name];
    
    [self synchronize];

}

- (NSString *)address_Name
{

    return [self stringForKey:defaultsAddress_Name];
}


- (void)setAddress_Tel:(NSString *)address_Tel
{
    [self setObject:address_Tel forKey:defaultsAddress_Tel];
    
    [self synchronize];

}

- (NSString *)address_Tel
{
    return [self stringForKey:defaultsAddress_Tel];
    
}

- (void)setAddress_Ads:(NSString *)address_Ads
{
    [self setObject:address_Ads forKey:defaultsAddress_Ads];
    
    [self synchronize];
    
}

- (NSString *)address_Ads
{
    return [self stringForKey:defaultsAddress_Ads];
    
}




- (void)setAll_MoneyStr:(NSString *)all_MoneyStr
{

    [self setObject:all_MoneyStr forKey:defaultsAll_MoneyStr];

    [self synchronize];

}


- (NSString *)all_MoneyStr
{

    return [self stringForKey:defaultsAll_MoneyStr];

}


- (void)setLoginSuccessStr:(NSString *)loginSuccessStr
{

    [self setObject:loginSuccessStr forKey:defaultsLoginSuccessStr];
    
    [self synchronize];

}


- (NSString *)loginSuccessStr
{

     return [self stringForKey:defaultsLoginSuccessStr];
}





//#pragma mark -- locationCity
//
//- (void)setlocationCity:(NSString *)locationCity
//{
//    [self setObject:locationCity forKey:defaultslocationCity];
//    
//    [self synchronize];
//}
//- (NSString *)locationCity
//{
//    return [self stringForKey:defaultslocationCity];
//}


#pragma mark - userEmail

- (void)setUserEmail:(NSString *)userEmail
{
    [self setObject:userEmail forKey:defaultsUserEmail];
    [self synchronize];
}

- (NSString *)userEmail
{
    return [self stringForKey:defaultsUserEmail];
    
}
//#pragma mark -- Company
//
//- (void)setuser_company:(NSString *)user_company
//{
//    [self setObject:user_company forKey:defaultsCompany];
//    
//    [self synchronize];
//}
//- (NSString *)user_company
//{
//    return [self stringForKey:defaultsCompany];
//}


//#pragma mark ---- postion
//
//- (void)setuser_position:(NSString *)user_position
//{
//    [self setObject:user_position forKey:defaultsPosition];
//    
//    [self synchronize];
//
//}
//- (NSString *)user_position
//{
//    return [self stringForKey:defaultsPosition];
//}


//#pragma mark ---- department
//
//- (void)setuser_department:(NSString *)user_department
//{
//    [self setObject:user_department forKey:defaultsDepartment];
//    
//    [self synchronize];
//
//}
//- (NSString *)user_department
//{
//    return [self stringForKey:defaultsDepartment];
//}



#pragma mark -- sex

- (void)setuser_sex:(NSString *)user_sex
{
    [self setObject:user_sex forKey:defaultsUserSex];
    
    [self synchronize];
    
}
- (NSString *)user_sex
{
    return [self stringForKey:defaultsUserSex];
}

#pragma mark - userPhoneNum

- (void)setUserMobilNum:(NSString *)userMobilNumber
{
    [self setObject:userMobilNumber forKey:defaultsUserPhoneNum];
    [self synchronize];
}

- (NSString *)userMobilNumber
{
    return [self stringForKey:defaultsUserPhoneNum];
    
}

#pragma mark -- ISAllowMobile

- (void)setisAllowMobile:(BOOL)isAllowMobile
{
    [self setBool:isAllowMobile forKey:defaultsUserIsAllowMobile];
    
    [self synchronize];

}
- (BOOL)isAllowMobile
{
    return [self boolForKey:defaultsUserIsAllowMobile];
}

#pragma mark -- newFriendsNum

- (void)setNewFriendNum:(NSInteger)newFriendNums
{
    [self setInteger:newFriendNums forKey:defaultsUserNewfriendNum];
    
    [self synchronize];
    
}
- (NSInteger )newFriendNum
{
    return [self integerForKey:defaultsUserNewfriendNum];
}



#pragma mark - badgeNumTime

- (void)setBadgeNumTime:(NSString *)badgeNumTime
{
    [self setObject:badgeNumTime forKey:defaultBadgeNumTime];
    [self synchronize];
}

- (NSString *)badgeNumTime
{
    
    return [self stringForKey:defaultBadgeNumTime];
    
}

#pragma mark - sToken

- (void)setSToken:(NSString *)sToken
{
    [self setObject:sToken forKey:defaultsSToken];
    [self synchronize];
}

- (NSString *)sToken
{
    return [self stringForKey:defaultsSToken];
    
}


#pragma mark - password

- (void)setPassword:(NSString *)password
{
    [self setObject:password forKey:defaultsPassword];
    [self synchronize];
}

- (NSString *)password
{
    return [self stringForKey:defaultsPassword];
    
}




#pragma mark - homeDataDic

- (void)setHomeDataDic:(NSDictionary *)homeDataDic
{
//    NSLog(@"%@",homeDataDic);
    [self setObject:homeDataDic forKey:[defaultsHomeDataDic stringByAppendingFormat:@"%@",self.user_id]];
    [self synchronize];
}

- (NSDictionary *)homeDataDic
{
    return [self dictionaryForKey:[defaultsHomeDataDic stringByAppendingFormat:@"%@",self.user_id]];
    
}



- (void)setPushInfo:(NSDictionary *)pushInfo
{
    [self setObject:pushInfo forKey:[defaultsPushInfo stringByAppendingFormat:@"%@",self.user_id]];
    [self synchronize];
}

- (NSDictionary *)pushInfo
{
    return [self objectForKey:[defaultsPushInfo stringByAppendingFormat:@"%@",self.user_id]];
    
}


#pragma mark - pushToken
- (void)setPushToken:(NSString *)pushToken
{
    [self setObject:pushToken forKey:defaultsPushToken];
    [self synchronize];
}

- (NSString *)pushToken
{
    return [self stringForKey:defaultsPushToken];
    
}


#pragma mark - databaseVersion
- (void)setDatabaseVersion:(NSString *)databaseVersion
{
    [self setObject:databaseVersion forKey:[defaultsDatabaseVersion  stringByAppendingFormat:@"%@",self.user_id]];
    [self synchronize];
}

- (NSString *)databaseVersion
{
    return [self stringForKey:[defaultsDatabaseVersion stringByAppendingFormat:@"%@",self.user_id]];
    
}

#pragma mark - unReadMessageArray

- (void)setUnReatMessageArray:(NSArray *)unReadMessageArray
{
    [self setObject:unReadMessageArray forKey:defaultsUnReadMessageArray];
    [self synchronize];
}

- (NSArray *)unReadMessageArray
{
    return [self arrayForKey:defaultsUnReadMessageArray];
    
}


-(void)saveObject:(id)obj forKey:(NSString* )key{
    [self setObject:obj forKey:key];
    [self synchronize];
}

-(void)saveObjectInBackground:(id)obj forKey:(NSString* )key{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self saveObject:obj forKey:key];
    });
    
}
@end
