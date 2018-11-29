//
//  NSString+Trim.m
//  GYBase
//
//  Created by doit on 16/5/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

-(NSString *)stringByTrim
{
    NSCharacterSet *character= [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:character];
    
}
@end
