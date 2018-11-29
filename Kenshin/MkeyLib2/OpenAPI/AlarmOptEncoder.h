//
//  AlarmOptEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/7.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 警报指令编码器
 */
@interface AlarmOptEncoder : ProtocolEncoder

/*!
 @brief 根据制定的操作类型（开警报、关警报）初始化指令编码器
 @param counter
                    协议计数器
 @param on_off
                    开关标识，YES - 开警报，NO - 关警报
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
 @return 编码器对象
 */
- (id) initWithCounter:(int16_t)counter opt:(BOOL)on_off nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
