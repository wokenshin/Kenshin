//
//  Web3VC.m
//  GYBase
//
//  Created by doit on 16/6/13.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Web3VC.h"
#import "Tools.h"

@interface Web3VC ()<UIWebViewDelegate>//js页面交互   点击 文本 弹出 弹出框

@property (nonatomic, strong)UIWebView              *webView;

@end

@implementation Web3VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWeb3UI];
    [self request];
    
}

- (void)initWeb3UI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"页面调用Objc";
    
    /*添加浏览器控件*/
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;//数据检测类型，例如内容中有邮件地址，点击之后可以打开邮件软件编写邮件
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
}

#pragma mark 显示actionsheet
- (void)showSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
   destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitle
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:@"这个是UIAlertController的默认样式"
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             [Tools toast:@"取消" andCuView:self.view];
                                                         }];
    
    UIAlertAction *okAction    = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action){
                                                            [Tools toast:@"好的" andCuView:self.view];
                                                        }];
    
    //按钮的顺序由UIAlertAction 的style来决定的
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
     [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark 浏览器请求
- (void)request
{
    //加载html内容
    NSString *htmlStr = @"<html>\
    <head><title>kenshin的 Blog</title></head>\
    <body style=\"color:#0092FF;\">\
    <h1 id=\"header\">I am Kenshin</h1>\
    <p id=\"blog\">iOS 开发</p>\
    </body></html>";
    
    //加载请求页面
    [_webView loadHTMLString:htmlStr baseURL:nil];
    
}

#pragma mark - WebView 代理方法
#pragma mark 页面加载前(此方法返回false则页面不再请求)
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.URL.scheme);
    if ([request.URL.scheme isEqual:@"kenshin"])
    {
        NSString *paramStr = request.URL.query;
        NSArray  *params = [[paramStr stringByRemovingPercentEncoding] componentsSeparatedByString:@"&"];
        NSString *otherButton = nil;
        
        [self showSheetWithTitle:params[0]
               cancelButtonTitle:params[1]
          destructiveButtonTitle:params[2]
               otherButtonTitles:otherButton];
        
        return false;
    }
    return true;
    
}

#pragma mark 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示网络请求加载
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
}

#pragma mark 加载完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //隐藏网络请求加载图标
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    
    //加载js文件
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"web.js" ofType:nil];
    NSString *jsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js文件到页面
    [_webView stringByEvaluatingJavaScriptFromString:jsStr];

}

#pragma mark 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error detail:%@", error.localizedDescription);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"
                                                   message:@"网络连接发生错误!"
                                                  delegate:self cancelButtonTitle:nil
                                         otherButtonTitles:@"确定", nil];
    [alert show];

}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _webView = nil;
    
}

@end
