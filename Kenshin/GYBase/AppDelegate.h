//
//  AppDelegate.h
//  GYBase
//
//  Created by doit on 16/4/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//
/*
 app描述： 本app没有做适配 当前以 6为主
 
 推荐资源
 http://www.cnblogs.com/kenshincui  kenshinCui 的 博客 ✨✨✨✨
 
 http://www.hcios.com/              宏创学院           ✨✨
 
 
 
 代理
 
 
 Block[非常重要]
 http://www.jianshu.com/p/0f0272df8285  one[重要基础]
 
 http://www.jianshu.com/p/3a8c59829ce6  two［深入］
 
 约束 Masonry(开源库) 纯代码布局
 http://www.cocoachina.com/ios/20141219/10702.html
 
 xib 约束
 http://www.jianshu.com/p/b88c65ffc3eb
 
 用Masonry约束思想进行xib约束
 http://www.jianshu.com/p/097f998fed99#
 
 网络编程[此开源库 一定要学会]
 AFNetworking
 
 极光推送－－官网［已经集成 很简单］
 
 百度定位－－官网［基本功能已经实现 更多功能用到的时候现学］
 
 支付宝 －－ 有空的时候弄
 
 友盟－－－后期添加
 
 */

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow          *window;
@property (strong, nonatomic) UIImageView       *launchView;//启动动画

@end

