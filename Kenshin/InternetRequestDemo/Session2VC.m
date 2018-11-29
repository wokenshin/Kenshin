//
//  Session2VC.m
//  GYBase
//
//  Created by doit on 16/6/12.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
 NSURLSession支持程序的后台下载和上传，苹果官方将其称为进程之外的上传和下载，这些任务都是交给后台守护线程完成的，而非应用程序本身。即使文件在下载和上传过程中崩溃了也可以继续运行（注意如果用户强制退关闭应用程序，NSURLSession会断开连接）。下面看一下如何在后台进行文件下载，这在实际开发中往往很有效，例如在手机上缓存一个视频在没有网络的时候观看（为了简化程序这里不再演示任务的取消、挂起等操作）。下面对前面的程序稍作调整使程序能在后台完成下载操作：
 
 运行上面的程序会发现即使程序退出到后台也能正常完成文件下载。为了提高用户体验，通常会在下载时设置文件下载进度，但是通过前面的介绍可以知道：当程序进入后台后，事实上任务是交给iOS系统来调度的，具体什么时候下载完成就不得而知，例如有个较大的文件经过一个小时下载完了，正常打开应用程序看到的此文件下载进度应该在100%的位置，但是由于程序已经在后台无法更新程序UI，而此时可以通过应用程序代理方法进行UI更新。
 
 */
#define kUrl @"https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/117.jpg"

#import "Session2VC.h"
#import "UIButtonK.h"
#import "Tools.h"

@interface Session2VC ()<NSURLSessionDownloadDelegate>//下载文件［图片］[后台下载]
{
    NSURLSessionDownloadTask        *_downloadTask;
    
}
@end

@implementation Session2VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSession2UI];
    
}

- (void)initSession2UI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"后台下载";
    
    WS(ws);
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 100/2, screenHeight/2 - 44/2, 100, 44)];
    [btn setTitle:@"后台下载" forState:UIControlStateNormal];
    [btn setStyleGreen];
    btn.clickButtonBlock = ^(UIButtonK *b){
        [ws downloadFile];
        
    };
    
    [self.view addSubview:btn];
    
}

#pragma mark 文件下载
- (void)downloadFile
{

    NSString *urlStr = kUrl;
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //后台会话
    _downloadTask = [[self backgroundSession] downloadTaskWithRequest:request];
    
    [_downloadTask resume];
    
}

#pragma mark 取得一个后台会话(保证一个后台会话，这通常很有必要)
- (NSURLSession *)backgroundSession
{
    static NSURLSession *session;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.cmjstudio.URLSession"];
        sessionConfig.timeoutIntervalForRequest = 5.0f;//请求超时时间
        sessionConfig.discretionary = YES;//系统自动选择最佳网络下载
        sessionConfig.HTTPMaximumConnectionsPerHost = 5;//限制每次最多一个连接
        //创建会话
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];//指定配置和代理
        
    });
    return session;
    
}

#pragma mark - 下载任务代理
#pragma mark 下载中(会多次调用，可以记录下载进度)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    
}

#pragma mark 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSError *error;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSDate date]]];
    NSLog(@"%@",savePath);
    NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&error];
    if (error)
    {
        NSLog(@"didFinishDownloadingToURL:Error is %@",error.localizedDescription);
    }
    
}

#pragma mark 任务完成，不管是否下载成功
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"DidCompleteWithError:Error is %@",error.localizedDescription);
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _downloadTask = nil;
}


@end
