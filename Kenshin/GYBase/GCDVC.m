//
//  GCDVC.m
//  GYBase
//
//  Created by doit on 16/6/6.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
      GCD(Grand Central Dispatch)是基于C语言开发的一套多线程开发机制，也是目前苹果官方推荐的多线程开发方法。前面也说过三种开发中GCD抽象层次最高，
   当然是用起来也最简单，只是它基于C语言开发，并不像NSOperation是面向对象的开发，而是完全面向过程的。对于熟悉C#异步调用的朋友对于GCD学习起来应该很快，
   因为它与C#中的异步调用基本是一样的。这种机制相比较于前面两种多线程开发方式最显著的优点就是它对于多核运算更加有效。
 
   GCD中也有一个类似于NSOperationQueue的队列，GCD统一管理整个队列中的任务。但是GCD中的队列分为并行队列和串行队列两类：
 
   串行队列：只有一个线程，加入到队列中的操作按添加顺序依次执行。
   并发队列：有多个线程，操作进来之后它会将这些队列安排在可用的处理器上，同时保证先进来的任务优先处理。
   其实在GCD中还有一个特殊队列就是主队列，用来执行主线程上的操作任务（从前面的演示中可以看到其实在NSOperation中也有一个主队列）。
 
 */

#import "GCDVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "SerialVC.h"
#import "ParallelVC.h"
#import "OtherTaskVC.h"

@interface GCDVC ()

@end

@implementation GCDVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initGCDUI];
    
}

- (void)initGCDUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"GCD目录";
    
    WS(ws);
    //串行队列
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 100, 44)];
    [btn setStyleGreen];
    [btn setTitle:@"串行队列" forState:UIControlStateNormal];
    btn.clickButtonBlock = ^(UIButtonK *b){
        SerialVC *vc = [SerialVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //并发队列
    UIButtonK *btn1 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10*2 + 44, 100, 44)];
    [btn1 setStyleGreen];
    [btn1 setTitle:@"并发队列" forState:UIControlStateNormal];
    btn1.clickButtonBlock = ^(UIButtonK *b){
        ParallelVC *vc = [ParallelVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //其他任务执行方法
    UIButtonK *btn2 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10*3 + 44*2, 100, 44)];
    [btn2 setStyleGreen];
    [btn2 setTitle:@"Other" forState:UIControlStateNormal];
    btn2.clickButtonBlock = ^(UIButtonK *b){
        OtherTaskVC *vc = [OtherTaskVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:btn];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
