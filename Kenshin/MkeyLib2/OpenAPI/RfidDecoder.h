//
//  RfidDecoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/20.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolDecoder.h"
#import "RfidEncoder.h"

@interface RfidDecoder : ProtocolDecoder

@property (nonatomic, assign, readonly) uint8_t optType;

@property (nonatomic, assign, readonly) BOOL isSuccess;

/*!
 @brief 卡片ID
 */
@property (nonatomic, assign, readonly) int flashId;

/*!
 @brief 状态码
 */
@property (nonatomic, assign, readonly) int status;

@end
