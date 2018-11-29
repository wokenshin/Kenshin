//
//  KContactGroup.m
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "KContactGroup.h"

@implementation KContactGroup

- (KContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts
{
    if (self = [super init])
    {
        self.name = name;
        self.detail = detail;
        self.contacts = contacts;
    }
    return self;
    
}

+ (KContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts
{
    KContactGroup *group1 = [[KContactGroup alloc]initWithName:name andDetail:detail andContacts:contacts];
    return group1;
    
}

@end
