//
//  ZWNSThreadVC.m
//  GYBase
//
//  Created by kenshin on 16/8/24.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ZWNSThreadVC.h"

@interface ZWNSThreadVC ()

@end

@implementation ZWNSThreadVC

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSThread
    
    //第一种创建线程的方式
//    [self createNSThreadWay_one];
    
    //第二种创建线程的方式
//    [self createNSThreadWay_two];
    
    //第三种创建线程的方式
    [self createNSThreadWay_three];
}

//第三种创建线程的方式
- (void)createNSThreadWay_three
{
    
    //开启一条后台线程
    [self performSelectorInBackground:@selector(run) withObject:nil];
    
}

//第二种创建线程的方式
- (void)createNSThreadWay_two
{
    /*
     第一个参数：选择器，调用哪个方法
     第二个参数：目标对象【谁在调用当前的方法】
     第三个参数：选择器设置调用方法的参数
     */
    
    //分配一个线程出来，该方法在调用的时候 该线程就立即开启了
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    
}

//第一种创建线程的方式:
- (void)createNSThreadWay_one
{
    //打印当前线程：这里是 主线程
    NSLog(@"_____%@_____", [NSThread currentThread]);
    
    /*
     第一个参数：目标对象【谁在调用当前的方法】
     第二个参数：选择器，调用哪个方法
     第三个参数：选择器设置调用方法的参数
     */
    
    //这种创建线程的方式 必须调用 star方法才开启线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    //开启线程
    [thread start];
    
}

- (void)run
{
    NSLog(@"----%@----", [NSThread currentThread]);
    
}
@end
