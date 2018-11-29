//
//  JiaSuJiTwo.m
//  GYBase
//
//  Created by kenshin on 16/9/8.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 从IOS4开始，苹果专门封装了一个和运动相关的框架：CoreMotion框架
 可以通过该框架来获取加速计的数值
 有两种实现方式：
 
 push方式：实时采集所有数据（采集频率高）
 创建运动管理者对象
 判断加速计是否可用
 设置采样间隔
 开始采集数据
 
 pull方式：在有需要的时候去获取数据
 创建运动管理者对象
 判断加速计是否可用
 开始采样
 在需要时通过运动管理者去获取数据
 
 
 
 */

#import "JiaSuJiTwo.h"
#import "Tools.h"
#import <CoreMotion/CoreMotion.h>

@interface JiaSuJiTwo ()

@property (nonatomic, strong) CMMotionManager *mgr;
@end

@implementation JiaSuJiTwo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"push-实时获取";
    [self pushWay];
    
}

#pragma mark push方式采集加速计数据
- (void)pushWay
{
    //1创建运动管理者[这里不能使用局部变量]
    //本程序中采用懒加载方式
    
    //2判断加速计是否可用
    if (!self.mgr.isAccelerometerAvailable)
    {
        NSLog(@"加速计不可用！");
        return;
    }
    
    //3设置采样间隔
    self.mgr.accelerometerUpdateInterval = 0.3; //0.3秒获取一次数据
    
    //4开始采集数据
    [self.mgr startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSLog(@"push----x:%f  y:%f   z:%f",accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
        
    }];

}

#pragma mark 懒加载
- (CMMotionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CMMotionManager alloc] init];
    }
    return _mgr;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
