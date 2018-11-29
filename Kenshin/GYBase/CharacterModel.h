//
//  CharacterModel.h
//  GYBase
//
//  Created by doit on 16/4/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterModel : NSObject

@property (nonatomic, copy) NSString *headerImg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;

- (instancetype)initCharacterModel:(NSDictionary *)dic;
+ (instancetype)characterModel:(NSDictionary *)dic;
@end
