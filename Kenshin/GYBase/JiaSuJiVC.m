//
//  JiaSuJiVC.m
//  GYBase
//
//  Created by kenshin on 16/9/8.
//  Copyright © 2016年 kenshin. All rights reserved.
//
#import "JiaSuJiVC.h"
#import "Tools.h"

@interface JiaSuJiVC ()<UIAccelerometerDelegate>

@end

@implementation JiaSuJiVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"加速计一";
    [self oldWay];
    
}


- (void)oldWay
{
    //old API
    //下面这种方式的API已经比较老了 但是调用起来比较简单
    //获取UIAccelerometer对象
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
     
    //设置代理
    accelerometer.delegate = self; // <UIAccelerometerDelegate>

    //设置采样间隔 多久获取一次
    accelerometer.updateInterval = 1.0;
 
}
 
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
     NSLog(@"x:%f  y:%f   z:%f", acceleration.x, acceleration.y, acceleration.z);
 
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
