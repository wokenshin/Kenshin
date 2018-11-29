//
//  PersonData.h
//  GYBase
//
//  Created by doit on 16/5/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonData : NSObject<NSCoding>

@property (nonatomic, strong) NSString          *name;
@property (nonatomic, assign) NSInteger         age;
@property (nonatomic, strong) NSMutableArray    *mArray;
@end
