//
//  AppDelegate.m
//  BaseGY
//
//  Created by doit on 16/4/6.
//  Copyright © 2016年 kenshin. All rights reserved.

//这个app 的内容为在贵阳工作期间学习的部分内容 以及之前在遵义公司所学的部分内容

//Block                     BlockDemo
//autoLayout                LayoutDemo


#import "AppDelegate.h"
#import "ContentsVC.h"
#import "LoginVC.h"
#import "Tools.h"
#import "NSUserDefaultTools.h"
#import "LaunchVC.h"
#import "TabBarVC.h"
#import "AFNetworkReachabilityManager.h"
#import <AVFoundation/AVFoundation.h>

//极光推送导入
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()
{
    LaunchVC        *launchViewOfMine;
    
}
@end

@implementation AppDelegate


#pragma mark - AppDelegate
//启动时调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self intoFirstVC];
    [self setNavStyle];
    [self setLaunchViewWithDuration:2.0];//启动动画
    [self remoteCtrlAction];//远程控制事件［耳机监控］
    
    [self dataShareWithWidgetFXW];//Widget 数据共享
    
    //服务
    [self realCheakNetStatus];//监测网络状态
    [self registerNotification:launchOptions];//极光推送
    
    return YES;
    
}

//程序失去焦点的时候调用（不能跟用户进行交互了）
- (void)applicationWillResignActive:(UIApplication *)application
{
    //将要进入后台
    NSLog(@"%s",__func__);
    
}

//app被中断之后，先进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%s",__func__);
    
}

//在app被中断后继续时，要从后台模式切换到前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //从后台进入前台后，首先调用的是 applicationWillEnterForeground: 然后是 applicationDidBecomeActive:
    
}

//当应用程序获取焦点的时候调用 获取到焦点之后 才能进行交互
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    
}

//程序在某些情况下被终结时会调用这个方法
- (void)applicationWillTerminate:(UIApplication *)application
{
    
    
}

#pragma mark - 设置根控制器
- (void)intoFirstVC
{
    
    /*
        验证之前是否登录过：登录过 则将登录后的主界面设置成根控制器，否则将登录界面设置成根控制器
     
     */
    
    //验证之前是否登录过
    NSString *username = [NSUserDefaultTools getUserName];
    
    //初始化导航控制器 并将 vc 设置为根控制器
    UINavigationController *rootNavController = nil;
    
    //检查之前是否登录过 设置响应的根控制器
    if (username == nil)
    {
        LoginVC *vc = [LoginVC new];
        rootNavController = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    else
    {
        ContentsVC *vc = [ContentsVC new];
        rootNavController = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    //设置窗口的根控制器，显示窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootNavController;
    [self.window makeKeyAndVisible];
    
    /*
     
     导航条的内容的设置 是由当前的栈顶控制器来决定的。
     详细：换言之，如果当前设置导航条内容的控制器不是栈顶控制器，那么设置的内容将不会生效。
     因为当前显示的界面是栈顶控制器，所以苹果公司在设计程序的时候要求导航控制器的内容应该由栈顶控制器来决定。
     
     navigationItem 是导航条内容的属性，要修改导航条内容时，需要获取该属性进行设置。
     
     导航条按钮的frame 的坐标为止由系统控制，无法修改（自己设置的不会生效）
     大小 规范为 35*35
     */
}

#pragma mark 设置导航颜色 标题颜色
- (void)setNavStyle
{
    //修改程序中所有的显示的navigationbar的颜色，字体
    
    [UINavigationBar  appearance].barTintColor = colorNavBar;//导航栏背景
    [UINavigationBar  appearance].tintColor = [UIColor whiteColor];//返回按钮 和 返回标题
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];//导航栏标题
    
    //隐藏返回按钮的标题[全局的]其实时修改了y值 这个方式不太好：因为左边标题的长度还是把中间标题像右挤压了
//    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
}

#pragma mark 启动动画
- (void)setLaunchViewWithDuration:(NSTimeInterval)time
{
    //[用一个控制器来当启动动画]
    launchViewOfMine = [LaunchVC new];
    [self.window addSubview:launchViewOfMine.view];
    [self.window bringSubviewToFront:launchViewOfMine.view];
    
    //time 秒后 触发
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(LaunchView) userInfo:nil repeats:NO];

}

#pragma mark 启动view
- (void)LaunchView
{
    
    [UIView animateWithDuration:0.0 animations:^{
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
             
             launchViewOfMine.view.alpha = 0.0;
             
         } completion:^(BOOL finished)
          {
              [launchViewOfMine.view removeFromSuperview];
              launchViewOfMine = nil;
          }];
     }];

}

