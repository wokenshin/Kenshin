//
//  XMGNSOperationVC.m
//  GYBase
//
//  Created by kenshin on 16/8/30.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "XMGNSOperationVC.h"
#import "Tools.h"
#import "FXWOperation.h"
#import "NSOperationOtherVC.h"
#import "CtrlAndDependAndListener.h"
#import "NSOperationMsgVC.h"

@interface XMGNSOperationVC ()

@end

@implementation XMGNSOperationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"NSOperation";
    
}

#pragma mark NSInvocationOperation
- (IBAction)btnNSOperationBase:(id)sender
{
    /*
     第一个参数：目标对象
     第二个参数：选择器，要调用的方法
     第三个参数：方法要传递的参数
     */
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    //开启操作
    [op start];
    
    //上面开启的是主线程，感觉没什么卵用
}

#pragma mark NSBlockOperation
- (IBAction)btnBlockOperation:(id)sender
{
    //1.封装操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程中执行
        NSLog(@"1---%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2---%@", [NSThread currentThread]);
    }];
    
    //2.追加操作
    //在子线程中执行
    [op1 addExecutionBlock:^{
        NSLog(@"3---%@", [NSThread currentThread]);
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"4---%@", [NSThread currentThread]);
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"5---%@", [NSThread currentThread]);
    }];
    
    //开启操作
    [op start];
    [op1 start];
}

#pragma mark 自定义
- (IBAction)btnCustom:(id)sender
{
    FXWOperation *fxwOp = [[FXWOperation alloc] init];
    FXWOperation *fxwOp1 = [[FXWOperation alloc] init];

    [fxwOp start];
    [fxwOp1 start];
    
}


- (void)run
{
    NSLog(@"%s---%@", __func__, [NSThread currentThread]);
    
}

#pragma mark NSOperationQueue 1 NSInvocationOperation
- (IBAction)btnQueue:(id)sender
{
    /*
     有两种队列：
     
     主队列：凡是放在主队列里面的任务都在主线程中执行{NSOperationQueue mainQueue}
     非主队列：alloc init,同事具备了并发和串行的功能，默认是并发队列
     */
    
    //创建一个队列【默认是并发队列】
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //封装操作
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task3) object:nil];
    
    //添加操作到队列【在子线程中执行】
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
}

#pragma mark NSOperationQueue 2 NSBlockOperation
- (IBAction)btnQueue2:(id)sender
{
    //创建一个队列【默认是并发队列】
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task1-----%@", [ NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2-----%@", [ NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task3-----%@", [ NSThread currentThread]);
    }];
    
    //添加操作到队列【在子线程中执行】
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];

    
}

#pragma mark NSOperationQueue 3 NSBlockOperation
- (IBAction)btnQueue3:(id)sender
{
    //创建一个队列【默认是并发队列】
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //封装操作
    NSBlockOperation *op1 = [[NSBlockOperation alloc] init];
    [op1 addExecutionBlock:^{
        NSLog(@"task1-----%@", [ NSThread currentThread]);
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"task2-----%@", [ NSThread currentThread]);
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"task3-----%@", [ NSThread currentThread]);
    }];
    
    //添加操作到队列【在子线程中执行】
    [queue addOperation:op1];
    

}

#pragma mark NSOperationQueue 4 自定义
- (IBAction)btnQueue4:(id)sender
{
    //创建一个队列【默认是并发队列】
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    FXWOperation *fxwOp1 = [[FXWOperation alloc] init];
    FXWOperation *fxwOp2 = [[FXWOperation alloc] init];
    FXWOperation *fxwOp3 = [[FXWOperation alloc] init];
    
    //添加操作到队列【在子线程中执行】
    [queue addOperation:fxwOp1];
    [queue addOperation:fxwOp2];
    [queue addOperation:fxwOp3];
}

#pragma mark NSOperationQueue 4 简便写法
- (IBAction)btnQueueBlock:(id)sender
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //在子线程中并发执行
    [queue addOperationWithBlock:^{
        NSLog(@"task1-----%@", [ NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task2-----%@", [ NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"task3-----%@", [ NSThread currentThread]);
    }];
    
}


- (void)task1
{
    NSLog(@"task1-----%@", [ NSThread currentThread]);
    
}

- (void)task2
{
    NSLog(@"task2-----%@", [ NSThread currentThread]);
    
}

- (void)task3
{
    NSLog(@"task3-----%@", [ NSThread currentThread]);
    
}

- (IBAction)btnOther:(id)sender
{
    NSOperationOtherVC *vc = [NSOperationOtherVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//操作 依赖 监听
- (IBAction)btnCtrlAndDependAndListener:(id)sender
{
    CtrlAndDependAndListener *vc = [CtrlAndDependAndListener new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//线程间的通信
- (IBAction)btnMsgOp:(id)sender
{
    NSOperationMsgVC *vc = [NSOperationMsgVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
