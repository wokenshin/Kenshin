//
//  WebViewVC.m
//  GYBase
//
//  Created by doit on 16/5/13.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "WebViewVC.h"
#import "Tools.h"
#import "Constants.h"

@interface WebViewVC ()

@property (nonatomic, strong)UIWebView      *webView;
@end

@implementation WebViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWebViewVCUI];
    
}

- (void)initWebViewVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"UIWebView";
    
//    CGFloat yBase = statusHeight+navBarHeight;
    //初始化
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 44 - 49 - 64)];
    
    //设置属性
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    //加载网页:
    NSURL* url = [NSURL URLWithString:@"http://manhua.dmzj.com/lanqiufeirenquancai/12515.shtml#@page=1"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
    
    //加载一个本地资源:
//    NSURL* url = [NSURL fileURLWithPath:[Tools filePathWithDocuments:headerPath_SLAMDUNK]];//创建URL
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
//    [self.webView loadRequest:request];//加载
    
    //实现代理
    self.webView.delegate = self;
    
    
    [self.view addSubview:self.webView];
    
    
}

#pragma mark - 代理 UIWebView
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
    
}
//当网页视图已经开始加载一个请求后，得到通知
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载：%@", webView);
    //可以在这里加菊花
    
}

//当网页视图结束加载一个请求之后，得到通知
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"结束加载：%@", webView);
    //关闭菊花
    
}

//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败：%@", error);
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.webView = nil;
    
}
@end
