//
//  M2MLock.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/4.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "M2MBLEDevice.h"

/*!
 @brief M2Mkey智能锁基类
 */
@interface M2MLock : M2MBLEDevice

/*!
 @brief 设置备注名称
 */
@property (getter=friendlyName, setter=friendlyName:) NSString* mFriendlyName;

/*!
 @brief 马达状态，开启时可通过外把手开门
 */
@property (getter=motorOn, readonly) BOOL mMotorOn;

/*!
 @brief 警报状态
 */
@property (getter=alarmOn, readonly) BOOL mAlarmOn;

/*!
 @brief 反锁状态
 */
@property (getter=safeLocked, readonly) BOOL mSafeLocked;

/*!
 @brief 门磁状态，标识门是否打开
 */
@property (getter=doorOpen, readonly) BOOL mDoorOpen;

/*!
 @brief 标识是否处于家庭模式
 */
@property (getter=homeMode, readonly) BOOL mHomeMode;

/*!
 @brief 初始化M2MLock对象
 @param mac
            蓝牙地址，格式如：“EE:EE:EE:EE:EE:EE”
 @param device_type
            设备类型，参见TYPE_XX常量
 @param friendly_name
            设备备注名称，有用户自定义
 @param pin
            mKey PIN#
 @param ltk
            mKey密钥，若PIN#为管理则，则ltk传任意字符串；若为普通用户，则传十六进制字符串
 */
- (id) initWith:(NSString *)mac
           type:(int)device_type comment:(NSString *)friendly_name
            pin:(int)pin ltk:(NSString *)ltk;
- (id) initWith:(NSString *)mac
           type:(int)device_type comment:(NSString *)friendly_name
            pin:(int)pin rawLtk:(NSData *)ltk;

/*!
 @brief 根据蓝牙状态反馈数据更新设备状态
 */
- (void) updateStatus:(NSData *)row_data;

@end
