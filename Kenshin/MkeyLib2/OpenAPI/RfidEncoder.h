//
//  RfidEncoder.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/20.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "ProtocolEncoder.h"

extern const uint8_t RFID_RUN; // RFID读卡器进入常规模式
extern const uint8_t RFID_ADD; // RFID读卡器进入录入模式
extern const uint8_t RFID_DELETE; // 删除录入的卡片
extern const uint8_t RFID_RESET; // 重置所有录入的卡片
extern const uint8_t RFID_READ; // 录入卡片

@interface RfidEncoder : ProtocolEncoder

/*!
 @brief 进入添加模式
 */
- (id) initWithCounter4Add:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 进入验证模式
 */
- (id) initWithCounter4Run:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 重置所有录入的卡
 */
- (id) initWithCounter4Reset:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

/*!
 @brief 删除卡片
 */
- (id) initWithFlashId:(uint8_t)flash_id counter:(int16_t)counter nonce:(NSData *)nonce ltk:(NSData *)ltk;

@end
