//
//  KNSUserDefaults.h
//  Mother-Service-Station
//
//  Created by kenshin on 16/6/20.
//  Copyright © 2016年 ddsl. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KNSUserDefaults : NSObject

#pragma mark 保存

//demoCodes

+ (void)saveString:(NSString *)launchUrl;
+ (void)saveBOOL:(BOOL)state;
+ (void)saveDounle:(double)balance;

+ (NSString *)GetString;
+ (BOOL)GetBOOL;
+ (NSInteger)GetNSinteger;
+ (double)GetDouble;

+ (void)clearAll;

/**
 * 保存APNS_DevieToken
 */
+ (void)saveDeviceTokenForAPNS:(NSString *)deviceToken;

/**
 * APNS_DevieToken
 */
+ (NSString *)deviceTokenForAPNS;

/**
 * 保存手势锁密码 [暂时没用到 2016-11-16]
 */
//+ (void)saveGesturePassword:(NSString *)password;

/**
 * 清空手势锁密码 [暂时没用到 2016-11-16]
 */
//+ (void)clearGesturePassword;

/**
 * 保存手势锁的状态  YES：开启， NO：关闭
 */
+ (void)saveGestureLockState:(BOOL)isOpne;

/**
 * 手势锁的状态  YES：开启， NO：关闭
 */
+ (BOOL)isGestureLockOpen;

/**
 * 登录账号，只在登录页面用于显示先前的登录手机号
 */
+ (void)saveLoginAccount:(NSString *)phone;

/**
 * 登录账号，只在登录页面用于显示先前的登录手机号
 */
+ (NSString *)loginAcount;

/**
 * 登录状态
 */
+ (void)saveLoginState:(BOOL)isLogined;

/**
 * 登录状态
 */
+ (BOOL)isLoginState;

//——————————————————————————————————用户登录信息————————————————————————————————————————————————
/*
 userid - 帐号ID，字符串类型
 
 user_token - 用户session的令牌，字符串类型，数据库同步也使用此token作为cookie
 
 mkey - 接收mKey标识，值可为0或1，0表示无mKey，1表示有mKey需要接收
 
 phone - 用户的注册手机号，字符串类型
 
 email - 用户的注册邮箱，字符串类型
 */

/**
 * 保存userId
 */
+ (void)saveUserId:(NSString *)userId;

/**
 * userId
 */
+ (NSString *)userId;

/**
 *保存用户session的令牌，字符串类型，数据库同步也使用此token作为cookie
 */
+ (void)saveUserToken:(NSString *)token;

/**
 *获取用户session的令牌，字符串类型，数据库同步也使用此token作为cookie
 */
+ (NSString *)userToken;

/**
 * 保存 mkey - 接收mKey标识，值可为0或1，0表示无mKey，1表示有mKey需要接收
 */
+ (void)saveMkey:(NSInteger)mkey;

/**
 * 获取 mkey - 接收mKey标识，值可为0或1，0表示无mKey，1表示有mKey需要接收
 */
+ (NSInteger)mkey;

/**
 * 保存 phone - 用户的注册手机号，字符串类型
 */
+ (void)savePhone:(NSString *)phone;

/**
 * 获取 phone - 用户的注册手机号，字符串类型
 */
+ (NSString *)phone;

/**
 * 保存 用户的注册邮箱，字符串类型
 */
+ (void)saveEmail:(NSString *)email;

/**
 * 获取 用户的注册邮箱，字符串类型
 */
+ (NSString *)email;

/**
 * 保存登录信息
 */
+ (void)saveLoginUserInfo:(NSDictionary *)userInfo;

/**
 * 获取登录信息
 */
+ (NSDictionary *)loginUserInfo;

/**
 * 保存使用帮助页面 字符串
 */
+ (void)saveUseHelpHtmlString:(NSString *)htmlStr;

+ (NSString *)htmlString;

/**
 * 清空用户信息
 */
+ (void)clearLoginUserInfo;

/**
 * 保存"真实"时间 这个时间只会 >=真实的时间
 */
+ (void)saveRealTimeWith:(double)realTime;

/**
 * "真实"时间
 */
+ (double)realTime;

@end
