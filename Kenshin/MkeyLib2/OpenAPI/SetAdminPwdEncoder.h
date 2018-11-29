//
//  SetAdminPwdEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/8.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "VerifyAdminPwdEncoder.h"

/*!
 @brief 修改管理员密码指令编码器
 */
@interface SetAdminPwdEncoder : VerifyAdminPwdEncoder

/*!
 @brief 初始化指令编码器
 @param pwd
                    新的管理员密码，字符串类型（例如：“aaaaaaaa”）
 @param counter
                    协议计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
 @return 编码器对象
 */
- (id) initWithPwd:(NSString *)pwd counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
