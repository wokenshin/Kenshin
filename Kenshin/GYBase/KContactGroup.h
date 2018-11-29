//
//  KContactGroup.h
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KContact.h"
@interface KContactGroup : NSObject//分组Model ［包含 若干联系人］

//为了演示分组显示我们不妨将一组数据也抽象成模型KContactGroup


#pragma mark 组名
@property (nonatomic, copy) NSString *name;

#pragma mark 分组描述
@property (nonatomic, copy) NSString *detail;

#pragma mark 联系人
@property (nonatomic, strong) NSMutableArray *contacts;

#pragma mark 带参数个构造函数
- (KContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

#pragma mark 静态初始化方法
+ (KContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

@end
