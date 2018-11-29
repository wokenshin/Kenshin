//
//  Session1VC.m
//  GYBase
//
//  Created by doit on 16/6/12.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 会话
 
 NSURLConnection通过全局状态来管理cookies、认证信息等公共资源，这样如果遇到两个连接需要使用不同的资源配置情况时就无法解决了，
 但是这个问题在NSURLSession中得到了解决。NSURLSession同时对应着多个连接，会话通过工厂方法来创建，同一个会话中使用相同的状态信息。
 NSURLSession支持进程三种会话：
 
     defaultSessionConfiguration：进程内会话（默认会话），用硬盘来缓存数据。
     
     ephemeralSessionConfiguration：临时的进程内会话（内存），不会将cookie、缓存储存到本地，只会放到内存中，当应用程序退出后数据也会消失。
     
     backgroundSessionConfiguration：后台会话，相比默认会话，该会话会在后台开启一个线程进行网络数据处理。
 
 下面将通过一个文件下载功能对两种会话进行演示，在这个过程中也会用到任务的代理方法对上传操作进行更加细致的控制。下面先看一下使用默认会话下载文件,
 代码中演示了如何通过NSURLSessionConfiguration进行会话配置，如果通过代理方法进行文件下载进度展示（类似于前面中使用NSURLConnection代理方法,
 其实下载并未分段，如果需要分段需要配合后台进行），同时在这个过程中可以准确控制任务的取消、挂起和恢复。
 
 
 */
#define kUrl @"https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/117.jpg"

#import "Session1VC.h"
#import "Tools.h"
#import "UIButtonK.h"

@interface Session1VC ()<NSURLSessionDownloadDelegate>//下载文件［图片］[前台下载]
{
    UIProgressView                  *_progressView;
    UILabel                         *_label;
    UIButtonK                       *_btnDownload;
    UIButtonK                       *_btnCancel;
    UIButtonK                       *_btnSuspend;
    UIButtonK                       *_btnResume;
    NSURLSessionDownloadTask        *_downloadTask;
    
}
@end

@implementation Session1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSession1UI];
    
}

- (void)initSession1UI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"会话";
    
    //进度条
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(margin_10, 100, screenWidth - margin_10*2, 25)];
    
    //状态显示
    _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 300, 25)];
    _label.textColor = RGB2Color(0, 146, 255);
    
    WS(ws);
    //下载按钮
    _btnDownload = [[UIButtonK alloc]initWithFrame:CGRectMake(20, 500, 50, 25)];
    [_btnDownload setTitle:@"下载" forState:UIControlStateNormal];
    [_btnDownload setStyleGreen];
    _btnDownload.clickButtonBlock = ^(UIButtonK *b){
        [ws downloadFile];
    };
    
    //取消按钮
    _btnCancel=[[UIButtonK alloc]initWithFrame:CGRectMake(100, 500, 50, 25)];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel setStyleGreen];
    _btnCancel.clickButtonBlock = ^(UIButtonK *b){
        [ws cancelDownload];
    };
    
    //挂起按钮
    _btnSuspend=[[UIButtonK alloc]initWithFrame:CGRectMake(180, 500, 50, 25)];
    [_btnSuspend setTitle:@"挂起" forState:UIControlStateNormal];
    [_btnSuspend setStyleGreen];
    _btnSuspend.clickButtonBlock = ^(UIButtonK *b){
        [ws suspendDownload];
    };
    
    //恢复按钮
    _btnResume=[[UIButtonK alloc]initWithFrame:CGRectMake(260, 500, 50, 25)];
    [_btnResume setTitle:@"恢复" forState:UIControlStateNormal];
    [_btnResume setStyleGreen];
    _btnResume.clickButtonBlock = ^(UIButtonK *b){
        [ws resumeDownload];
    };
    
    
    [self.view addSubview:_progressView];
    [self.view addSubview:_label];
    [self.view addSubview:_btnDownload];
    [self.view addSubview:_btnCancel];
    [self.view addSubview:_btnSuspend];
    [self.view addSubview:_btnResume];
    
}

#pragma mark 文件下载
- (void)downloadFile
{
    //1.创建url
    NSString *urlStr = kUrl;
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    //2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //3.创建会话
    //默认会话
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 5.0f;//请求超时时间
    sessionConfig.allowsCellularAccess = true;//是否允许蜂窝网络下载（2G/3G/4G）
    //创建会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];//指定配置和代理
    _downloadTask = [session downloadTaskWithRequest:request];
    
    [_downloadTask resume];
    
}

#pragma mark 取消下载
- (void)cancelDownload
{
    [_downloadTask cancel];
    
}

#pragma mark 挂起下载
- (void)suspendDownload
{
    [_downloadTask suspend];
    
}

#pragma mark 恢复下载下载
- (void)resumeDownload
{
    [_downloadTask resume];
    
}

#pragma mark - 下载任务代理
#pragma mark 下载中(会多次调用，可以记录下载进度)
- (void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
     didWriteData:(int64_t)bytesWritten
totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    [self setUIStatus:totalBytesWritten expectedToWrite:totalBytesExpectedToWrite];
    
}

#pragma mark 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSError *error;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath = [cachePath stringByAppendingPathComponent:@"会话.jpg"];
    NSLog(@"%@",savePath);
    NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&error];
    if (error)
    {
        NSLog(@"Error is:%@",error.localizedDescription);
    }
    
}

#pragma mark 任务完成，不管是否下载成功
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [self setUIStatus:0 expectedToWrite:0];
    if (error)
    {
        NSLog(@"Error is:%@",error.localizedDescription);
    }
    
}

#pragma mark 设置界面状态[状态栏菊花 和 文本标签内容]
- (void)setUIStatus:(int64_t)totalBytesWritten expectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
        if (totalBytesWritten == totalBytesExpectedToWrite)
        {
            _label.text = @"下载完成";
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            _btnDownload.enabled = YES;
        }
        else
        {
            _label.text = @"正在下载...";
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    });
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _progressView   = nil;
    _label          = nil;
    _btnDownload    = nil;
    _btnCancel      = nil;
    _btnSuspend     = nil;
    _btnResume      = nil;
    _downloadTask   = nil;
    
}

@end