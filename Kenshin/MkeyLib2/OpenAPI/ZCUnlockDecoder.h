//
//  ZCUnlockDecoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/16.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolDecoder.h"

/*!
 @brief 智诚机柜锁开锁反馈解码器
 */
@interface ZCUnlockDecoder : ProtocolDecoder

@property (nonatomic, assign, readonly) int8_t lockNum;
@property (nonatomic, assign, readonly) int8_t result;

@end
