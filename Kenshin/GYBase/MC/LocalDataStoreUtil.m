//
//  LocalDataStoreUtil.m
//  server
//
//  Created by xiangwl on 15/12/15.
//  Copyright (c) 2015年 ddsl. All rights reserved.
//

#import "LocalDataStoreUtil.h"
#import "Constants.h"

@implementation LocalDataStoreUtil

+(void)saveToken:(NSString *)token{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:token forKey:DATA_KEY_TOKEN];
}
+(NSString *)getToken{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:DATA_KEY_TOKEN];
}

+(void)saveStaffPhoneNo:(NSString *)phoneNo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:phoneNo forKey:DATA_KEY_STAFF_PHONENO];
}
+(void)saveStaffStatus:(NSInteger)status{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:status forKey:DATA_KEY_STAFF_STATUS];
}


+(void)saveLon:(double)lon{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:lon forKey:DATA_KEY_LOCATION_LON];
}
+(void)saveLat:(double)lat{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:lat forKey:DATA_KEY_LOCATION_LAT];
}
+(void)saveStaffStar:(NSInteger)star{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:star forKey:DATA_KEY_STAFF_STAR];
}
+(void)saveStaffServices:(NSString *)services{
    if (services == nil) {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:services forKey:DATA_KEY_STAFF_SERVICES];
}
+(void)saveStaffRemark:(NSString *)remark{
    if (remark == nil) {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:remark forKey:DATA_KEY_STAFF_REMARK];
}
+(void)saveStaffPicture:(NSString *)picture{
    if (picture == nil) {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:picture forKey:DATA_KEY_STAFF_PICTURE];

}
+(void)saveLastOnlineTime:(NSInteger)lastOnlineTime{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:lastOnlineTime forKey:DATA_KEY_LAST_ONLINE_TIME];
}

+(void)saveOnlineDuration:(NSInteger)onlineDuration{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:onlineDuration forKey:DATA_KEY_ONLINE_DURATION];
}

+(double)getLon{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults doubleForKey:DATA_KEY_LOCATION_LON];
}
+(double)getLat{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults doubleForKey:DATA_KEY_LOCATION_LAT];
}
+(NSString *)getStaffPhoneNo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:DATA_KEY_STAFF_PHONENO];
}
+(NSInteger)getStaffStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:DATA_KEY_STAFF_STATUS];
}
+(NSInteger)getStaffStar{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:DATA_KEY_STAFF_STAR];
}
+(NSString *)getStaffServices{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:DATA_KEY_STAFF_SERVICES];
}
+(NSString *)getStaffRemark{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:DATA_KEY_STAFF_REMARK];
}
+(NSString *)getStaffPicture{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:DATA_KEY_STAFF_PICTURE];
}
+(NSInteger)getLastOnlineTime{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:DATA_KEY_LAST_ONLINE_TIME];
}
+(NSInteger)getOnlineDuration{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:DATA_KEY_ONLINE_DURATION];
}

+(void)saveSysTell:(NSString *)sysTell
{
    if (sysTell == nil) {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:sysTell forKey:@"sysTell"];
}

+(NSString *)sysTell
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"sysTell"];
}

+(void)saveStaff:(Staff *)staff{
    if (staff == nil) return;
    
    [LocalDataStoreUtil saveStaffPhoneNo:staff.phone];
    [LocalDataStoreUtil saveToken:staff.token];
    [LocalDataStoreUtil saveStaffStatus:staff.status];
    [LocalDataStoreUtil saveStaffStar:staff.star];
    [LocalDataStoreUtil saveStaffServices:staff.services];
    [LocalDataStoreUtil saveStaffRemark:staff.remark];
    [LocalDataStoreUtil saveStaffPicture:staff.picture];
    [LocalDataStoreUtil saveLastOnlineTime:staff.lastOnlineTime];
    [LocalDataStoreUtil saveOnlineDuration:staff.onlineDuration];
}

+(void)clearStaff{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:DATA_KEY_STAFF_PHONENO];
    [userDefaults removeObjectForKey:DATA_KEY_LOCATION_LAT];
    [userDefaults removeObjectForKey:DATA_KEY_LOCATION_LON];
    [userDefaults removeObjectForKey:DATA_KEY_TOKEN];
    [userDefaults removeObjectForKey:DATA_KEY_STAFF_STATUS];
    [userDefaults removeObjectForKey:DATA_KEY_STAFF_STAR];
    [userDefaults removeObjectForKey:DATA_KEY_STAFF_SERVICES];
    [userDefaults removeObjectForKey:DATA_KEY_STAFF_REMARK];
    [userDefaults removeObjectForKey:DATA_KEY_STAFF_PICTURE];
    [userDefaults removeObjectForKey:DATA_KEY_LAST_ONLINE_TIME];
    [userDefaults removeObjectForKey:DATA_KEY_ONLINE_DURATION];
}


@end
