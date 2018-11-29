//
//  LiaoJieThreadVC.m
//  GYBase
//
//  Created by kenshin on 16/8/23.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "LiaoJieThreadVC.h"

@interface LiaoJieThreadVC ()

@end

@implementation LiaoJieThreadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"耗时操作不要在主线程执行！";
    
}

//当点击按钮的时候 其他UI的线程就无法执行了
- (IBAction)btnPress:(id)sender {
    
    //在主线程中执行耗时的操作，将会阻塞UI，因为操作UI的线程就是主线程
    for (NSInteger i = 0; i < 100000; i++) {
        NSLog(@"%@------%zd",[NSThread currentThread], i);
    }
}

@end
