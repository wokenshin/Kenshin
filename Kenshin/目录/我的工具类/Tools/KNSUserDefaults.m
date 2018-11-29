//
//  KNSUserDefaults.m
//  Mother-Service-Station
//
//  Created by kenshin on 16/6/20.
//  Copyright © 2016年 ddsl. All rights reserved.
//

#import "KNSUserDefaults.h"

@implementation KNSUserDefaults

#pragma mark 保存


+ (void)saveString:(NSString *)launchUrl
{
    if (launchUrl != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:launchUrl forKey:@"LAUNCH_IMG_URL"];
        [userDefaults synchronize];
    }
    
}

//登录状态
+ (void)saveBOOL:(BOOL)state
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:state forKey:@"LOGIN_STATE"];
    [userDefaults synchronize];
    
}

//余额
+ (void)saveDounle:(double)balance
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:balance forKey:@"BALANCE"];
    [userDefaults synchronize];
    
}

//=======================
//账号
+ (NSString *)GetString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"ACCOUNT"];
    
}

+ (BOOL)GetBOOL
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"REGIONID"];
}

//地区ID
+ (NSInteger)GetNSinteger
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"REGIONID"];
    
}

//余额
+ (double)GetDouble
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults doubleForKey:@"BALANCE"];
}

#pragma mark - 清空数据
 + (void)clearAll
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"LOGIN_STATE"];
    [userDefaults removeObjectForKey:@"NICK_NAME"];
    [userDefaults removeObjectForKey:@"MARK"];
    [userDefaults removeObjectForKey:@"ACCOUNT"];
    [userDefaults synchronize];
    
}

//——————————————————————————————————————————三禾APP——————————————————————————————————————————————————————

+ (void)saveDeviceTokenForAPNS:(NSString *)deviceToken
{
    if (deviceToken != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:deviceToken forKey:@"deviceTokenForAPNS"];
        [userDefaults synchronize];
    }
}

+ (NSString *)deviceTokenForAPNS
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"deviceTokenForAPNS"];
}

/**
 * 保存手势锁密码 
 */
+ (void)saveGesturePassword:(NSString *)password
{
    //手势密码至少4位数
    if (password != nil && ![password isEqualToString:@""] && [password length] >= 4)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:password forKey:@"gesturePassword"];
        [userDefaults synchronize];
    }
    
}

/**
 * 清空手势锁密码
 */
+ (void)clearGesturePassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"gesturePassword"];
    
}

/**
 * 保存手势锁的状态  YES：开启， NO：关闭
 */
+ (void)saveGestureLockState:(BOOL)isOpne
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isOpne forKey:@"isGestureLockState"];
    [userDefaults synchronize];
}

/**
 * 手势锁的状态  YES：开启， NO：关闭
 */
+ (BOOL)isGestureLockOpen
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL a = [userDefaults boolForKey:@"isGestureLockState"];
    return a;
    
}

/**
 * 登录状态
 */
+ (void)saveLoginState:(BOOL)isLoginState
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isLoginState forKey:@"isLoginState"];
    [userDefaults synchronize];
    
}

/**
 * 登录状态
 */
+ (BOOL)isLoginState
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL a = [userDefaults boolForKey:@"isLoginState"];
    return a;

}

+ (void)saveUserId:(NSString *)userId
{
    if (userId != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userId forKey:@"userId"];
        [userDefaults synchronize];
    }
}

+ (NSString *)userId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"userId"] == nil) {
        return @"";
    }
    return [userDefaults objectForKey:@"userId"];
    
}

+ (void)saveUserToken:(NSString *)token
{
    if (token != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:token forKey:@"userToken"];
        [userDefaults synchronize];
    }
}

+ (NSString *)userToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"userToken"] == nil) {
        return @"";
    }
    return [userDefaults objectForKey:@"userToken"];
}

/**
 * 登录账号，只在登录页面用于显示先前的登录手机号
 */
+ (void)saveLoginAccount:(NSString *)phone
{
    if (phone != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:phone forKey:@"loginAccount"];
        [userDefaults synchronize];
    }
}

