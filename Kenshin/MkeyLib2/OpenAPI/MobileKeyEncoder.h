//
//  MobileKeyEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/18.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief mKey（手机钥匙）相关指令编码器
 */
@interface MobileKeyEncoder : ProtocolEncoder

/*!
 @brief 初始化获取mKey指令编码器
 @param auth_end
                    授权截止日期，UNIX时间戳，单位s（秒）
 @param counter
                    协议计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
 @return 编码器对象
 */
- (id) initWithAuthEnd:(uint32_t)auth_end counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 初始化重置mKey指令编码器
 */
- (id) initWithCounter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 初始化删除mKey指令编码器
 @param pin
                待删除mKey的ID（PIN#）
 */
- (id) initWithPin:(uint8_t)pin counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
