//
//  LocalDataStoreUtil.h
//  server
//
//  Created by xiangwl on 15/12/15.
//  Copyright (c) 2015年 ddsl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Staff.h"

@interface LocalDataStoreUtil :NSObject

+(void)saveToken:(NSString *)token;
+(NSString *)getToken;
+(void)saveStaffPhoneNo:(NSString *)phoneNo;
+(NSString *)getStaffPhoneNo;
+(void)saveStaffStatus:(NSInteger)status;
+(NSInteger)getStaffStatus;
+(void)saveStaffStar:(NSInteger)star;
+(NSInteger)getStaffStar;
+(void)saveStaffServices:(NSString *)services;
+(NSString *)getStaffServices;
+(void)saveStaffRemark:(NSString *)remark;
+(NSString *)getStaffRemark;
+(void)saveStaffPicture:(NSString *)picture;
+(NSString *)getStaffPicture;
+(void)saveLastOnlineTime:(NSInteger)lastOnlineTime;
+(NSInteger)getLastOnlineTime;
+(void)saveOnlineDuration:(NSInteger)onlineDuration;
+(NSInteger)getOnlineDuration;
+(void)saveSysTell:(NSString *)sysTell;
+(NSString *)sysTell;
//保存用户位置
+(void)saveLon:(double)lon;
+(void)saveLat:(double)lat;
+(double)getLon;
+(double)getLat;

/**
 *保存staff信息
 */
+(void)saveStaff:(Staff *)staff;
/**
 * 清理从业人员
 */
+(void)clearStaff;

@end
