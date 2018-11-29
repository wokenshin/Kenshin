//
//  JpushVC.m
//  GYBase
//
//  Created by doit on 16/4/14.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "JpushVC.h"
#import "Tools.h"
#import "JPUSHService.h"

@interface JpushVC ()

@end

@implementation JpushVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initJpushVCUI];
    [self registerNotificationsReceiveAPNS];
    
}

- (void)initJpushVCUI
{
    self.navigationItem.title = @"极光推送";
    self.view.backgroundColor = colorGray;
    
    //下面的UI将用来显示推送过来的信息
    [Tools toast:@"Easy，进入官网，几步搞定！" andCuView:self.view];
    
}

#pragma mark 注册通知－接收远程推送(触发函数)
- (void)registerNotificationsReceiveAPNS
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
}

#pragma mark - 接收远程推送的函数
- (void)networkDidSetup:(NSNotification *)notification
{
    NSLog(@"已连接————————networkDidSetup:%@", notification);
    
}

- (void)networkDidClose:(NSNotification *)notification
{
    NSLog(@"未连接——————————networkDidClose:%@", notification);
    
}


- (void)networkDidRegister:(NSNotification *)notification
{
    NSLog(@"已注册——————————networkDidRegister:%@", [notification userInfo]);
    
}

- (void)networkDidLogin:(NSNotification *)notification
{
    NSLog(@"已登录");
    if ([JPUSHService registrationID])
    {
        NSLog(@"已登录——————————————networkDidLogin:%@", notification);
        
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    NSLog(@"已接收到消息————————networkDidReceiveMessage:%@", notification);
    
}

- (void)serviceError:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    NSLog(@"推送错误————————————serviceError:%@", error);
    
}

#pragma mark 删除通知
- (void)deleteNotifications
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

- (void)dealloc
{
    [self deleteNotifications];
    [Tools NSLogClassDestroy:self];
    
}

@end
