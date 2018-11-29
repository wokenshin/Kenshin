//
//  CombinationEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/18.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 数字密码（触摸密码）相关指令编码器
 */
@interface CombinationEncoder : ProtocolEncoder

/*!
 @brief 初始化设置固定密码指令编码器
 @param comb
                    待设置的固定密码，字符串形式（例如：“123456”）
 @param counter
                    协议计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
@return 编码器对象
 */
- (id) initWithCombination:(NSString *)comb counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 更新一次性密码库
 */
- (id) initWithCounter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 初始化获取一次性密码指令编码器
 @param comb_id
                    获取的一次性密码的起始ID，每次指令获取4个一次性密码
 @param counter
                    协议计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
 @return 编码器对象
 */
- (id) initWithCombId:(uint8_t)comb_id counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
