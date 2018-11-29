//
//  GCDFuntionsVC.m
//  GYBase
//
//  Created by kenshin on 16/8/28.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "GCDFuntionsVC.h"

@interface GCDFuntionsVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewA;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewB;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAB;

@end

@implementation GCDFuntionsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"GCD常用函数";
    
}

//栅栏函数--控制顺序 :使用栅栏函数 不能使用全局的并发队列
#pragma mark 栅栏函数
- (IBAction)btn_fun_1:(id)sender
{
    //1.创建队列(并发队列)
    dispatch_queue_t queue = dispatch_queue_create("downloadqueue", DISPATCH_QUEUE_CONCURRENT);
    
    //异步函数
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            NSLog(@"%zd---download1----%@", i, [NSThread currentThread]);
        }
        
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            NSLog(@"%zd---download2----%@", i, [NSThread currentThread]);
        }
        
    });
    
    //栅栏函数【作用就是用来分割任务的，栅栏函数之前的先执行，栅栏函数之后的后执行】
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            NSLog(@"%zd---我是一个栅栏函数----%@", i, [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            NSLog(@"%zd---download3----%@", i, [NSThread currentThread]);
        }
        
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            NSLog(@"%zd---download4----%@", i, [NSThread currentThread]);
        }
        
    });
    
    
}

#pragma mark 延迟执行 使用最多
- (IBAction)btn_fun_2:(id)sender
{
    
    //延迟执行[方法1] 2s后执行
//    NSLog(@"star");
//    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    
    //延迟执行[方法2] 2s后执行
//    NSLog(@"star");
//    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:NO];
    
    //延迟执行[方法3] 2s后执行
    /*
     第一个参数：延迟时间
     第二个参数：要执行的代码
     */
    NSLog(@"star");
    //这里可以设置队列 来决定当前线程是在主线程中执行 还是在子线程中执行，本函数默认是在主线程中执行，因为这里使用了
    //dispatch_get_main_queue() 其实我们也可以根据自己的需求将其更改成全局的并发队列 这样就可以在子线程中执行任务了
    //如修改成：dispatch_get_global_queue(0, 0)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"---%@", [NSThread currentThread]);
        [Tools toast:@"我晚了2秒！" andCuView:self.view andHeight:300];
    });
}

- (void)run
{
    NSLog(@"end");
}

#pragma mark 一次性代码 只执行一次[整个程序的运行过程中 永远都只执行一次]
- (IBAction)btn_fun_3:(id)sender
{
    //下面的代码 直接敲 dispatch_once 然后选择 snippet - GCD:Dispatch Once 回车即可自动生成
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [Tools toast:@"一次性代码" andCuView:self.view andHeight:300];
    });
    
    
}

//快速迭代【大牛程序员使用的代码 牛逼 以后多用】
- (IBAction)btn_fun_4:(id)sender
{
    //迭代就是遍历的意思
    //以前 这是串行执行的 而且是在主线程中执行的
//    for (int i = 0; i < 10; i ++) {
//        NSLog(@"%zd--%@", i, [NSThread currentThread]);
//    }
    
    //快速得带是在多个子线程中并发执行的 所以效率上要比普通的迭代方式高效
    
    /*
     第一个参数：迭代次数
     第二个参数：在哪个队列中执行
     第三个参数：block：要执行的任务
     */
    dispatch_queue_t queue = dispatch_queue_create("asd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zd--%@", index, [NSThread currentThread]);
    });
    
}

/*
 假设我们有这样一个需求：有两个子线程在现在图片A 和 图片B，等两张图片下载完成之后，由另外一个
 子线程负责合成图片A和图片B  像这样的需求我们就可以用【队列组】来实现
 */
#pragma mark 队列组 有点儿像栅栏函数
- (IBAction)btn_fun_5:(id)sender
{
    //拿到一个全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    //合成图片【需要保证 图片A 和 图片B的子线程都完成操作之后再执行】
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //下载图片A
    dispatch_group_async(group, queue, ^{
        //下载图片第一步 获取url
        NSURL *url = [NSURL URLWithString:@"http://i5.hexunimg.cn/2015-06-16/176773348.jpg"];
        
        //下载图片第二步 下载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //把二进制数据转换成图片
        UIImage *image = [UIImage imageWithData:data];
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageViewA.image = image;
        });
    });
    
    //下载图片B
    dispatch_group_async(group, queue, ^{
        //下载图片第一步 获取url
        NSURL *url = [NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201410/17/20141017160016_FxPKt.jpeg"];
        
        //下载图片第二步 下载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //把二进制数据转换成图片
        UIImage *image = [UIImage imageWithData:data];
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageViewB.image = image;
        });
        
    });
    
    //合成图片
    dispatch_group_notify(group, queue, ^{
        //开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        
        //画图片1
        [self.imageViewA.image drawInRect:CGRectMake(0, 0, 200, 100)];
        
        //画图片2
        [self.imageViewB.image drawInRect:CGRectMake(0, 100, 200, 100)];
        
        //根据图形上下文拿到图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭图形上下文
        UIGraphicsEndPDFContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageViewAB.image = image;
            NSLog(@"%@---刷新UI", [NSThread currentThread]);
        });
    });
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
