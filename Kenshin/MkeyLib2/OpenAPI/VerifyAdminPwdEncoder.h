//
//  VerifyAdminPwdEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/8.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"
#import "M2MBLEMessage.h"

/*!
 @brief 验证管理员（mKey）密钥指令编码器
 */
@interface VerifyAdminPwdEncoder : ProtocolEncoder

/*!
 @brief 往nonce characteristic中写入的数据
 */
@property (getter=nonceCharProtocol, readonly, nonatomic, copy) NSData *pwdData;

/*!
 @brief 往command characteristic中写入的指令
 */
@property (getter=cmdCharProtocol, readonly, nonatomic, copy) NSData *cmdMsg;

/*!
 @brief 初始化指令编码器
 @param pwd
                    管理员旧密码（字符串形式，例如：“aaaaaaaa”）
 @param counter
                    协议计数器
 @param nonce
                    加密随机数
 @param ltk
                    加密密钥
 @return 编码器对象
 */
- (id) initWithPwd:(NSString *)pwd counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 根据协议类型，创建编码器，用于VerifyAdminPwdEncoder和SetAdminPwdEncoder
 */
- (void) initProtocols:(uint16_t)type pwd:(NSString *)pwd counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
