//
//  Flag.m
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Flag.h"

@implementation Flag

+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    Flag *flag = [[Flag alloc] init];
    
    //KVC
    [flag setValuesForKeysWithDictionary:dict];
    
    //kvc 的意思就是 将字典中的所有简直对 于当前对象中的所有属性一一对应赋值
    return flag;
    
}

//重写set方法 因为kvc给成员属性赋的值都是字符串,但是kvc底层会调用对应的set方法
- (void)setIcon:(NSString *)icon
{
    _icon = [UIImage imageNamed:icon];
    
}
@end