/**
 * 登录账号，只在登录页面用于显示先前的登录手机号
 */
+ (NSString *)loginAcount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"loginAccount"] == nil) {
        return @"";
    }
    return [userDefaults objectForKey:@"loginAccount"];
}

+ (void)saveMkey:(NSInteger)mkey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:mkey forKey:@"mkey"];
    [userDefaults synchronize];
    
}

+ (NSInteger)mkey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:@"mkey"];
}

+ (void)savePhone:(NSString *)phone
{
    if (phone != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:phone forKey:@"phone"];
        [userDefaults synchronize];
    }
}

+ (NSString *)phone
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"phone"];
}

+ (void)saveEmail:(NSString *)email
{
    if (email != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:email forKey:@"email"];
        [userDefaults synchronize];
    }
}

+ (NSString *)email
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *email = [userDefaults objectForKey:@"email"];
    if (email == nil || [email isEqual:[NSNull null]])
    {
        email = @"未获取";
    }
    return email;
    
}

+ (void)saveUseHelpHtmlString:(NSString *)htmlStr
{
    if (htmlStr != nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:htmlStr forKey:@"htmlStr"];
        [userDefaults synchronize];
    }
}

+ (NSString *)htmlString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"htmlStr"];
}

+ (void)saveLoginUserInfo:(NSDictionary *)userInfo
{
    /*
     userid - 帐号ID，字符串类型
     user_token - 用户session的令牌，字符串类型，数据库同步也使用此token作为cookie
     mkey - 接收mKey标识，值可为0或1，0表示无mKey，1表示有mKey需要接收
     phone - 用户的注册手机号，字符串类型
     email - 用户的注册邮箱，字符串类型
     */
    
    NSString  *email        = [userInfo  objectForKey:@"email"];
    NSInteger mkey          = [[userInfo objectForKey:@"mkey"] integerValue];
    NSString  *phone        = [userInfo  objectForKey:@"phone"];
    NSString  *user_token   = [userInfo  objectForKey:@"user_token"];
    NSString  *userid       = [userInfo  objectForKey:@"userid"];
    
    [KNSUserDefaults saveEmail:email];
    [KNSUserDefaults saveMkey:mkey];
    [KNSUserDefaults savePhone:phone];
    [KNSUserDefaults saveUserToken:user_token];
    [KNSUserDefaults saveUserId:userid];
    
    [KNSUserDefaults saveLoginAccount:phone];
    
    //保存user_token FOR WIDGET
//    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.m2mkey.ddzm.quickopen"];
//    [shared setObject:user_token forKey:@"USER_TOKEN_WIDGET"];
//    [shared setObject:userid forKey:@"USER_ID_WIDGET"];
//    [shared synchronize];
    
}

+ (NSDictionary *)loginUserInfo
{
    NSDictionary *userInfoDic = [[NSDictionary alloc] init];
    
    NSString  *email        = [KNSUserDefaults email];
    NSInteger mkey          = [KNSUserDefaults mkey];
    NSString  *phone        = [KNSUserDefaults phone];
    NSString  *user_token   = [KNSUserDefaults userToken];
    NSString  *userid       = [KNSUserDefaults userId];
    
    [userInfoDic setValue:email forKey:@"email"];
    [userInfoDic setValue:[NSNumber numberWithInteger:mkey] forKey:@"mkey"];
    [userInfoDic setValue:phone forKey:@"phone"];
    [userInfoDic setValue:user_token forKey:@"user_token"];
    [userInfoDic setValue:userid forKey:@"userid"];
    
    return userInfoDic;
}

+ (void)clearLoginUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"email"];
    [userDefaults removeObjectForKey:@"mkey"];
    [userDefaults removeObjectForKey:@"phone"];
    [userDefaults removeObjectForKey:@"user_token"];
    [userDefaults removeObjectForKey:@"userid"];
    [userDefaults synchronize];
    
}

+ (void)saveRealTimeWith:(double)realTime
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:realTime forKey:@"realTime"];
    [userDefaults synchronize];
    
}

/**
 * "真实"时间
 */
+ (double)realTime
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults doubleForKey:@"realTime"];
}

@end
