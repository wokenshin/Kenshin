//
//  JiaSuJiPull.m
//  GYBase
//
//  Created by kenshin on 16/9/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "JiaSuJiPull.h"
#import <CoreMotion/CoreMotion.h>

@interface JiaSuJiPull ()

@property (nonatomic, strong) CMMotionManager       *mgr;
@end

@implementation JiaSuJiPull

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"pull-获取一次";
    [self pullWay];
    
}

#pragma mark pull方式 采集加速计数据
- (void)pullWay
{
    //1.判断加速计是否可用
    if (!self.mgr.isAccelerometerAvailable)
    {
        NSLog(@"加速计不可用");
        return;
    }
    
    //开始采样
    [self.mgr startAccelerometerUpdates];
    
}

#pragma mark 获取数据
- (IBAction)getJiaSuJiData:(id)sender
{
    CMAcceleration acceleration = self.mgr.accelerometerData.acceleration;
    NSLog(@"push----x:%f  y:%f   z:%f",acceleration.x, acceleration.y, acceleration.z);
    
}


- (CMMotionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CMMotionManager alloc] init];
    }
    return _mgr;
    
}

@end
