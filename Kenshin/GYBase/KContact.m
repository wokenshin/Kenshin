//
//  KContact.m
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "KContact.h"

@implementation KContact

- (KContact *)initWithFirstName:(NSString *)firstName
                    andLastName:(NSString *)lastName
                 andPhoneNumber:(NSString *)phoneNumber
{
    if(self=[super init])
    {
        self.firstName=firstName;
        self.lastName=lastName;
        self.phoneNumber=phoneNumber;
        
    }
    return self;
    
}

+ (KContact *)initWithFirstName:(NSString *)firstName
                    andLastName:(NSString *)lastName
                 andPhoneNumber:(NSString *)phoneNumber
{
    KContact *contact1=[[KContact alloc]initWithFirstName:firstName
                                              andLastName:lastName
                                           andPhoneNumber:phoneNumber];
    return contact1;
    
}

- (NSString *)getName
{
    return [NSString stringWithFormat:@"%@ %@",_lastName,_firstName];
    
}
@end
