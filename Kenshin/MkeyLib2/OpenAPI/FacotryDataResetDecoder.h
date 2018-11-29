//
//  FacotryDataResetDecoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/8.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolDecoder.h"

/*!
 @brief 设备重置反馈解码器
 */
@interface FacotryDataResetDecoder : ProtocolDecoder

/*!
 @brief 标识是否重置成功
 */
@property (nonatomic, assign, readonly) BOOL isSuccess;

- (id) initWithData:(NSData *)data;

@end
