//
//  Provinces.h
//  GYBase
//
//  Created by doit on 16/5/14.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Provinces : NSObject

@property (nonatomic, strong)NSString *name;//省
@property (nonatomic, strong)NSArray  *cities;

+ (instancetype)provincesWithDic:(NSDictionary *)dic;

@end
