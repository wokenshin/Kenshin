//
//  M2MLog.h
//  OpenAPI
//
//  Created by 王江 on 2016/11/9.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "M2MBLEDevice.h"
#import "M2MBLEProtocol.h"

@interface M2MLog : NSObject

/*!
 @brief 日志ID
 */
@property (readonly) int logId;

/*!
 @brief 操作时间
 */
@property (readonly) long optTime;

/*!
 @brief 操作类型
 */
@property (readonly) int optType;

/*!
 @brief 钥匙ID
 */
@property (readonly) int keyId;

@property (readonly, nonatomic, copy) NSData *rawData;

//@property (getter=optType, readonly) OptType mOptType;
//
//@property (getter=userType, readonly) UserType mUserType;
//
//@property (getter=userID, readonly) int mUserID;
//
//@property (getter=rawData, readonly, nonatomic, copy) NSData *mRawData;

- (id) initWithRawData:(NSData *)log devtype:(int)dev_type;

@end
