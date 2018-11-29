//
//  FingerprintDecoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/20.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolDecoder.h"

typedef enum {
    FE_RECORD_BAD_IMG, // 图像质量差
    FE_RECORD_TIMEOUT, // 录入超时
    FE_RECORD_CONFLICT, // 指纹已录入
    FE_DELETE_INVALID_ID, // 无效的指纹ID
    FE_DELETE_NOT_EXIST, // 指纹不存在
    FE_INTERNAL_ERROR // 内部错误
}FingerprintError;

/*!
 @brief 指纹相关反馈解码器
 */
@interface FingerprintDecoder : ProtocolDecoder

@property (nonatomic, assign, readonly) BOOL isSuccess;

/*!
 @brief 在录入指纹时，标识是第几次采集指纹
 */
@property (nonatomic, assign, readonly) int recordTime;

/*!
 @brief 指纹ID
 */
@property (nonatomic, assign, readonly) int fpid;

/*!
 @brief 指纹总数
 */
@property (nonatomic, assign, readonly) int totalNum;

/*!
 @brief 操作错误
 */
@property (getter=error, readonly) FingerprintError error;

/*!
 @brief 根据反馈类型，初始化解码器
 @param fb_type
                        反馈类型，参见M2MBLEProtocol中FB_***定义
 @param data
                        明文协议数据
 @return 解码器对象
 */
- (id) initWithType:(uint16_t)fb_type Data:(NSData *)data;

@end
