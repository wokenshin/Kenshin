//
//  M2MBLEController.h
//  iOSProject
//
//  Created by 王江 on 2016/10/30.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "M2MBLEScanner.h"
#import "M2MLock.h"
#import "M2MLog.h"
#import "M2Mkey.h"

#import "SessionStartEncoder.h"
#import "GetStatusEncoder.h"
#import "UnlockEncoder.h"
#import "AlarmOptEncoder.h"
#import "TimeSyncEncoder.h"
#import "VerifyAdminPwdEncoder.h"
#import "SetAdminPwdEncoder.h"
#import "ReadLogEncoder.h"
#import "ResetDeviceEncoder.h"
#import "MobileKeyEncoder.h"
#import "CombinationEncoder.h"
#import "FingerprintEncoder.h"
#import "RfidEncoder.h"
#import "DisconnectEncoder.h"

#import "FacotryDataResetDecoder.h"
#import "VerifyAdminPwdDecoder.h"
#import "SetAdminPwdDecoder.h"
#import "MobileKeyDecoder.h"
#import "CombinationDecoder.h"
#import "FingerprintDecoder.h"
#import "RfidDecoder.h"
#import "DebugInfoDecoder.h"

#import "M2MBLECtrlCallback.h"

#pragma mark - 控制器声明
/*!
 @brief M2Mkey智能设备控制器
 */
@interface M2MBLEController : NSObject

{
    id <M2MLockBasicCtrlCallback, ZCLockCtrlCallback, M2MLockLogCtrlCallback,
    M2MLockMobileKeyCtrlCallback, M2MLockCombinationCtrlCallback, M2MLockFingerprintCtrlCallback,
    M2MLockRfidCtrlCallback> _delegate;
}

/*!
 @brief 获取控制器单例对象
 */
+ (M2MBLEController *) getController;

@property (nonatomic, strong) id delegate;

/*!
 @brief BLE蓝牙扫描器
 */
@property (getter=getScanner, readonly) M2MBLEScanner* mBleScanner;

/*!
 @brief M2Mkey智能设备
 */
@property (getter=getDevice, setter=setDevice:) M2MBLEDevice* mBleDevice;

/*!
 @brief 标识设备是否已连接
 */
@property (getter=isConnected, readonly) BOOL mSessionStarted;

/*!
 @brief 智能锁返回的nonce值
 */
@property (nonatomic, strong) NSData *mNonce;

@property int16_t mCounter;

/*!
 @brief 标识蓝牙是否已打开
 */
@property BOOL bluetoothEnalbed;

- (void) handleStatusMsg:(M2MBLEProtocol *)protocol;
- (void) writeSecureCmd:(ProtocolEncoder *)encoder;

/*!
 @brief 连接智能设备，请先调用setDevice方法设置设备，设备连接过程为异步操作，该方法返回仅标识是否启动连接操作,
 处理过程参见https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/BestPracticesForInteractingWithARemotePeripheralDevice/BestPracticesForInteractingWithARemotePeripheralDevice.html
 @return
        YES - 连接操作已启动；
        NO - 连接操作未启动，没有通过setDevice设置设备，或手机蓝牙关闭的情况下会返回该值
 */
- (BOOL) connect;

/*!
 @brief 断开智能设备
 */
- (void) disconnect;

- (void) disconnectByCmd;

/*!
 @brief 获取设备状态
 */
- (void) getStatus;

/*!
 @brief 发送开锁指令，智能锁接收到该指令后，会使能马达，从而可以通过外把手开锁
 */
- (void) unlock;

/*!
 @brief 开警报
 */
- (void) alarmOn;

/*!
 @brief 关警报
 */
- (void) alarmOff;

/*!
 @brief 同步时间
 */
- (void) syncTime:(uint32_t)timestamp timezone:(uint8_t)timezone;

/*!
 @brief 修改管理员密码
 @param old_pwd
                旧密码
 @param new_pwd
                新密码
 */
- (void) modifyAdminPwd:(NSString *)old_pwd newpwd:(NSString *)new_pwd;

/*!
 @brief 读取设备日志
 @param start
                起始日志ID
 */
- (void) readLog:(int)start;

/*!
 @brief 取消日志读取操作
 */
- (void) cancelReadingLog;

/*!
 @brief 获取手机钥匙mKey（普通用户）
 @param auth_end
            授权截止日志，4字节时间戳，值为0标识永久有效
 */
- (void) requestMobileKey:(uint32_t)auth_end;

/*!
 @brief 获取所有永久有效的手机钥匙（普通用户）
 */
- (void) requestAllPermanentMobileKey;

/*!
 @brief 回收指定的mKey
 @param pin
            mKey PIN#
 */
- (void) reclaimMobileKey:(int)pin;

/*!
 @brief 重置手机钥匙
 */
- (void) resetMobileKey;

/*!
 @brief 设置固定密码，密码长度必须为6位数字
 @param comb
                数字密码字符串
 */
- (void) setPermanentCombination:(NSString *)comb;

/*!
 @brief 更新一次性密码库
 */
- (void) updateOneTimeCombinationRepo;

/*!
 @brief 录入指纹，录入过程中需要用户重复3次放上手指
 */
- (void) recordFingerprint;

/*!
 @brief 删除指纹
 @param fpid
                指纹ID
 */
- (void) deleteFingerprint:(int)fpid;

/*!
 @brief 重置指纹
 */
- (void) resetFingerprint;

- (void) addRfid;

- (void) runRfid;

- (void) deleteRfid:(int)flash_id;

- (void) resetRfid;

/*!
 @brief 重置设备，重置完成后设备会自动重启
 */
- (void) resetDevice;

#pragma mark - 蓝牙扫描相关方法
- (void) setBleScanDelegate:(id)delegate;
- (void) startPureBleScan;
- (void) stopPureBleScan;

@end
