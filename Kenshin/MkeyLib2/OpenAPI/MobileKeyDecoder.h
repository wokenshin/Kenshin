//
//  MobileKeyDecoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/18.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolDecoder.h"

/*!
 @brief mKey（手机钥匙）相关反馈解码器
 */
@interface MobileKeyDecoder : ProtocolDecoder

/*!
 @brief 标识操作是否成功
 */
@property (nonatomic, assign, readonly) BOOL isSuccess;

/*!
 @brief mKey ID（PIN#）
 */
@property (nonatomic, assign, readonly) int keyId;

/*!
 @brief 根据反馈类型初始化解码器
 @param type
                    反馈类型，参见M2MBLEProtocol中FB_***定义
 @param data
                    明文协议数据
 @return 解码器对象
 */
- (id) initWithType:(int)type data:(NSData *)data;

@end
