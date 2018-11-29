//
//  M2MBLECtrlCallback.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/19.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#ifndef M2MBLECtrlCallback_h
#define M2MBLECtrlCallback_h

#import "FingerprintDecoder.h"

/*!
 @brief 设备连接返回标识
 */
typedef enum {
    CS_CONN_OK, // 连接成功
    CS_SCANNING, // 正在扫描
    CS_OUT_OF_RANGE, // 未扫描到设备
    CS_IN_DFU_MODE, // 设备处于DFU模式
    CS_CONNECTING, // 正在连接
    CS_CONN_TIMEOUT, // 连接超时
    CS_MKEY_ERROR, // mKey错误
    CS_BLE_ERROR, // 底层蓝牙错误
    CS_CONN_UNKNOWN_ERROR // 未知错误
}ConnState;

/*!
 @brief 修改管理员密码的返回标识
 */
typedef enum {
    AMR_MOD_PWD_OK, // 修改成功
    AMR_INVALID_PWD, // 无效的密码
    AMR_INCORRECT_OLD_PWD, // 旧密码错误
    AMR_MOD_UNKNOWN_ERROR // 未知错误
}AdminModifiedResult;

/*!
 @brief 蓝牙通信错误标识
 */
typedef enum {
    CE_CMD_TIMEOUT, // 指令超时未收到回复
    CE_CMD_SENT_TOO_FAST, // 指令发送过快
    CE_INVALID_BLE_MSG, // 无效的蓝牙消息数据
    CE_MAC_INCORRECT, // 消息MAC校验错误，App会自动断开连接
    CE_COUNTER_INCORRECT_FROM_LOCK, // 锁端返回消息counter错误
    CE_COUNTER_INCORRECT_FROM_APP, // App端检测到消息counter错误
    CE_NO_ACTION_TIMEOUT // 长时间未操作
}CommError;

/*!
 @brief 日志读取结果标识
 */
typedef enum {
    LRR_OK,
    LRR_TIMEOUT,
    LRR_UNKNOWN_ERROR
}LogReadResult;

typedef enum {
    RRR_OK, // 添加成功
    RRR_DUPLICATED, // 卡片已登记
    RRR_NO_SPACE, // 卡片登记数量达到最大
    RRR_TIMEOUT, // 登记超时
    RRR_FAILED // 添加失败
}RfidReadResult;

#pragma mark - 基本控制回调
@protocol M2MLockBasicCtrlCallback <NSObject>
@required
/*!
 @brief 锁连接状态回调
 */
- (void) onLockConnecting:(ConnState)state;
/*!
 @brief 通信错误回调
 @param error
 通信错误标识，参见CommError
 */
- (void) onCommunicationError:(CommError)error;

/*!
 @brief 锁状态更新回调
 */
- (void) onLockStateChanged;

/*!
 @brief 锁连接断开回调
 */
- (void) onLockDisconnected;

@optional
/*!
 @brief 管理员密码修改结果回调
 @param result
 修改结果，参见AdminModifiedResult
 */
- (void) onAdminPwdModified:(AdminModifiedResult)result;

/*!
 @brief 恢复出厂设置回调
 @param result
 YES - 成功，NO - 失败
 */
- (void) onFactoryDataReset:(BOOL)result;

/*!
 @brief 时间同步完成回调
 */
- (void) onTimeSynced;

@end

#pragma mark - 日志回调
@protocol M2MLockLogCtrlCallback <NSObject>

- (void) onLogRead:(LogReadResult)result logs:(NSArray *)log_list;

@end

#pragma mark - mKey回调
typedef enum {
    MKE_OUT_OF_USE, // mKey已分配完
    MKE_FAILED_TO_RECLAIM // mKey回收失败
}MobileKeyError;

@protocol M2MLockMobileKeyCtrlCallback <NSObject>

- (void) onMobileKeyReceived:(M2Mkey *)mkey;
- (void) onAllMobileKeyReceived:(NSArray *)mkey_list;
- (void) onMobileKeyReset;
- (void) onMobileKeyReclaimed:(int)pin;
- (void) onMobileKeyError:(MobileKeyError)error;

@end

#pragma mark - 智诚锁开锁回调
/*!
 @brief 智诚机柜锁开锁结果
 */
typedef enum {
    ZCUR_OK, // 开锁成功
    ZCUR_UNAUTH, // 未授权
    ZCUR_DEVICE_BUSY // 有其他锁处于解锁状态
}ZCUnlockResult;

@protocol ZCLockCtrlCallback <NSObject>
@required

- (void) onLockOpen:(int)lock_num result:(ZCUnlockResult)ret;

@end

#pragma mark - 数字密码相关回调

@protocol M2MLockCombinationCtrlCallback <NSObject>

- (void) onPermanentCombinationSet:(BOOL)success;
- (void) onOneTimeCombRepoGenerated:(BOOL)success;
- (void) onOneTimeCombRepoReceived:(NSArray *)comb_list;

@end

#pragma mark - 指纹相关回调

@protocol M2MLockFingerprintCtrlCallback <NSObject>

- (void) onFingerprintRecording:(int)record_time;
- (void) onFingerprintRecorded:(int)fpid;
- (void) onFingerprintDeleted:(int)fpid;
- (void) onFingerprintReset:(int)total_num;
- (void) onFingerprintError:(FingerprintError)error;

@end

@protocol M2MLockRfidCtrlCallback <NSObject>

- (void) onRfidAdded:(RfidReadResult)result flash:(int)flash;
- (void) onRfidRun:(BOOL)success;
- (void) onRfidDeleted:(BOOL)success;
- (void) onRfidReset:(BOOL)success;

@end


#endif /* M2MBLECtrlCallback_h */
