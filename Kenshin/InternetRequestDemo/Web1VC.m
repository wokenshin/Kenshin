//
//  Web1VC.m
//  GYBase
//
//  Created by doit on 16/6/12.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
     网络开发中还有一个常用的UI控件UIWebView,它是iOS中内置的浏览器控件，功能十分强大。如一些社交软件往往在应用程序内不需要打开其他浏览器就能看
     一些新闻之类的页面，就是通过这个控件实现的。需要注意的是UIWebView不仅能加载网络资源还可以加载本地资源，
     目前支持的常用的文档格式如：html、pdf、docx、txt等
 
 
     在这个浏览器中将实现这样几个功能：
     
     1.如果输入以”file://”开头的地址将加载Bundle中的文件
     
     2.如果输入以“http”开头的地址将加载网络资源
     
     3.如果输入内容不符合上面两种情况将使用bing搜索此内容
 
 */
#define FILE_HEAD @"file://"

#import "Web1VC.h"
#import "Tools.h"

@interface Web1VC ()<UISearchBarDelegate, UIWebViewDelegate>//浏览网页 和 本地文件
{
    UIWebView               *webView;
    UIToolbar               *toolbar;
    UISearchBar             *searchBar;
    UIBarButtonItem         *barButtonBack;     //后退
    UIBarButtonItem         *barButtonForward;  //前进
    
}

@end

@implementation Web1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWebUI1];
    
}

- (void)initWebUI1
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"webview";
    
    /*添加地址栏*/
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, screenWidth, 44)];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    /*添加浏览器控件*/
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64 + 44, screenWidth, screenHeight - 64 - 33)];
    webView.dataDetectorTypes = UIDataDetectorTypeAll;//数据检测，例如内容中有邮件地址，点击之后可以打开邮件软件编写邮件
    webView.delegate = self;
    [self.view addSubview:webView];
    
    /*添加下方工具栏*/
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, screenHeight - 44, screenWidth, 44)];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.bounds=CGRectMake(0, 0, 32, 32);
    [btnBack setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(webViewBack) forControlEvents:UIControlEventTouchUpInside];
    barButtonBack = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    barButtonBack.enabled = NO;
    
    UIBarButtonItem *btnSpacing = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil action:nil];
    
    UIButton *btnForward = [UIButton buttonWithType:UIButtonTypeCustom];
    btnForward.bounds = CGRectMake(0, 0, 32, 32);
    [btnForward setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [btnForward addTarget:self action:@selector(webViewForward) forControlEvents:UIControlEventTouchUpInside];
    barButtonForward = [[UIBarButtonItem alloc]initWithCustomView:btnForward];
    barButtonForward.enabled = NO;
    
    toolbar.items = @[barButtonBack, btnSpacing, barButtonForward];
    [self.view addSubview:toolbar];
    
}

#pragma mark 后退
-(void)webViewBack
{
    [webView goBack];
    
}

#pragma mark 前进
-(void)webViewForward
{
    [webView goForward];
    
}

#pragma mark 设置前进后退按钮状态
-(void)setBarButtonStatus
{
    if (webView.canGoBack)
    {
        barButtonBack.enabled = YES;
        
    }
    else
    {
        barButtonBack.enabled = NO;
        
    }
    if(webView.canGoForward)
    {
        barButtonForward.enabled = YES;
        
    }
    else
    {
        barButtonForward.enabled = NO;
        
    }
    
}

#pragma mark 浏览器请求
-(void)request:(NSString *)urlStr
{
    //创建url
    NSURL *url;
    
    //如果file://开头的字符串则加载bundle中的文件
    if([urlStr hasPrefix:FILE_HEAD])
    {
        //取得文件名
        NSRange range = [urlStr rangeOfString:FILE_HEAD];
        NSString *fileName = [urlStr substringFromIndex:range.length];
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    
    }
    else if(urlStr.length>0)
    {
        //如果是http请求则直接打开网站
        if ([urlStr hasPrefix:@"http"])
        {
            url = [NSURL URLWithString:urlStr];
        }
        else
        {//如果不符合任何协议则进行搜索
            urlStr = [NSString stringWithFormat:@"http://blog.csdn.net/wokenshin"];
        }
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//url编码
        url = [NSURL URLWithString:urlStr];
        
    }
    
    //创建请求
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    //加载请求页面
    [webView loadRequest:request];
    
}

#pragma mark - WebView 代理方法
#pragma mark 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示网络请求加载
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
}

#pragma mark 加载完毕
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //隐藏网络请求加载图标
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    //设置按钮状态
    [self setBarButtonStatus];
    
}
#pragma mark 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error detail:%@",error.localizedDescription);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"系统提示"
                                                 message:@"网络连接发生错误!"
                                                delegate:self cancelButtonTitle:nil
                                       otherButtonTitles:@"确定", nil];
    [alert show];
    
}


#pragma mark - SearchBar 代理方法
#pragma mark 点击搜索按钮或回车
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar2
{
    [self request:searchBar2.text];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    webView             = nil;
    toolbar             = nil;
    searchBar           = nil;
    barButtonBack       = nil;
    barButtonForward    = nil;
    
}
























@end
