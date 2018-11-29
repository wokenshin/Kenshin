//
//  CtrlAndDependAndListener.m
//  GYBase
//
//  Created by kenshin on 16/9/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CtrlAndDependAndListener.h"

@interface CtrlAndDependAndListener ()

@end

@implementation CtrlAndDependAndListener

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"操作-依赖-监听";
    
}


#pragma mark 操作依赖
- (IBAction)btnActionOne:(id)sender
{
    //1.创建队列
    NSOperationQueue *queue = [NSOperationQueue new];
    
    //2.封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task1-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task3-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task4-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task5-----%@", [NSThread currentThread]);
    }];
    
    //设置依赖[在添加操作依赖的时候要注意避免死循环：不能循环依赖，即 彼此依赖 op1 依赖于 op5, op5又依赖于op1]
    //表示op1 在 op5 之后执行 类似于 GCD的栅栏函数
    [op1 addDependency:op5];
    [op1 addDependency:op4];
    
    //.添加操作到队列 执行任务
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
    
}

#pragma mark 操作依赖 【跨队列设置 操作依赖】
- (IBAction)btnOpDen:(id)sender
{
    //1.创建队列
    NSOperationQueue *queue  = [NSOperationQueue new];
    NSOperationQueue *queue2 = [NSOperationQueue new];
    //2.封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task1-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task3-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task4-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task5-----%@", [NSThread currentThread]);
    }];
    
    //设置依赖[在添加操作依赖的时候要注意避免死循环：不能循环依赖，即 彼此依赖 op1 依赖于 op5, op5又依赖于op1]
    //表示op1 在 op5 之后执行 类似于 GCD的栅栏函数
    [op1 addDependency:op5];
    
    
    //.添加操作到队列 执行任务
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue2 addOperation:op5];
    
}

#pragma mark 操作监听
- (IBAction)btnOpListener:(id)sender
{
    //用在这样的需求：下载完毕后 提示用户下载完毕
    //就是在多线程执行任务完成的时候 监听一下
    
    //1.创建队列
    NSOperationQueue *queue = [NSOperationQueue new];
    NSOperationQueue *queue2 = [NSOperationQueue new];
    //2.封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task1-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task3-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task4-----%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task5-----%@", [NSThread currentThread]);
    }];
    
    //设置依赖[在添加操作依赖的时候要注意避免死循环：不能循环依赖，即 彼此依赖 op1 依赖于 op5, op5又依赖于op1]
    //表示op1 在 op5 之后执行 类似于 GCD的栅栏函数
    [op1 addDependency:op5];
    
    
    op4.completionBlock = ^{
        NSLog(@"op4已经完成了，在这里实现了监听----- %@", [NSThread currentThread]);
        
    };
    
    //.添加操作到队列 执行任务
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue2 addOperation:op5];

    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
