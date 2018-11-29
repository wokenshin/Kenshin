//
//  KStatus.h
//  GYBase
//
//  Created by doit on 16/6/1.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KStatus : NSObject//这个模型主要的方法就是根据plist字典内容生成微博对象:

#pragma mark - 属性
@property (nonatomic,assign) long long        Id;                 //微博id
@property (nonatomic,strong) NSString         *profileImageUrl;   //头像
@property (nonatomic,strong) NSString         *userName;          //发送用户
@property (nonatomic,strong) NSString         *mbtype;            //会员类型
@property (nonatomic,strong) NSString         *createdAt;         //创建时间
@property (nonatomic,strong) NSString         *source;            //设备来源
@property (nonatomic,strong) NSString         *text;              //微博内容



#pragma mark - 方法
#pragma mark 根据字典初始化微博对象
- (KStatus *)initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化微博对象（静态方法）
+ (KStatus *)statusWithDictionary:(NSDictionary *)dic;

@end
