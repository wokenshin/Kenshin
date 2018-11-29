//
//  CombinationDecoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/19.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolDecoder.h"
#import "M2Mkey.h"

/*!
 @brief 数字密码相关反馈解码器
 */
@interface CombinationDecoder : ProtocolDecoder

/*!
 @brief 标识操作是否成功
 */
@property (nonatomic, assign, readonly) BOOL isSuccess;

/*!
 @brief 一次性密码库（数组形式）
 */
@property (nonatomic, strong, readonly) NSArray *combinations;

/*!
 @brief 根据反馈类型初始化解码器
 @param fb_type
                    反馈类型，参见M2MBLEProtocol中FB_***定义
 @param data
                    明文协议数据
 @return 解码器对象
 */
- (id) initWithType:(uint16_t)fb_type data:(NSData *)data;

@end
