//
//  TuoLuoPushVC.m
//  GYBase
//
//  Created by kenshin on 16/9/9.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    陀螺仪信息的获取
 
    通过CoreMotion框架获取
    两种方式来获取
    
    push方式
    创建运动管理者
    判断陀螺仪是否可用
    设置采样间隔
    开始采样
 
    pull方式
    创建运动管理者
    判断陀螺仪是否可用
    开始采样
    在需要时通过运动管理者获取数据
 
 */

#import "TuoLuoPushVC.h"
#import "Tools.h"
#import <CoreMotion/CoreMotion.h>

@interface TuoLuoPushVC ()

@property (nonatomic, strong) CMMotionManager       *mgr;
@end

@implementation TuoLuoPushVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pushWay];
    
}

- (void)pushWay
{
    //1.创建运动管理者 我这里使用懒加载的方式
    
    //2.判断陀螺仪是否可用 Gyro
    if (!self.mgr.isGyroAvailable)
    {
        NSLog(@"陀螺仪不可用");
        return;
    }
    
    //3.设置采样间隔
    self.mgr.gyroUpdateInterval = 0.3;
    
    //4.开始采样
    [self.mgr startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            return ;
        }
        
        CMRotationRate rate = gyroData.rotationRate;
        NSLog(@"x:%f  y:%f  z:%f", rate.x, rate.y, rate.z);
        
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
