
//
//  UIApplicationVC.m
//  GYBase
//
//  Created by doit on 16/5/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "UIApplicationVC.h"
#import "Tools.h"
#import "BlockButton.h"

@interface UIApplicationVC ()

@end

@implementation UIApplicationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"UIApplication";
    [self initApplicationVCUI];
    
    //还要了解 UIApplication 的代理 就是在 APPDelegate.m 中的代理
}

- (void)initApplicationVCUI
{
    //1.修改状态栏
    //2.打电话［真机］
    //3.发短信 发邮件［真机］
    //4.打开网页
    //5.联网状态
    //6.通知数(app右上角图标)
    
    
    //获取UIApplication 的单例
    UIApplication *app = [UIApplication sharedApplication];
    
    //1.通过获取UIApplication 来控制状态栏的显示 注意：在ios7之后 系统的状态栏默认由当前的控制器来控制，
    //所以ios7之后用UIApplication 来控制状态栏的显示和隐藏是无效的， 如果仍想用UIApplication控制 需要爱info.plist中添加一个key 并设置为No
    //即 View controller-based status bar appearance : NO
    //application控制的状态栏的全局的，即一处更改 处处统一， 而控制器控制的状态栏只在当前控制器内有效
    
    WS(ws);
    
    //状态栏 控制
    BlockButton *staturHiddenBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 100, 44)];
    [staturHiddenBtn setTitle:@"状态栏" forState:UIControlStateNormal];
    staturHiddenBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:staturHiddenBtn];
    staturHiddenBtn.block = ^(BlockButton *btn){
        //如果 View controller-based status bar appearance : YES
        //那么隐藏状态栏的工作 将交由当前的控制器来决定 建议用application来控制
        if (ws.isHiddenStatur)
        {
//            app.statusBarHidden = NO;//无动画效果
            [app setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];//动画效果
            ws.isHiddenStatur = NO;
        }
        else
        {
            app.statusBarHidden = YES;
//            [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            ws.isHiddenStatur = YES;
        }
    };
    
    //打开网页
    BlockButton *openWebBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, margin_10*2 + 64 + 44, 100, 44)];
    [openWebBtn setTitle:@"网页" forState:UIControlStateNormal];
    openWebBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:openWebBtn];
    
    openWebBtn.block = ^(BlockButton *btn){
        //打电话 发短信 发邮件 都是调用的 opemURL ios 是通过 这里的协议头(eg: http)来区分其行为的
        [app openURL:[NSURL URLWithString:@"http://manhua.dmzj.com/lanqiufeirenquancai/12515.shtml#@page=1"]];
    };
    
    
    float versionNumber=[[[UIDevice currentDevice] systemVersion] floatValue];
    if (versionNumber >= 8.0)
    {
        //通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        //接收用户的选择
        [app registerUserNotificationSettings:settings];
        
    }
    
    //app 通知数
    BlockButton *appNoticeNumBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, margin_10*3 + 64 + 44*2, 100, 44)];
    [appNoticeNumBtn setTitle:@"应用通知数" forState:UIControlStateNormal];
    appNoticeNumBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:appNoticeNumBtn];
    
    
    appNoticeNumBtn.block = ^(BlockButton *btn){
        //IOS 8之后 如果要使用 必须在下面函数执行之前 注册通知 即 [UIApplication registerUserNotificationSettings:]
        app.applicationIconBadgeNumber = 7;
        [Tools toast:@"按home键检查" andCuView:ws.view];
    };
    
    //清空通知
    BlockButton *clearNoticeNumBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*2 + 100, margin_10*3 + 64 + 44*2, 100, 44)];
    [clearNoticeNumBtn setTitle:@"清空知数" forState:UIControlStateNormal];
    clearNoticeNumBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:clearNoticeNumBtn];
    
    clearNoticeNumBtn.block = ^(BlockButton *btn){
        app.applicationIconBadgeNumber = 0;
        [Tools toast:@"按home键检查" andCuView:ws.view];
        
    };
    
    //网络状态[状态栏的菊花]
    BlockButton *netStatusBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*3 + 200, margin_10*3 + 64 + 44*2, 100, 44)];
    [netStatusBtn setTitle:@"网络状态" forState:UIControlStateNormal];
    netStatusBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:netStatusBtn];
    
    netStatusBtn.block = ^(BlockButton *btn){
        
        if (app.isNetworkActivityIndicatorVisible)
        {
            app.networkActivityIndicatorVisible = NO;
        }
        else
        {
            app.networkActivityIndicatorVisible = YES;
            [Tools toast:@"状态栏有菊花！" andCuView:ws.view];
        }
        
    };
    
    
    /*
     //电话
     [application openURL:[NSURL URLWithString:@"tel://10010"]];
     
     //短信
     [application openURL:[NSURL URLWithString:@"sms://10010"]];
     
     //邮件
     [application openURL:[NSURL URLWithString:@"mailto://wokenshin@vip.qq.com"]];
     
     //打开网页
     [application openURL:[NSURL URLWithString:@"http://www.cnblogs.com/xiaofeixiang/"]];
     
     */
}

//如果 View controller-based status bar appearance : YES
//- (BOOL)prefersStatusBarHidden
//{
//    //默认返回的是 NO
//    return YES;
//}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    //百度 如何输出 当前类名
}

@end
