//
//  WebOneVC.m
//  GYBase
//
//  Created by doit on 16/6/7.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    Web请求和响应[下载文件]
 
   使用代理方法
 
   做过Web开发的朋友应该很清楚，Http是无连接的请求。每个请求request服务器都有一个对应的响应response，无论是asp.net、jsp、php都是基于这种机制开发的。
 
     在Web开发中主要的请求方法有如下几种:
     
     GET请求：get是获取数据的意思，数据以明文在URL中传递，受限于URL长度，所以传输数据量比较小。
     POST请求：post是向服务器提交数据的意思，提交的数据以实际内容形式存放到消息头中进行传递，无法在浏览器url中查看到，大小没有限制。
     HEAD请求：请求头信息，并不返回请求数据体，而只返回请求头信息，常用用于在文件下载中取得文件大小、类型等信息。
 
   程序的实现需要借助几个对象：
 
   NSURLRequest：建立了一个请求，可以指定缓存策略、超时时间。和NSURLRequest对应的还有一个NSMutableURLRequest，
   如果请求定义为NSMutableURLRequest则可以指定请求方法（GET或POST）等信息。
 
   NSURLConnection：用于发送请求，可以指定请求和代理。当前调用NSURLConnection的start方法后开始发送异步请求。
 
 
   需要注意：
 
   根据响应数据大小不同可能会多次执行- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data方法。
   URL中不能出现中文（例如下面使用GET传参数时，file参数就可能是中文），需要对URL进行编码，否则会出错。
 */

#import "WebOneVC.h"
#import "Tools.h"
#import "UIButtonK.h"//由于下载的是一张图片 所以几乎看不到下载进度 除非网速很慢的时候

@interface WebOneVC ()<NSURLConnectionDataDelegate>
{
    NSMutableData               *_data;//响应数据
    UIButtonK                   *_downloadBtn;
    UIProgressView              *_progressView;
    UILabel                     *_label;
    long long                   _totalLength;
    
}

@end

@implementation WebOneVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWebOneUI];
    [Tools toast:@"下载图片 保存在 Caches文件夹下" andCuView:self.view andHeight:400];
    
}

- (void)initWebOneUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Web请求和响应";
    
    //进度条
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(screenWidth/2 - 300/2, 100, 300, 25)];
    
    //状态显示
    _label = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2 - 300/2, 130, 300, 25)];
    _label.textColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0];
    
    WS(ws);
    //下载按钮
    _downloadBtn = [[UIButtonK alloc]initWithFrame:CGRectMake(screenWidth/2 - 300/2, 500, 300, 44)];
    [_downloadBtn setStyleGreen];
    [_downloadBtn setTitle:@"download" forState:UIControlStateNormal];
    _downloadBtn.clickButtonBlock = ^(UIButtonK *b){
        [ws sendRequest];
        
    };
    
    
    UIButtonK *deleteBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 300/2, 554, 300, 44)];
    [deleteBtn setStyleGreen];
    [deleteBtn setTitle:@"remove" forState:UIControlStateNormal];
    deleteBtn.clickButtonBlock = ^(UIButtonK *b){
        
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        NSString *delPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        delPath = [delPath stringByAppendingPathComponent:@"web请求和响应.jpg"];
        
        NSString *deleteTips = nil;
        if ([fileManager removeItemAtPath:delPath error:nil])
        {
            deleteTips = @"删除成功!";
        }
        else
        {
            deleteTips = @"删除失败!";
        }
        [Tools toast:deleteTips andCuView:self.view andHeight:400];
    };
    
    [self.view addSubview:_progressView];
    [self.view addSubview:_label];
    [self.view addSubview:_downloadBtn];
    [self.view addSubview:deleteBtn];
    
}

#pragma mark 发送数据请求 GET 请求
-(void)sendRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/117.jpg"];
    //注意对于url中的中文是无法解析的，需要进行url编码(指定编码类型为utf-8)
    //另外注意url解码使用stringByRemovingPercentEncoding方法
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //创建url链接
    NSURL *url = [NSURL URLWithString:urlStr];//如果url字符串中没有中文 可以不用置顶编码类型
    
    /*创建请求
     cachePolicy:缓存策略
     a.NSURLRequestUseProtocolCachePolicy 协议缓存，根据response中的Cache-Control字段判断缓存是否有效，如果缓存有效则使用缓存数据否则重新从服务器请求
     b.NSURLRequestReloadIgnoringLocalCacheData 不使用缓存，直接请求新数据
     c.NSURLRequestReloadIgnoringCacheData 等同于 SURLRequestReloadIgnoringLocalCacheData
     d.NSURLRequestReturnCacheDataElseLoad 直接使用缓存数据不管是否有效，没有缓存则重新请求
     eNSURLRequestReturnCacheDataDontLoad 直接使用缓存数据不管是否有效，没有缓存数据则失败
     timeoutInterval:超时时间设置（默认60s）
     */
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:15.0f];
    //创建连接
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    //启动连接
    [connection start];
    
}

#pragma mark - 连接代理方法
#pragma mark 开始响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive response.");
    _data = [[NSMutableData alloc]init];
    _progressView.progress = 0;
    
    //通过响应头中的Content-Length取得整个响应的总长度
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary      *httpResponseHeaderFields = [httpResponse allHeaderFields];
    _totalLength = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
    NSLog(@"%lld", _totalLength);
}

#pragma mark 接收响应数据（根据响应内容的大小此方法会被重复调用）
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"receive data.");
    //连续接收数据
    [_data appendData:data];
    //更新进度
    [self updateProgress];
    
}

#pragma mark 更新进度
-(void)updateProgress
{
    if (_data.length == _totalLength)
    {
        _label.text = @"下载完成";
    }
    else
    {
        _label.text = @"正在下载...";
        [_progressView setProgress:(float)_data.length/_totalLength];
        
    }
    
}

#pragma mark 数据接收完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"loading finish.");
    
    //数据接收完保存文件(注意苹果官方要求：下载数据只能保存在缓存目录)
    NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    savePath = [savePath stringByAppendingPathComponent:@"web请求和响应.jpg"];
    [_data writeToFile:savePath atomically:YES];
    
    NSLog(@"path:%@",savePath);

}

#pragma mark 请求失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //如果连接超时或者连接地址错误可能就会报错
    NSLog(@"connection error,error detail is:%@",error.localizedDescription);
    [Tools toast:@"下载出错！" andCuView:self.view andHeight:400];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _data           = nil;//响应数据
    _downloadBtn    = nil;
    _progressView   = nil;
    _label          = nil;
    
}
@end