#pragma mark 实时监测网络
- (void)realCheakNetStatus
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];//打开监测
    
    WS(ws);
    //监测网络状态回调
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown://未知
            {
                [ws realCheakNetStatus:@"未知"];
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable://无连接
            {
                [ws realCheakNetStatus:@"无连接"];
                
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN://2G 3G 4G 自带网络
            {
                [ws realCheakNetStatus:@"自带网络"];
                
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
            {
                [ws realCheakNetStatus:@"WIFI"];
                
            }
                break;
                
            default:
                break;
        }
    }];
    
}

- (void)realCheakNetStatus:(NSString *)statusStr
{
    //发送通知：当前网络状态
    
    NSDictionary *infoDic = [[NSDictionary alloc] initWithObjectsAndKeys:statusStr, @"REAL_NET_STATUS", nil];
    NSNotification *notification = [NSNotification notificationWithName:@"REAL_NET_STATUS" object:nil userInfo:infoDic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

#pragma mark 远程控制事件  \:ContentsVC\OnePage\HandPose\RemoteCtrlVC.m
- (void)remoteCtrlAction
{
    //设置播放会话，在后台可以继续播放（还需要设置程序允许后台运行模式）Capabilities --> Background Modes --> Audio,xxxxxx 勾选即可
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    if(![[AVAudioSession sharedInstance] setActive:YES error:nil])
    {
        NSLog(@"Failed to set up a session.");
    }
    
    //启用远程控制事件接收
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
}
//—————————————————————————————————————————————————极光推送————————————————————————————————————————————————————————
/*
 还是要注意证书的问题，基本流程都会了。有些时候还是会莫名其妙的报错，xcode中 设置描述文件的时候找不到证书，简单粗暴的方法 删除全部 重新走一遍流程ok
 */

#pragma mark 注册远程推送
- (void)registerNotification:(NSDictionary *)launchOptions
{
    
    //注册远程推送
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Override point for customization after application launch.
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"fe5326c033d4cf08d05c1605"//from 极光平台
                          channel:@"Publish channel"//发布渠道 eg： AppStory
                 apsForProduction:NO
            advertisingIdentifier:advertisingId];
    
}

#pragma mark 注册远程推送的 token
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    
    //upload device token
    [JPUSHService registerDeviceToken:deviceToken];
    
}

#pragma mark 接收远程推送
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", userInfo);
    
}

#pragma mark 接收远程推送 兼容IOS7
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler
{
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"收到通知:%@", userInfo);
    
}

#pragma mark 接收远程推送 兼容IOS10
/*
 OS10收到通知不再是在 [application: didReceiveRemoteNotification:]方法去处理，
  iOS10推出新的代理方法，接收和处理各类通知（本地或者远程）
 */


#pragma mark 注册推送 失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

//—————————————————————————————————————————————————百度定位—————————————————————————————————————————————————————————————————
//http://lbsyun.baidu.com/index.php?title=iossdk 官方
//注意： 在配置 Other linker Flags 为 -ObjC 时， 编译报错了 提示极光相关的错误 不知道为什么 所以没有配置此项 此项设置 与使用xib map有关
//如果不使用xib的 mapview  貌似没有关系 姑且这样


- (void)onGetNetworkState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"联网成功");
        
    }
    else
    {
        NSLog(@"onGetNetworkState %d",iError);
        
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"授权成功");//如果没有授权成功 地图是不会显示的 原因很可能是 ak 没有设置正确
        
    }
    else
    {
        NSLog(@"onGetPermissionState %d",iError);
        
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:@"IAMYOURFATHER"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你点击了%@按钮",[url host]] delegate:nil cancelButtonTitle:@"好的👌" otherButtonTitles:nil, nil];
        [alert show];
    }
    return  YES;
}

#pragma mark Widget 数据共享 NSUserDefaults 和 NSFileManager
- (void)dataShareWithWidgetFXW
{
    //NSUserDefaults
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.sanhe.kenshin"];//注意这个地方设置的名字是groupId
//    [shared setObject:@"哼哼" forKey:@"test"];
    NSArray *arr = @[@{@"key1":@"fxw", @"key2":@"csq"},
                     @{@"key1":@"fww", @"key2":@"zsh"},
                     @{@"key1":@"kenshin", @"key2":@"toma"}];
    [shared setObject:arr forKey:@"test"];
    [shared synchronize];
    
    
    //NSFileManager
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.sanhe.kenshin"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/good"];
    
    NSString *value = @"Kenshin";
    BOOL result = [value writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (!result)
    {
        NSLog(@"%@",err);
    }
    else
    {
        NSLog(@"save value:%@ success.",value);
    
    }
    
}


@end
