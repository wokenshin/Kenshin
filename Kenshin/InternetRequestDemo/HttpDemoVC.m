//
//  HttpDemoVC.m
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    http://www.cnblogs.com/kenshincui/p/4042190.html
 
 
    学习目录：
     Web请求和响应
       使用代理方法
       简化请求方法
       图片缓存
       扩展--文件分段下载
       扩展--文件上传
 
     NSURLSession
       数据请求
       文件上传
       文件下载
       会话
     
    UIWebView
       浏览器实现
       UIWebView与页面交互
 
    网络状态
 */

#import "HttpDemoVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "WebOneVC.h"
#import "WebTwoVC.h"
#import "WebThreeVC.h"
#import "Web1VC.h"
#import "Web2VC.h"
#import "Web3VC.h"

@interface HttpDemoVC ()

@end

@implementation HttpDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initHttpDemoUI];
    
}

- (void)initHttpDemoUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"原生 综合";
    
    WS(ws);
    //Web请求和响应
    UIButtonK *webOneBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 300/2, 64 + margin_10, 300, 44)];
    [webOneBtn setStyleGreen];
    [webOneBtn setTitle:@"Web请求和响应" forState:UIControlStateNormal];
    webOneBtn.clickButtonBlock = ^(UIButtonK *b){
        WebOneVC *vc = [WebOneVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //分段下载
    UIButtonK *webTwoBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 300/2, 64 + margin_10*2 + 44, 300, 44)];
    [webTwoBtn setStyleGreen];
    [webTwoBtn setTitle:@"分段下载" forState:UIControlStateNormal];
    webTwoBtn.clickButtonBlock = ^(UIButtonK *b){
        WebTwoVC *vc = [WebTwoVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //NSURLSession
    UIButtonK *webThreeBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 300/2, 64 + margin_10*3 + 44*2, 300, 44)];
    [webThreeBtn setStyleGreen];
    [webThreeBtn setTitle:@"NSURLSession" forState:UIControlStateNormal];
    webThreeBtn.clickButtonBlock = ^(UIButtonK *b){
        WebThreeVC *vc = [WebThreeVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //UIWebView
    UIButtonK *webBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 300/2, 64 + margin_10*4 + 44*3, 300, 44)];
    [webBtn setStyleGreen];
    [webBtn setTitle:@"UIWebView" forState:UIControlStateNormal];
    webBtn.clickButtonBlock = ^(UIButtonK *b){
        Web1VC *vc = [Web1VC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //页面交互
    UIButtonK *webCtrlBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 300/2, 64 + margin_10*5 + 44*4, 300, 44)];
    [webCtrlBtn setStyleGreen];
    [webCtrlBtn setTitle:@"UIWebView交互" forState:UIControlStateNormal];
    webCtrlBtn.clickButtonBlock = ^(UIButtonK *b){
        Web2VC *vc = [Web2VC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //页面中调用ObjC方法
    UIButtonK *webOcBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 300/2, 64 + margin_10*6 + 44*5, 300, 44)];
    [webOcBtn setStyleGreen];
    [webOcBtn setTitle:@"页面中调用ObjC方法" forState:UIControlStateNormal];
    webOcBtn.clickButtonBlock = ^(UIButtonK *b){
        Web3VC *vc = [Web3VC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };

    
    [self.view addSubview:webOneBtn];
    [self.view addSubview:webTwoBtn];
    [self.view addSubview:webThreeBtn];
    [self.view addSubview:webBtn];
    [self.view addSubview:webCtrlBtn];
    [self.view addSubview:webOcBtn];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}




























@end
