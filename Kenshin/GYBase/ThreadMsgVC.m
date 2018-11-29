//
//  ThreadMsgVC.m
//  GYBase
//
//  Created by kenshin on 16/8/27.
//  Copyright © 2016年 kenshin. All rights reserved.
/*

    耗时的操作 我们需要在子线程中处理，这样是为了避免UI阻塞。因为操作UI的现在就是主线程，所以耗时操作不能在主线程中执行
    比如下载文件，本例就是。 我们创建一个子线程用于下载图片，当图片下载完毕后，我们再调用主线程来更新UI。这里就涉及到了线程间的通信
 
 */

#import "ThreadMsgVC.h"

@interface ThreadMsgVC ()

@end

@implementation ThreadMsgVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"下载图片";
    [Tools toast:@"看代码" andCuView:self.view];
    
    //开启一个子线程用来下载图片
    //[NSThread detachNewThreadSelector:@selector(downloadImg) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(downloadImg2) toTarget:self withObject:nil];
}


- (void)downloadImg2
{
    //下载图片第一步 获取url
    NSURL *url = [NSURL URLWithString:@"http://i5.hexunimg.cn/2015-06-16/176773348.jpg"];//未来穗香
    
    //下载图片第二步 下载图片
    CFTimeInterval star = CFAbsoluteTimeGetCurrent();//获取当前的绝对时间[C语言]
    NSData *data = [NSData dataWithContentsOfURL:url];
    CFTimeInterval end  = CFAbsoluteTimeGetCurrent();
    NSLog(@"下载图片所用的时间是：%f", end - star);
    
    //把二进制数据转换成图片
    UIImage *image = [UIImage imageWithData:data];
    
    //回到主线程 刷新UI
    //waitUntilDone：是否等当前线程方法执行完之后再继续执行之后的方法
    [self performSelectorOnMainThread:@selector(showIamge:) withObject:image waitUntilDone:YES];
    
}

- (void)downloadImg
{
    //下载图片第一步 获取url
    NSURL *url = [NSURL URLWithString:@"http://i5.hexunimg.cn/2015-06-16/176773348.jpg"];
    
    //下载图片第二步 下载图片
    NSDate *star = [NSDate date];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDate *end  = [NSDate date];
    NSLog(@"下载图片所用的时间是：%f", [end timeIntervalSinceDate:star]);
    
    //把二进制数据转换成图片
    UIImage *image = [UIImage imageWithData:data];
    
    //回到主线程 刷新UI
    //waitUntilDone：是否等当前线程方法执行完之后再继续执行之后的方法
    [self performSelectorOnMainThread:@selector(showIamge:) withObject:image waitUntilDone:YES];
    
}

- (void)showIamge:(UIImage *)img
{
    _imgView.image = img;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
