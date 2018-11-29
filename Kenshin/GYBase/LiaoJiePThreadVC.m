//
//  LiaoJiePThreadVC.m
//  GYBase
//
//  Created by kenshin on 16/8/23.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "LiaoJiePThreadVC.h"
#import <pthread.h>

@interface LiaoJiePThreadVC ()

@end

@implementation LiaoJiePThreadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"子线程执行耗时操作";
    
}

- (IBAction)btnClick:(id)sender {
    
    NSLog(@"%@", [NSThread mainThread]);
    
    //创建线程
    pthread_t thread;
    /*
     第一个参数：线程对象
     第二个参数：线程属性
     第三个参数：<#void *(*)(void *)#>（指向函数的指针）
     第四个参数：函数的参数
     */
    pthread_create(&thread, NULL, run, NULL);
    
}

//由于这里的操作是在创建的子线程中执行的，所以当点击按钮的时候，UI并不会被阻塞，因为操作UI的主线程并没有被占用
void *run(void *param)
{
    for (int i = 0; i < 100000; i++) {
        NSLog(@"%@-----%d", [NSThread currentThread], i);
    }
    return NULL;
    
}
@end
