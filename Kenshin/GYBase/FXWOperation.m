//
//  FXWOperation.m
//  GYBase
//
//  Created by kenshin on 16/9/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "FXWOperation.h"

@implementation FXWOperation

//重写 main方法 封装操作
- (void)main
{
    NSLog(@"---main---%@", [NSThread currentThread]);
    
    //当自定义线程被添加到队列后 系统会去调用 star方法 然后就开启了该线程。
    //系统就会去调用这里的main方法进行执行
    
    //当我们调用了队列的 cancelAllOperations方法时候 这里会有一个变量用于记录当前线程是否被取消
    //self.isCancelled
    
    //由于这里的main方法是整个线程执行的任务 所以如果当我们在外界调用了 cancelAllOperations方法后
    //这里的main方法仍然会继续执行 知道完全执行结束。 如果我们要让其停止运行的话 就需要在一些节点进行判断
    //通过 self.isCancelled 来判断是否还要继续执行
    
    //如下
    
    for (int i = 0; i < 1000; i++) {
        NSLog(@"task 1 -----%zd---- %@", i, [NSThread currentThread]);
    }
    
    if (self.isCancelled) {
        return;
    }
    for (int i = 0; i < 1000; i++) {
        NSLog(@"task 2 -----%zd---- %@", i, [NSThread currentThread]);
    }
    
    if (self.isCancelled) {
        return;
    }
    for (int i = 0; i < 1000; i++) {
        NSLog(@"task 3 -----%zd---- %@", i, [NSThread currentThread]);
    }
    
}

@end
