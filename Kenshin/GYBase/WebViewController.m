//
//  WebViewController.m
//  GYBase
//
//  Created by doit on 16/5/20.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "WebViewController.h"
#import "Tools.h"

@interface WebViewController ()<UIWebViewDelegate>

@property(nonatomic, retain) UIWebView      *webView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}



#pragma mark - webview

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //关闭进度
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //关闭进度[提示出错]
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示进度
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}



@end
