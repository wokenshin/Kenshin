//
//  ThreadSafeVC.m
//  GYBase
//
//  Created by kenshin on 16/8/28.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ThreadSafeVC.h"

@interface ThreadSafeVC ()

//售票员01
@property (nonatomic, strong) NSThread  *thread01;

//售票员02
@property (nonatomic, strong) NSThread  *thread02;

//售票员03
@property (nonatomic, strong) NSThread  *thread03;

//火车票
@property (nonatomic, assign) NSInteger     totalTicket;
@end

@implementation ThreadSafeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"线程安全";
    
    _totalTicket = 100;//假设有100张火车票
    [self createSubThreadsSaleTicket];
    
    
}

//创建子线程，售票
- (void)createSubThreadsSaleTicket
{
    _thread01 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    _thread02 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    _thread03 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    
    [_thread01 setName:@"售票员01"];
    [_thread02 setName:@"售票员02"];
    [_thread03 setName:@"售票员03"];
    
    //开启线程
    [_thread01 start];
    [_thread02 start];
    [_thread03 start];
    
}

- (void)saleTicket
{
    while (true)
    {
        //添加 互斥锁
        @synchronized (self)//这里有一个疑问 就是我将_totalTicket 设置成@property(atomic,xxxxx)的时候，关闭了这里的同步锁，发现依然线程不安全
        {
            [NSThread sleepForTimeInterval:0.03];
            if (_totalTicket > 0)
            {
                _totalTicket--;
                NSLog(@"%----@---卖出了---%zd张---火车票", [NSThread currentThread].name, _totalTicket);
                
            }
            else
            {
                break;
            }
        }
    }
    
}

@end
