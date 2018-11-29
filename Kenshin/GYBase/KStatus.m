//
//  KStatus.m
//  GYBase
//
//  Created by doit on 16/6/1.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "KStatus.h"

@implementation KStatus

#pragma mark 根据字典初始化微博对象
- (KStatus *)initWithDictionary:(NSDictionary *)dic
{
    if(self = [super init])
    {
//        self.Id = [dic[@"Id"] longLongValue];
//        self.profileImageUrl = dic[@"profileImageUrl"];
//        self.userName = dic[@"userName"];
//        self.mbtype = dic[@"mbtype"];
//        self.createdAt = dic[@"createdAt"];
//        self.source = dic[@"source"];
//        self.text = dic[@"text"];
        [self setValuesForKeysWithDictionary:dic];//相当于上面的注释代码
    }
    return self;
    
}

#pragma mark 初始化微博对象（静态方法）
+(KStatus *)statusWithDictionary:(NSDictionary *)dic
{
    KStatus *status = [[KStatus alloc]initWithDictionary:dic];
    return status;
    
}

-(NSString *)source
{
    return [NSString stringWithFormat:@"来自 %@",_source];
    
}
@end
