//
//  ZCBLEController.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/16.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "M2MBLEController.h"
#import "ZCUnlockEncoder.h"
#import "ZCUnlockDecoder.h"

@interface ZCBLEController : M2MBLEController

@property (nonatomic, copy, getter=userId, setter=setUserId:) NSString *mUserId;

/*!
 @brief 智诚机柜锁开锁
 @param lock_num
            锁编号，取值[0-4]
 */
- (void) unlock:(int)lock_num;

@end
