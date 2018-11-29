//
//  M2Mkey.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/18.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief 钥匙通用模型，包括mKey、sKey、Combination（数字密码）、RFID卡、指纹
 */
@interface M2Mkey : NSObject

/*!
 @brief 钥匙ID，具体代表含义如下：
 mKey - PIN#
 sKey - sKey编号
 Combination - 密码编号
 RFID - 卡ID
 指纹 - 指纹ID
 */
@property (nonatomic, assign) int keyId;

/*!
 @brief 钥匙数据，具体代表含义如下：
 mKey - ltk十六进制字符串
 sKey - ROM ID
 Combination - 密码字符串
 RFID - 无数据
 指纹 - 无数据
 */
@property (nonatomic, copy) NSString *keyData;

@end
