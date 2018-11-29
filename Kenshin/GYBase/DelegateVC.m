//
//  DelegateVC.m
//  GYBase
//
//  Created by doit on 16/5/9.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    代理的设计模式，这是iOS中一种消息传递的方式，也可以通过这种方式来传递一些参数
 
 
     代理主要由三部分组成：
     
     协议：用来指定代理双方可以做什么，必须做什么,只有方法的声明，没有方法的实现。
     
     代理：根据指定的协议，完成委托方需要实现的功能。
     
     委托：根据指定的协议，指定代理去完成什么功能。
 
 */

#import "DelegateVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "XibTwoVC.h"

@interface DelegateVC ()

@end

@implementation DelegateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDelegateVCUI];
    
}

- (void)initDelegateVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"代理";
    
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(30, 100, screenWidth - 30*2, 36)];
    [btn setBackgroundNormalColor:RGB2Color(24, 23, 30)];
    [btn setTitle:@"下面一个控制器用到了代理" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        XibTwoVC *vc = [XibTwoVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}















@end
