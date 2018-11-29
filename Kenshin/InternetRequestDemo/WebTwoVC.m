//
//  WebTwoVC.m
//  GYBase
//
//  Created by doit on 16/6/7.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 文件分段下载
 
 通过前面的演示大家应该对于iOS的Web请求有了大致的了解，可以通过代理方法接收数据也可以直接通过静态方法接收数据，但是实际开发中更推荐使用静态方法。关于前面的文件下载示例，更多的是希望大家了解代理方法接收响应数据的过程，实际开发中也不可能使用这种方法进行文件下载。这种下载有个致命的问题：不适合进行大文件分段下载。因为代理方法在接收数据时虽然表面看起来是每次读取一部分响应数据，事实上它只有一次请求并且也只接收了一次服务器响应，只是当响应数据较大时系统会重复调用数据接收方法，每次将已读取的数据拿出一部分交给数据接收方法。这样一来对于上G的文件进行下载，如果中途暂停的话再次请求还是从头开始下载，不适合大文件断点续传（另外说明一点，上面NSURLConnection示例中使用了NSMutableData进行数据接收和追加只是为了方便演示，实际开发建议直接写入文件）。
 
 实际开发文件下载的时候不管是通过代理方法还是静态方法执行请求和响应，我们都会分批请求数据，而不是一次性请求数据。假设一个文件有1G，那么只要每次请求1M的数据，请求1024次也就下载完了。那么如何让服务器每次只返回1M的数据呢？
 
 在网络开发中可以在请求的头文件中设置一个range信息，它代表请求数据的大小。通过这个字段配合服务器端可以精确的控制每次服务器响应的数据范围。例如指定bytes=0-1023，然后在服务器端解析Range信息，返回该文件的0到1023之间的数据的数据即可（共1024Byte）。这样，只要在每次发送请求控制这个头文件信息就可以做到分批请求。
 
 当然，为了让整个数据保持完整，每次请求的数据都需要逐步追加直到整个文件请求完成。但是如何知道整个文件的大小？其实在前面的文件下载演示中大家可以看到，可以通过头文件信息获取整个文件大小。但是这么做的话就必须请求整个数据，这样分段下载就没有任何意义了。所幸在WEB开发中我们还有另一种请求方法“HEAD”，通过这种请求服务器只会响应头信息，其他数据不会返回给客户端，这样一来整个数据的大小也就可以得到了。下面给出完整的程序代码，关键的地方已经给出注释（为了简化代码，这里没有使用代理方法）：
 
 */
#define kFILE_BLOCK_SIZE (1024) //每次1KB
#define kUrl @"https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/117.jpg"
#define downloadFileName @"分段下载.jpg"

#import "WebTwoVC.h"
#import "Tools.h"
#import "UIButtonK.h"

@interface WebTwoVC ()
{
    UIButtonK               *_downloadBtn;
    UIProgressView          *_progressView;
    UILabel                 *_tipsLabel;
    long long               _totalLength;
    long long               _loadedLength;
    
}

@end

@implementation WebTwoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWebTwoUI];
    [Tools toast:@"还有更好的方式" andCuView:self.view andHeight:400];
    
}

- (void)initWebTwoUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = downloadFileName;
    
    //进度条
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(screenWidth/2 - 300/2, 100 + 64, 300, 25)];
    
    //状态显示
    _tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2 - 300/2, 130 + 64, 300, 25)];
    _tipsLabel.textColor = RGB2Color(0, 146, 255);
    
    WS(ws);
    //下载
    _downloadBtn = [[UIButtonK alloc]initWithFrame:CGRectMake(screenWidth/2 - 300/2, 500 + 10, 300, 44)];
    [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [_downloadBtn setStyleGreen];
    _downloadBtn.clickButtonBlock = ^(UIButtonK *b){
        [ws downloadFileAsync];
        
    };
    
    //删除下载文件
    UIButtonK *delBtn = [[UIButtonK alloc]initWithFrame:CGRectMake(screenWidth/2 - 300/2, 500 + 64, 300, 44)];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setStyleGreen];
    delBtn.clickButtonBlock = ^(UIButtonK *b){
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        NSString *delPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        delPath = [delPath stringByAppendingPathComponent:downloadFileName];
        
        NSString *deleteTips = nil;
        if ([fileManager removeItemAtPath:delPath error:nil])
        {
            deleteTips = @"删除成功!";
            [_progressView setProgress:0.0];
            _tipsLabel.text = @"文件已删除！";
            
        }
        else
        {
            deleteTips = @"删除失败!";
        }
        [Tools toast:deleteTips andCuView:self.view andHeight:400];
        
    };
    
    [self.view addSubview:_progressView];
    [self.view addSubview:_tipsLabel];
    [self.view addSubview:_downloadBtn];
    [self.view addSubview:delBtn];
    
}

