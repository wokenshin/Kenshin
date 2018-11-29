//
//  ZCUnlockEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/16.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 智诚机柜锁开锁指令编码器
 */
@interface ZCUnlockEncoder : ProtocolEncoder

/*!
 @brief 初始化编码器
 @param lock_num
                    锁编号
 @param counter
                    指令计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
 @return description
 */
- (id) initWithLockNum:(uint8_t)lock_num counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
