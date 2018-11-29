//
//  GetStatusEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/5.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 获取设备状态指令编码器
 */
@interface GetStatusEncoder : ProtocolEncoder

- (id) initWithCounter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
