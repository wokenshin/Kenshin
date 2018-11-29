//
//  M2MBLEDevice.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/3.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "M2MBLEMessage.h"

#define MKEY_ADMIN_PIN 1

/*!
 @brief sLock-3类型定义，值为3
 */
extern const int TYPE_SLOCK3;
/*!
 @brief fLock-4类型定义，值为12
 */
extern const int TYPE_FLOCK4;
/*!
 @brief 未知设备
 */
extern const int TYPE_UNKNOWN;

/*!
 @brief M2Mkey智能设备基类，封装CBPeripheral
 */
@interface M2MBLEDevice : NSObject

/*!
 @brief 智能设备ID，即设备蓝牙地址
 */
@property (getter=devId, readonly) NSString* mDeviceId;

/*!
 @brief 智能设备类型，参见TYPE_XX常量
 */
@property (getter=type, readonly) int mDeviceType;

/*!
 @brief mKey PIN#，取值1-21，1为管理员，2-21为普通用户
 */
@property (getter=pin, readonly) int mPin;

/*!
 @brief mKey密钥
 */
@property (nonatomic, strong) NSData *ltk;

/*!
 @brief 设备电量百分比，取值0-100
 */
@property (getter=battery, setter=setBattery:) int mBatteryLevel;

/*!
 @brief 标识是否已向设备同步时间
 */
@property (getter=timeSynced, setter=setTimeSyncState:) BOOL mTimeSynced;

/*!
 @brief CBPeripheral蓝牙设备实例
 */
@property (nonatomic, strong, getter=getPeripheral, setter=setPeripheral:) CBPeripheral* mPeripheral;
/*!
 @brief 智能设备软件版本号
 */
@property (getter=swVersion, setter=swVersion:) uint8_t mSoftwareVersion;
/*!
 @brief 智能设备硬件版本号
 */
@property (getter=hwVersion, setter=hwVersion:) uint32_t mHardwareVersion;

/*!
 @brief 通过蓝牙地址初始化智能设备
 @param mac
            蓝牙地址，格式如：“EE:EE:EE:EE:EE:EE”
 @param device_type
            设备类型，参见TYPE_XX常量
 */
- (id) initWith:(NSString *)mac type:(int)device_type pin:(int)pin ltk:(NSString *)ltk;
- (id) initWith:(NSString *)mac type:(int)device_type pin:(int)pin rawLtk:(NSData *)ltk;

/*!
 @brief 根据蓝牙状态反馈数据更新设备状态
 */
- (void) updateStatus:(NSData *)row_data;

/*!
 @brief 获取设备的日志容量（设备总共可存储的日志的数量）

 @return 日志容量
 */
- (int) getLogCapacity;

/*!
 @brief 获取协议日志数据长度

 @return 单条日志数据的长度，单位byte
 */
- (int) getLogSize;

@end
