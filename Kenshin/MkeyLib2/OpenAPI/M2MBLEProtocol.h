//
//  M2MBLEProtocol.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/5.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "M2MBLEMessage.h"

extern const int BLE_MSG_LEN; // 蓝牙协议长度

extern const uint16_t MSG_START_SESSION; // 建立加密会话指令
extern const uint16_t FB_START_SESSION; // 建立加密会话反馈
extern const uint16_t MSG_GET_STATUS; // 获取设备状态指令
extern const uint16_t FB_GET_STATUS; // 获取设备状态反馈
extern const uint16_t MSG_UNLOCK; // 开锁指令
extern const uint16_t FB_UNLOCK; // 开锁反馈
extern const uint16_t MSG_ALARMON; // 开警报指令
extern const uint16_t MSG_ALARMOFF; // 关警报指令
extern const uint16_t FB_ALARM; // 警报反馈
extern const uint16_t MSG_TIME_SYNC; // 同步时间指令
extern const uint16_t FB_TIME_SYNC; // 同步时间反馈
extern const uint16_t FB_FACTORY_DATA_RESET; // 恢复出厂设置反馈
extern const uint16_t MSG_LTK_VERIFY; // 验证LTK指令
extern const uint16_t FB_LTK_VERIFY; // 验证LTK反馈
extern const uint16_t MSG_LTK_WRITE; // 修改LTK指令
extern const uint16_t FB_LTK_WRITE; // 修改LTK反馈
extern const uint16_t MSG_READ_LOG; // 读取设备日志指令
extern const uint16_t FB_READ_LOG; // 读取设备日志反馈
extern const uint16_t MSG_RESET_DEVICE; // 重置设备指令
extern const uint16_t MSG_ZC_UNLOCK; // 智诚机柜锁开锁指令
extern const uint16_t FB_ZC_UNLOCK; // 智诚机柜锁开锁反馈
extern const uint16_t MSG_ADD_MKEY; // 添加mKey指令
extern const uint16_t FB_ADD_MKEY; // 添加mKey反馈
extern const uint16_t MSG_RECLAIM_MKEY; // 回收mKey指令
extern const uint16_t MSG_RESET_MKEY; // 重置mKey指令
extern const uint16_t FB_RECLAIM_MKEY; // 回收mKey反馈
extern const uint16_t MSG_SET_PERMANENT_COMB; // 设置固定密码（数字密码）指令
extern const uint16_t FB_SET_PERMANENT_COMB; // 设置固定密码反馈
extern const uint16_t MSG_UPDATE_ONETIME_COMBREPO; // 更新一次性密码库（数字密码）指令
extern const uint16_t FB_UPDATE_ONETIME_COMBREPO; // 更新一次性密码库反馈
extern const uint16_t MSG_GET_ONETIME_COMBREPO; // 获取一次性密码库指令
extern const uint16_t FB_GET_ONETIME_COMBREPO; // 获取一次性密码库反馈
extern const uint16_t MSG_RECORD_FINGERPRINT; // 录入指纹指令
extern const uint16_t FB_RECORD_FINGERPRINT; // 录入指纹反馈
extern const uint16_t MSG_DELETE_FINGERPRINT; // 删除指纹指令
extern const uint16_t FB_DELETE_FINGERPRINT; // 删除指纹反馈
extern const uint16_t MSG_RESET_FINGERPRINT; // 重置指纹指令
extern const uint16_t FB_RESET_FINGERPRINT; // 重置指纹反馈
extern const uint16_t MSG_RFID_CMD; // RFID操作指令（在指令的data中定义添加、删除等操作类型）
extern const uint16_t FB_RFID_CMD; // RFID操作反馈
/*!
 @brief 主动断开连接指令，设备端收到该指令后，会主动断开连接，避免iPhone手机调用cancelPeripheralConnection方法后，顶层蓝牙概率性长时间不断开的问题
 */
extern const uint16_t MSG_DISCONNECT;
/*!
 @brief 设备端Debug信息反馈，该指令用于接收设备端的调试信息
 */
extern const uint16_t FB_DEBUG_INFO;

/*!
 @brief M2Mkey蓝牙协议基类
 */
@interface M2MBLEProtocol : NSObject

/*!
 @brief 标识协议是否有效
 */
@property (nonatomic, assign, readonly) BOOL isValid;

/*!
 @brief 协议类型，参见指令（MSG_***）或反馈（FB_***）定义
 */
@property (nonatomic, assign, readonly) uint16_t type;

/*!
 @brief 通信计数器，手机端与智能设备之前的通信必须顺序执行，约束通过该计数器实现。每次收到的消息（指令）中都包含计数器，并且计数器的值必须大于上次记录的计数器的值，否则认为指令无效。例如：
 [App] --指令（counter = n）--> [智能设备] （设能设备收到App的指令后，先检查n）
 [App] <--反馈（counter = n+1）-- [智能设备]（若n合法，则将反馈中的counter增加1，即n+1，之后返回给App）
 
 ！！！TODO - counter的机制还需要优化，没有什么用
 */
@property (nonatomic, assign, readonly) uint16_t counter;

/*!
 @brief 协议数据，不同的协议类型，数据有所不同
 */
@property (nonatomic, copy, readonly) NSData *data;

/*!
 @brief 初始化基础协议对象
 @param cipher_ble_msg
                        加密的蓝牙协议
 @param nonce
                        加密随机数
 @param ltk
                        加密密钥
 @return 基础协议对象
 */
- (id) initWith:(NSData *)cipher_ble_msg nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
