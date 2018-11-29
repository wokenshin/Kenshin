//
//  AFNLogin.m
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    1.IOS 大神班 网络课程
    2.参考 贵阳项目 运用AFN
 
 */

#import "AFNDemo.h"
#import "UIButtonK.h"
#import "Tools.h"

#import "AFHTTPSessionManager.h"

@interface AFNDemo ()

@end

@implementation AFNDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAFNLoginUI];
    [Tools toast:@"暂未开发" andCuView:self.view];
    
}

- (void)initAFNLoginUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"AFN 综合运用";
    
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}






































@end