#pragma mark 异步下载文件
-(void)downloadFileAsync
{
    if ([_tipsLabel.text isEqualToString:@"下载完成"])
    {
        [Tools toast:@"已经下载饿，不用再下载！" andCuView:self.view andHeight:400];
        return;
    }
    if ([_tipsLabel.text isEqualToString:@"正在下载..."])
    {
        [Tools toast:@"正在下载，你慌个毛啊！" andCuView:self.view andHeight:400];
        return;
    }
    
    //异步
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self downloadFile];
        
    });
    
}

#pragma mark 文件下载
-(void)downloadFile
{
    _totalLength  = [self getFileTotalLength];//HEAD 请求 获取下载文件大小
    _loadedLength = 0;
    long long startSize = 0;
    long long endSize   = 0;
    //分段下载
    while(startSize <  _totalLength)
    {
        endSize = startSize + kFILE_BLOCK_SIZE - 1;
        if (endSize > _totalLength)
        {
            endSize = _totalLength - 1;
        }
        [self downloadFileStartByte:startSize endByte:endSize];
        
        //更新进度
        _loadedLength += (endSize - startSize) + 1;
        [self updateProgress];
        
        startSize += kFILE_BLOCK_SIZE;
    }
    
}

#pragma mark  取得文件大小[HEAD 请求]
-(long long)getFileTotalLength
{
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[self getDownloadUrl]
                                    cachePolicy:NSURLRequestReloadIgnoringCacheData
                                    timeoutInterval:5.0f];
    //设置为头信息请求
    [request setHTTPMethod:@"HEAD"];
    
    NSURLResponse *response;
    NSError *error;
    //注意这里使用了同步请求，直接将文件大小返回
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error)
    {
        NSLog(@"detail error:%@",error.localizedDescription);
    }
    //取得内容长度
    return response.expectedContentLength;
    
}

#pragma mark 下载指定块大小的数据［分段下载 循环调用］
-(void)downloadFileStartByte:(long long)start endByte:(long long)end
{
    NSString *range = [NSString stringWithFormat:@"Bytes=%lld-%lld",start,end];
    NSLog(@"%@",range);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getDownloadUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0f];
    //通过请求头设置数据请求范围
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    NSURLResponse *response;
    NSError *error;
    //注意这里使用同步请求，避免文件块追加顺序错误
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(!error)
    {
        NSLog(@"dataLength=%lld",(long long)data.length);
        [self fileAppend:[self getSavePath] data:data];
    }
    else
    {
        NSLog(@"detail error:%@",error.localizedDescription);
    }
    
}

#pragma mark 取得请求链接
-(NSURL *)getDownloadUrl
{
    NSString *urlStr = [NSString stringWithFormat:kUrl];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//url中有中文就需要此步骤
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
    
}

#pragma mark 更新进度
-(void)updateProgress
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (_loadedLength == _totalLength)
        {
            _tipsLabel.text = @"下载完成";
        }
        else
        {
            _tipsLabel.text = @"正在下载...";
        }
        [_progressView setProgress:(double)_loadedLength/_totalLength];
    }];
    
}

#pragma mark 取得保存地址(保存在沙盒缓存目录)
-(NSString *)getSavePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:downloadFileName];
    
}

#pragma mark 文件追加
-(void)fileAppend:(NSString *)filePath data:(NSData *)data
{
    //以可写方式打开文件
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    //如果存在文件则追加，否则创建
    if (fileHandle)
    {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];//关闭文件
    }
    else
    {
        [data writeToFile:filePath atomically:YES];//创建文件
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _downloadBtn        = nil;
    _progressView       = nil;
    _tipsLabel          = nil;
    
}
@end
