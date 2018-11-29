//
//  WebThreeVC.m
//  GYBase
//
//  Created by doit on 16/6/7.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
     NSURLSession作为NSURLConnection的继任者。相比较NSURLConnection，NSURLSession提供了配置会话缓存、协议、cookie和证书能力，
   这使得网络架构和应用程序可以独立工作、互不干扰。另外，NSURLSession另一个重要的部分是会话任务，它负责加载数据，在客户端和服务器端进行文件的上传下载。
 
    NSURLConnection完成的三个主要任务：获取数据（通常是JSON、XML等）、文件上传、文件下载。其实在NSURLSession时代，他们分别由三个任务来完成：
    NSURLSessionData、NSURLSessionUploadTask、NSURLSessionDownloadTask，这三个类都是NSURLSessionTask这个抽象类的子类，相比直接使用
    NSURLConnection,NSURLSessionTask支持任务的暂停、取消和恢复，并且默认任务运行在其他非主线程中
 
 */

#import "WebThreeVC.h"
#import "UIButtonK.h"
#import "Tools.h"
#import "Session1VC.h"
#import "Session2VC.h"

@interface WebThreeVC ()

@end

@implementation WebThreeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWebThreeUI];
    [Tools toast:@"都是 demoCodes" andCuView:self.view andHeight:400];
    
}

- (void)initWebThreeUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"NSURLSession";
 
    CGFloat widthBt = 300;
    CGFloat x = screenWidth/2 - widthBt/2;
    WS(ws);
    
    //数据请求
    UIButtonK *requestBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(x, 64 + margin_10, widthBt, height_normal)];
    [requestBtn setTitle:@"数据请求" forState:UIControlStateNormal];
    [requestBtn setStyleGreen];
    requestBtn.clickButtonBlock = ^(UIButtonK *b){
        [ws loadJsonData];
        
    };
    
    //文件上传
    UIButtonK *uploadBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(x, 64 + margin_10*2 + 44, widthBt, height_normal)];
    [uploadBtn setTitle:@"文件上传" forState:UIControlStateNormal];
    [uploadBtn setStyleGreen];
    uploadBtn.clickButtonBlock = ^(UIButtonK *b){
        [ws uploadFile];
        
    };
    
    //文件下载
    UIButtonK *downloadBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(x, 64 + margin_10*3 + 44*2, widthBt, height_normal)];
    [downloadBtn setTitle:@"文件下载" forState:UIControlStateNormal];
    [downloadBtn setStyleGreen];
    downloadBtn.clickButtonBlock = ^(UIButtonK *b){
        [ws downloadFile];
        
    };
    
    //NSURLSession 会话[前台下载]
    UIButtonK *sessiondBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(x, 64 + margin_10*4 + 44*3, widthBt, height_normal)];
    [sessiondBtn setTitle:@"前台下载" forState:UIControlStateNormal];
    [sessiondBtn setStyleGreen];
    sessiondBtn.clickButtonBlock = ^(UIButtonK *b){
        Session1VC *vc = [Session1VC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //NSURLSession 会话[后台下载]
    UIButtonK *backDownloadBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(x, 64 + margin_10*5 + 44*4, widthBt, height_normal)];
    [backDownloadBtn setTitle:@"后台下载" forState:UIControlStateNormal];
    [backDownloadBtn setStyleGreen];
    backDownloadBtn.clickButtonBlock = ^(UIButtonK *b){
        Session2VC *vc = [Session2VC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:requestBtn];
    [self.view addSubview:uploadBtn];
    [self.view addSubview:downloadBtn];
    [self.view addSubview:sessiondBtn];
    [self.view addSubview:backDownloadBtn];
    
}

#pragma mark - 数据请求demoCodes
-(void)loadJsonData
{
    //1.创建url
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.1.208/ViewStatus.aspx?userName=%@&password=%@",@"Kenshin",@"123"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//编码格式
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //2.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.创建会话（这里使用了一个全局会话）并且启动任务
    NSURLSession *session = [NSURLSession sharedSession];
    
    //从会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
        if (!error)
        {
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",dataStr);
        }
        else
        {
            NSLog(@"error is :%@",error.localizedDescription);
        }
                                                    
    }];
    
    [dataTask resume];//恢复线程，启动任务
    
}

#pragma mark - 文件上传demoCodes NSURLSessionUploadTask实现文件上传
-(void)uploadFile
{
    NSString *fileName = @"pic.jpg";
    //1.创建url
    NSString *urlStr = @"http://192.168.1.208/FileUpload.aspx";
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    //2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    //3.构建数据
//    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *data = [self getHttpBody:fileName];
    request.HTTPBody = data;
    
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"Kenshin"] forHTTPHeaderField:@"Content-Type"];
    
    
    
    //4.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:data
                                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                          
        if (!error)
        {
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",dataStr);
        }
        else
        {
            NSLog(@"error is :%@",error.localizedDescription);
        }
                                                          
    }];
    
    [uploadTask resume];
}

#pragma mark 取得数据体
-(NSData *)getHttpBody:(NSString *)fileName
{
    NSString *boundary = @"Kenshin";
    NSMutableData *dataM = [NSMutableData data];
    NSString *strTop=[NSString stringWithFormat:@"--%@\nContent-Disposition: form-data; name=\"file1\"; filename=\"%@\"\nContent-Type: %@\n\n",boundary,fileName,[self getMIMETypes:fileName]];
    
    NSString *strBottom = [NSString stringWithFormat:@"\n--%@--",boundary];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [dataM appendData:[strTop dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:fileData];
    [dataM appendData:[strBottom dataUsingEncoding:NSUTF8StringEncoding]];
    return dataM;
    
}

#pragma mark 取得mime types
-(NSString *)getMIMETypes:(NSString *)fileName
{
    return @"image/jpg";
    
}

#pragma mark - 文件下载demoCodes
//使用NSURLSessionDownloadTask下载文件的过程与前面差不多，需要注意的是文件下载文件之后会自动保存到一个临时目录，
//需要开发人员自己将此文件重新放到其他指定的目录中。
-(void)downloadFile
{
    //1.创建url
    NSString *fileName = @"1.jpg";
    NSString *urlStr = [NSString stringWithFormat: @"http://192.168.1.208/FileDownload.aspx?file=%@",fileName];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //3.创建会话（这里使用了一个全局会话）并且启动任务
    NSURLSession *session = [NSURLSession sharedSession];
    
    //注意location是下载后的临时保存路径,需要将它移动到需要保存的位置
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            NSError  *saveError;
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savePath  = [cachePath stringByAppendingPathComponent:fileName];
            NSLog(@"%@",savePath);
            NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
            
            //将location中临时保存的文件 移动到需要保存的位置
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            
            if (!saveError)
            {
                [Tools toast:@"save sucess." andCuView:self.view andHeight:400];
            }
            else
            {
                NSString *msg = [NSString stringWithFormat:@"error is :%@",saveError.localizedDescription];
                [Tools toast:msg andCuView:self.view andHeight:400];
            }
            
        }
        else
        {
            NSString *msg = [NSString stringWithFormat:@"error is :%@",error.localizedDescription];
            [Tools toast:msg andCuView:self.view andHeight:400];
        }
        
    }];
    [downloadTask resume];
    
}

#pragma mark - 会话

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
