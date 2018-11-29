//
//  XMG_GCDVC.m
//  GYBase
//
//  Created by kenshin on 16/8/28.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "XMG_GCDVC.h"
#import "GCDFuntionsVC.h"

@interface XMG_GCDVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation XMG_GCDVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"CGD是纯C语言的多线程";
    
}

//GCD的基本使用: 异步函数+并发队列
//异步函数+并发队列：会开启多条线程，任务是并发执行

//异步函数+并发队列
- (IBAction)btnGCD_base:(id)sender
{
    [Tools toast:@"会开启子线程+并发执行" andCuView:self.view andHeight:300];
    //GCD所有的函数 都是以 dispatch开头的
    
    /*
     第一个参数：c语言字符串，是一个标签 用于标识身份
     第二个参数：队列类型  DISPATCH_QUEUE_CONCURRENT:并发队列
     */
    
    //有两种方式创建并发队列 通常用第二种比较简便
    //创建一个并发队列
//    dispatch_queue_t queue = dispatch_queue_create("com.520.download", DISPATCH_QUEUE_CONCURRENT);
    
    //获取一个全局的并发队列
    /*
     第一个参数：队列的优先级
     第二个参数：永远传一个0
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    /*
     第一个参数：队列【串行队列 or 并行队列】
     第二个参数：代码块：用于封装我们的任务
     */
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
}

//异步函数+串行队列 会开启一条线程  任务是串行执行的

//异步函数+串行队列
- (IBAction)btn_asyncAndSerialQueue:(id)sender
{
    [Tools toast:@"会开启一条线程+串行执行" andCuView:self.view andHeight:300];
    //创建了一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.520.download", DISPATCH_QUEUE_SERIAL);
    
    /*
     第一个参数：队列【串行队列 or 并行队列】
     第二个参数：代码块：用于封装我们的任务
     */
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
}

//同步函数+并发队列 不会开启线程 任务是串行执行的

//同步函数+并发队列
- (IBAction)btnSyncAndConcurrent:(id)sender
{
    [Tools toast:@"不会开启子线程+串行执行" andCuView:self.view andHeight:300];
    //并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
}


//同步函数+串行队列 不会开启线程 任务是串行执行的

//同步函数+串行队列
- (IBAction)btnSyncSerial:(id)sender
{
    [Tools toast:@"不会开启子线程+串行执行" andCuView:self.view andHeight:300];
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.520.download", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
}

//不会开启子线程 串行执行
//异步函数+主队列
- (IBAction)btnAsyncMainQueue:(id)sender
{
    [Tools toast:@"不会开启子线程+串行执行" andCuView:self.view andHeight:300];
    //获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
}

//会卡死
//同步函数+主队列
- (IBAction)btnSyncMainQueue:(id)sender
{
    [Tools toast:@"会卡死" andCuView:self.view andHeight:300];
    //因为本方法本身是在主队列中执行的，而串行函数的执行过程是 必须执行完当前线程后 才能执行下一个线程
    //可是这里的当前线程中还有4个串行线程，本函数中的线程需要执行 必须要等到本方法执行完毕，所以造成了互相等待 就卡死了。
    
    
    //获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //同步函数
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
}

//线程间的通信
- (IBAction)btnMsgInGCD:(id)sender
{
    //开启子线程下载图片
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //异步函数
    dispatch_async(queue, ^{
        //下载图片第一步 获取url
        NSURL *url = [NSURL URLWithString:@"http://i5.hexunimg.cn/2015-06-16/176773348.jpg"];//未来穗香
        
        //下载图片第二步 下载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //把二进制数据转换成图片
        UIImage *image = [UIImage imageWithData:data];
        
        NSLog(@"-----%@", [NSThread currentThread]);
        
        //回到主线程 刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgView.image = image;
            NSLog(@"==%@", [NSThread currentThread]);
        });
        
    });
    
}

//GCD的常用函数
- (IBAction)btnGotoGCDFunctionsVC:(id)sender
{
    GCDFuntionsVC *vc = [GCDFuntionsVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
