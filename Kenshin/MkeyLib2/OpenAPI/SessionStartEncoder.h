//
//  SessionStartEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/5.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 创建加密会话指令编码器
 */
@interface SessionStartEncoder : ProtocolEncoder

/*!
 @brief 初始化指令编码器对象，使用自定义的salt
 @param pin
                mKey ID（PIN#）
 @param enc_salt
                验证会话的salt
 @return 编码器对象
 */
- (id) initWith:(uint8_t)pin data:(NSData *)enc_salt;

/*!
 @brief 初始化指令编码器对象，使用默认的salt
 @param pin
                mKey ID（PIN#）
 @return 编码器对象
 */
- (id) initWith:(uint8_t)pin;

@end
