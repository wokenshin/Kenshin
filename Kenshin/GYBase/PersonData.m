//
//  PersonData.m
//  GYBase
//
//  Created by doit on 16/5/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "PersonData.h"
#import "Tools.h"

@implementation PersonData


#pragma mark - NSCoding 需要归档的对象的类 必须实现该协议
//归档时调用，保存指定归档的对象属性值
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeInteger:_age forKey:@"mArray"];
    
}

//解单时调用(解析对象时调用)， 接档指定的对象属性 获取其值
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        _name   = [aDecoder decodeObjectForKey:@"name"];
        _age    = [aDecoder decodeIntForKey:@"age"];
        _mArray = [aDecoder decodeObjectForKey:@"mArray"];
    }
    return self;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
