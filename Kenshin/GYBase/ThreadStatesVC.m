//
//  ThreadStatesVC.m
//  GYBase
//
//  Created by kenshin on 16/8/24.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ThreadStatesVC.h"

@interface ThreadStatesVC ()

@end

@implementation ThreadStatesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"线程的状态";
    [Tools toast:@"点击空白处触发方法" andCuView:self.view];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建线程
    NSThread *threaf = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    //开启线程
    [threaf start];
    
}

- (void)run
{
    NSLog(@"%@", [NSThread currentThread]);
    
    //杀死子线程
//    [NSThread exit];
//    NSLog(@"这里的代码不会被执行，因为线程已经被弄死了");
    
    //让线程休眠一段时间   3s
    [NSThread sleepForTimeInterval:3.0];
     NSLog(@"这里的代码需要等线程休眠时间结束后才会执行");
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
