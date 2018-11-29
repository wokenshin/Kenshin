//
//  CharacterModel.m
//  GYBase
//
//  Created by doit on 16/4/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CharacterModel.h"

@implementation CharacterModel

- (instancetype)initCharacterModel:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}

+ (instancetype)characterModel:(NSDictionary *)dic
{
    return [[self alloc] initCharacterModel:dic];
    
}
@end
