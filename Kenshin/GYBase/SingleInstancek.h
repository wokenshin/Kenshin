//
//  SingleInstancek.h
//  GYBase
//
//  Created by kenshin on 16/8/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleInstancek : NSObject<NSCopying, NSMutableCopying>


+ (instancetype)shareSingleInstancek;

@end
