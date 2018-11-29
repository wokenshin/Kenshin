//
//  NSUserDefaultTools.m
//  GYBase
//
//  Created by doit on 16/4/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

//定义一些保存在沙盒中的接口
#import "NSUserDefaultTools.h"

@implementation NSUserDefaultTools

#pragma mark 保存
+ (void)saveUserName:(NSString *)username
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (username != nil)
    {
        [userDefaults setValue:username forKey:@"username"];
    }
    
}

+ (void)savePassWord:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (password != nil)
    {
        [userDefaults setValue:password forKey:@"password"];
    }
    
}

+ (void)saveSettingName:(NSString *)name
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (name != nil)
    {
        [userDefaults setValue:name forKey:@"SettingName"];
    }
}

+ (void)saveEmail:(NSString *)emailAddress
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (emailAddress != nil)
    {
        [userDefaults setValue:emailAddress forKey:@"Email"];
    }
    
}

#pragma mark - 获取
+ (NSString *)getUserName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"username"];
    
}

+ (NSString *)getPassWord
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"password"];
    
}

+ (NSString *)getSettingName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"SettingName"];
    
}

+ (NSString *)emailAddress
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"Email"];
    
}
#pragma mark - 清空
+ (void)clearAll
{
    [NSUserDefaultTools clearUserInfo];
    [NSUserDefaultTools clearSettingName];
    
}

+ (void)clearUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"username"];
    [userDefaults removeObjectForKey:@"password"];
    
}

+ (void)clearSettingName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"SettingName"];
    
}

+ (void)clearEmail
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"Email"];

    
}
@end
