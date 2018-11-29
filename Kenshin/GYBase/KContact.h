//
//  KContact.h
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KContact : NSObject//联系人Model

#pragma mark 姓
@property (nonatomic, strong) NSString *firstName;

#pragma mark 名
@property (nonatomic, strong) NSString *lastName;

#pragma mark 手机号码
@property (nonatomic, strong) NSString *phoneNumber;

#pragma mark 带参数的构造函数
- (KContact *)initWithFirstName:(NSString *)firstName
                   andLastName:(NSString *)lastName
                andPhoneNumber:(NSString *)phoneNumber;

#pragma mark 取得姓名
- (NSString *)getName;

#pragma mark 带参数的静态对象初始化方法
+ (KContact *)initWithFirstName:(NSString *)firstName
                   andLastName:(NSString *)lastName
                andPhoneNumber:(NSString *)phoneNumber;

@end
