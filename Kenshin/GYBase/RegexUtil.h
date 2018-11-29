//
//  RegexUtil.h
//  server
//
//  Created by xiangwl on 15/12/14.
//  Copyright (c) 2015年 ddsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexUtil : NSObject//正则表达式

//监测电话号码合法性
+ (BOOL)isValidTelePhone:(NSString *)telephone;
//监测移动电话号码合法性
+ (BOOL)isValidMobileNumber:(NSString*)mobileNum;
//监测电子邮件地址合法性
+ (BOOL)isValidEmail:(NSString *)email;

+ (BOOL)isValidZipCode:(NSString *)zipCode;
//监测密码合法性
+ (BOOL)isValidPassword:(NSString *)password;

+ (BOOL)validateIDCardNumber:(NSString *)value;

@end
