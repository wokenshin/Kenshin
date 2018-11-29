//
//  FingerprintEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/20.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 指纹相关指令编码器
 */
@interface FingerprintEncoder : ProtocolEncoder

/*!
 @brief 初始化录入指纹指令编码器
 */
- (id) initWithCounter4Record:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 初始化重置指纹指令编码器
 */
- (id) initWithCounter4Reset:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 初始化删除指纹指令编码器
 @param fpid
                待删除指纹ID
 */
- (id) initWithId:(uint16_t)fpid counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
