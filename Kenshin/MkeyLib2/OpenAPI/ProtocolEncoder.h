//
//  ProtocolEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/5.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "M2MBLEProtocol.h"

/*!
 @brief 协议编码器
 */
@interface ProtocolEncoder : NSObject

/*!
 @brief 加密的蓝牙协议
 */
@property (nonatomic, strong) NSData *protocol;

/*!
 @brief 创建协议编码器（抽象方法，有具体协议子类实现）
 @param counter
                协议计数器
 @param nonce
                加密随机数
 @param ltk
                加密密钥（mKey密钥）
 @return 协议编码器对象
 */
- (id) initWithCounter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 创建加密且不带数据的蓝牙协议消息
 @param msg_type
                    消息类型，参见MSG_***定义
 @param counter
                    指令计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥（mKey密钥）
 @return 加密后的蓝牙协议消息
 */
- (NSData *) createEmptyDataMsg:(int16_t)msg_type counter:(int16_t) counter
                          nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
