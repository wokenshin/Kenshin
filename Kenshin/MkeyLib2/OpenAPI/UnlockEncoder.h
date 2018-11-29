//
//  UnlockEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/6.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

/*!
 @brief 开锁指令编码器
 */
@interface UnlockEncoder : ProtocolEncoder

- (id) initWithCounter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
