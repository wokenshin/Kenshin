//
//  OtherTaskVC.m
//  GYBase
//
//  Created by doit on 16/6/6.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
 
     GCD执行任务的方法并非只有简单的同步调用方法和异步调用方法，还有其他一些常用方法：
     
     dispatch_apply():重复执行某个任务，但是注意这个方法没有办法异步执行（为了不阻塞线程可以使用dispatch_async()包装一下再执行）。
     dispatch_once():单次执行一个任务，此方法中的任务只会执行一次，重复调用也没办法重复执行（单例模式中常用此方法）。
     dispatch_time()：延迟一定的时间后执行。
     dispatch_barrier_async()：使用此方法创建的任务首先会查看队列中有没有别的任务要执行，如果有，则会等待已有任务执行完毕再执行；
     同时在此方法后添加的任务必须等待此方法中任务执行后才能执行。（利用这个方法可以控制执行顺序，例如前面先加载最后一张图片的需求就可
     以先使用这个方法将最后一张图片加载的操作添加到队列，然后调用dispatch_async()添加其他图片加载任务）
 
     dispatch_group_async()：实现对任务分组管理，如果一组任务全部完成可以通过dispatch_group_notify()方法获得完成通知
    （需要定义dispatch_group_t作为分组标识）。
 
 */

#import "OtherTaskVC.h"
#import "Tools.h"

@interface OtherTaskVC ()

@end

@implementation OtherTaskVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initOtherTaskUI];
    [Tools toast:@"内容太多 后期再看" andCuView:self.view];
    
}

- (void)initOtherTaskUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"其他任务方法";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
