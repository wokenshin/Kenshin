//
//  ProtocolDecoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/8.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "M2MBLEProtocol.h"

/*!
 @brief 协议解码器
 */
@interface ProtocolDecoder : NSObject

/*!
 @brief 初始化协议解码器（抽象方法，由子类实现）
 @param data
                明文的协议数据
 @return 解码器对象
 */
- (id) initWithData:(NSData *)data;

@end
