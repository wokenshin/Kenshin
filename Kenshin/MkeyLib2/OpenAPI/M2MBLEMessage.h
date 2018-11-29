//
//  M2MBLEMessage.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/5.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <CommonCrypto/CommonCryptoError.h>
#import <CommonCrypto/CommonCryptor.h>
/*!
 @brief 加密消息
 */
@interface M2MBLEMessage : NSObject
/*!
 @brief 用PBKDF2算法生成混淆密钥
 @param data
            用于生成密钥的字符串
 @return
            生成的混淆密钥
 */
+ (NSData *) genPBKDF2:(NSString *)data;
/*!
 @brief 十六进制字符串转换为二进制数据
 @param hex
            十六进制字符串
 @return 二进制数据
 */
+ (NSData *) hex2Bytes:(NSString *)hex;

+ (NSString *) bytes2Hex:(NSData *)bytes;

+ (NSData *) getMsgSalt;

/*!
 @brief 加密通信消息
 @param plain_msg
            待加密消息
 @param nonce
            随机数
 @param ltk
            加密密钥
 @return 加密后的数据
 */
+ (NSData *) encryptMsg:(NSDate *)plain_msg nonce:(NSDate *)nonce ltk:(NSDate *)ltk;

+ (NSData *) decryptMsg:(NSData *)cipher_msg nonce:(NSData *)nonce ltk:(NSData *)ltk;

+ (NSData *) deriveNewmKey:(NSData *)nonce ltk:(NSData *)ltk;

+ (NSData *) calcMac:(NSData *)msg nonce:(NSData *)nonce ltk:(NSData *)ltk;

+ (BOOL) validateMac:(NSData *)msg mac:(NSData *)mac nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
