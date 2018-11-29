//
//  NSOperationMsgVC.m
//  GYBase
//
//  Created by kenshin on 16/9/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NSOperationMsgVC.h"

@interface NSOperationMsgVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation NSOperationMsgVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"线程间的通信";
    
}

- (IBAction)btnDownload:(id)sender
{
    //创建一个非主队列【默认是并发队列，如果要设置成串行队列 需要设置最大并发数为1】
    NSOperationQueue *queue = [NSOperationQueue new];
    
    //创建操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
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
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _imgView.image = image;
            NSLog(@"验证当前线程是否是主线程:%@", [NSThread currentThread]);
        }];

    }];
    
    [queue addOperation:op];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
