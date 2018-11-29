//
//  ReadLogEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/9.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 日志读取指令编码器
 */
@interface ReadLogEncoder : ProtocolEncoder

/*!
 @brief 初始化指令编码器
 @param index
                    日志读取起点，即第一条待读取日志的ID
 @param dev_type
                    设备类型，参见M2MBLEDevice中的TYPE_***定义
 @param counter
                    协议计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
 @return 编码器对象
 */
- (id) initWithIndex:(int)index devicetype:(int)dev_type counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
