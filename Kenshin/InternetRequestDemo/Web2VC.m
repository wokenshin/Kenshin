//
//  Web2VC.m
//  GYBase
//
//  Created by doit on 16/6/13.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
     其实UIWebView整个使用相当简单：创建URL->创建请求->加载请求，无论是加载本地文件还是Web内容都是这三个步骤。
     UIWebView内容加载事件同样是通过代理通知外界，常用的代理方法如开始加载、加载完成、加载出错等，这些方法通常可以帮助开发者更好的控制请求加载过程。
 
     注意：UIWebView打开本地pdf、word文件依靠的并不是UIWebView自身解析，而是依靠MIME Type识别文件类型并调用对应应用打开。
    
 
 
     UIWebView与页面交互
     
     UIWebView与页面的交互主要体现在两方面：使用ObjC方法进行页面操作、在页面中调用ObjC方法两部分。
     和其他移动操作系统不同，iOS中所有的交互都集中于一个stringByEvaluatingJavaScriptFromString:方法中，以此来简化开发过程。
 
     在iOS中操作页面
     
     1.首先在request方法中使用loadHTMLString:加载了html内容，当然你也可以将html放到bundle或沙盒中读取并且加载。
     
     2.然后在webViewDidFinishLoad:代理方法中通过stringByEvaluatingJavaScriptFromString: 方法可以操作页面中的元素，例如在下面的方法中读取了页面标题、修改了其中的内容。
 */

#import "Web2VC.h"
#import "Tools.h"

@interface Web2VC ()<UIWebViewDelegate>//UIWebView与页面交互
{
    UIWebView           *webView;
    
}

@end

@implementation Web2VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWeb2UI];
    [self request];
    
}

- (void)initWeb2UI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"页面交互";
    
    /*添加浏览器控件*/
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    webView.dataDetectorTypes = UIDataDetectorTypeAll;//数据检测类型，例如内容中有邮件地址，点击之后可以打开邮件软件编写邮件
    webView.delegate = self;
    [self.view addSubview:webView];
    
}

#pragma mark 浏览器请求
-(void)request
{
    //加载html内容
    NSString *htmlStr = @"<html>\
    <head><title>Kenshin's Blog</title></head>\
    <body style=\"color:#0092FF;\">\
    <h1 id=\"header\">I am Kenshin Cui</h1>\
    <p>iOS 开发系列</p>\
    </body></html>";
    
    //加载请求页面
    [webView loadHTMLString:htmlStr baseURL:nil];
    
}

#pragma mark - WebView 代理方法
#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示网络请求加载
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
}

#pragma mark 加载完毕
-(void)webViewDidFinishLoad:(UIWebView *)webView2
{
    //隐藏网络请求加载图标
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    
    //取得html内容
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    //修改页面内容
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('header').innerHTML='Kenshin\\'s Blog'"]);
}
#pragma mark 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error detail:%@",error.localizedDescription);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"系统提示" message:@"网络连接发生错误!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    webView = nil;
    
}

































@end
