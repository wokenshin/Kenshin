//
//  NSOperationOtherVC.m
//  GYBase
//
//  Created by kenshin on 16/9/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NSOperationOtherVC.h"
#import "Tools.h"
#import "FXWOperation.h"

@interface NSOperationOtherVC ()

@property (nonatomic, strong) NSOperationQueue  *queue;

@property (nonatomic, strong) NSOperationQueue *queueCus;
@end

@implementation NSOperationOtherVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"NSOperation的其他用法";
    
}

#pragma mark 最大并发数
- (IBAction)btnMaxBingFaNun:(id)sender
{
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    /*
     最大并发数：默认是并发队列
     如果最大并发数>1 就是并发队列
     如果最大并发数 == 1 就是串行队列
     */
    queue.maxConcurrentOperationCount = 1;
    
    //2.封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"5-----%@", [NSThread currentThread]);
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
    
}

#pragma mark 暂停任务
- (IBAction)btnStop:(id)sender
{
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    queue.maxConcurrentOperationCount = 1;//设置为串行队列
    
    //2.封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"1-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"2-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"3-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"4-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"5-----%@", [NSThread currentThread]);
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
    
    self.queue = queue;
    
    
}

#pragma mark 暂停、恢复 线程
- (IBAction)btnStopAndStar:(id)sender
{
    /*
     当暂停队列的时候，如果当前的某一个子线程正在执行，那么这个子线程会一直执行知道该子线程执行结束后才会暂停执行之后的子线程
     */
    if (self.queue != nil)
    {
        if (self.queue.suspended)
        {
            self.queue.suspended = NO;
            NSLog(@"恢复执行！");
        }
        else
        {
            self.queue.suspended = YES;
            NSLog(@"暂停执行！");
        }
        
    }
    
}

#pragma mark 取消队列
- (IBAction)btnCancelQueue:(id)sender
{
    /*
     取消队列：这是一个不可逆的过程
     当暂停队列的时候，如果当前的某一个子线程正在执行，那么这个子线程会一直执行知道该子线程执行结束后才会取消之后的所有子线程
     */
    [self.queue cancelAllOperations];
    
    
}

#pragma mark 开启自定义任务
- (IBAction)btnStarCustonOp:(id)sender
{
    _queueCus = [[NSOperationQueue alloc] init];
    
    FXWOperation *op = [FXWOperation new];
    [_queueCus addOperation:op];
    
}

#pragma mark  取消自定义任务
- (IBAction)btnCancelCustonOp:(id)sender
{
    [_queueCus cancelAllOperations];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
