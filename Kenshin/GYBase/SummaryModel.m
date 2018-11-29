//
//  SummaryModel.m
//  GYBase
//
//  Created by doit on 16/4/21.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SummaryModel.h"

@implementation SummaryModel

- (instancetype)initSummaryModel:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];//kvc
    }
    return self;
    
}

+ (instancetype)summaryModel:(NSDictionary *)dic
{
    return [[self alloc] initSummaryModel:dic];
    
}

@end
