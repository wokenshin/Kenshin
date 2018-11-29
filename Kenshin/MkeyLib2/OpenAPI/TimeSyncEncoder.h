//
//  TimeSyncEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/8.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 时间同步指令编码器
 */
@interface TimeSyncEncoder : ProtocolEncoder

/*!
 @brief 根据时间和时区初始化时间同步指令编码器
 @param timestamp
                        UNIX时间戳，单位s（秒）
 @param timezone
                        时区，东时区为正值，西时区为负值
 @param counter
                        协议计数器
 @param nonce
                        加密随机数
 @param ltk
                        加密密钥
 @return 编码器对象
 */
- (id) initWithTime:(uint32_t)timestamp timezone:(int8_t)timezone
            counter:(uint16_t)counter nonce:(NSData *)nonce
                ltk:(NSData *)ltk;

@end
