//
//  NSUserDefaultTools.h
//  GYBase
//
//  Created by doit on 16/4/11.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    沙盒工具 用来保存偏好设置
 */

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface NSUserDefaultTools : NSObject

//保存

//用户名
+ (void)saveUserName:(NSString *)username;
//密码
+ (void)savePassWord:(NSString *)password;

//姓名（设置页面）
+ (void)saveSettingName:(NSString *)name;
+ (void)saveEmail:(NSString *)emailAddress;


//获取

//用户名
+ (NSString *)getUserName;
//密码
+ (NSString *)getPassWord;
//姓名（设置页面）
+ (NSString *)getSettingName;
+ (NSString *)emailAddress;
//清空沙盒
+ (void)clearAll;//清空全部数据

+ (void)clearUserInfo;
+ (void)clearSettingName;
+ (void)clearEmail;
@end
