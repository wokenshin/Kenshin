//
//  M2MBleScanner.h
//  iOSProject
//
//  Created by 王江 on 2016/10/30.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol M2MBLEScanCallback <NSObject>
@optional

- (void) onDeviceDiscovered:(NSString *)mac name:(NSString *)name rssi:(int)rssi;

@end

@interface M2MBLEScanner : NSObject
{
    id <M2MBLEScanCallback> _delegate;
}

@property (nonatomic, strong) id delegate;

- (id) initWith:(CBCentralManager *)cb_manager;
- (void) startScan;
- (void) stopScan;
- (BOOL) isScanning;

@end
