//
//  TuoLuoPullVC.m
//  GYBase
//
//  Created by kenshin on 16/9/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "TuoLuoPullVC.h"
#import "Tools.h"
#import <CoreMotion/CoreMotion.h>

@interface TuoLuoPullVC ()

@property (nonatomic, strong) CMMotionManager   *mgr;
@end

@implementation TuoLuoPullVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pullWay];
    
}

- (void)pullWay
{
    //1.创建运动管理者 我这里使用懒加载的方式
    
    //2.判断陀螺仪是否可用 Gyro
    if (!self.mgr.isGyroAvailable)
    {
        NSLog(@"陀螺仪不可用");
        return;
    }
    
    //3.开始采样
    [self.mgr startGyroUpdates];
    
}

#pragma mark 懒加载
- (CMMotionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CMMotionManager alloc] init];
    }
    return _mgr;
    
}

//采集数据
- (IBAction)getData:(id)sender
{
    CMRotationRate rate = self.mgr.gyroData.rotationRate;
    NSLog(@"x:%f  y:%f  z:%f", rate.x, rate.y, rate.z);
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
