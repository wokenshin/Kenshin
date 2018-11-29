//
//  Provinces.m
//  GYBase
//
//  Created by doit on 16/5/14.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Provinces.h"
#import "Tools.h"

@implementation Provinces

+ (instancetype)provincesWithDic:(NSDictionary *)dic
{
    Provinces *pro = [[Provinces alloc] init];
    [pro setValuesForKeysWithDictionary:dic];
    return pro;
    
}

@end
