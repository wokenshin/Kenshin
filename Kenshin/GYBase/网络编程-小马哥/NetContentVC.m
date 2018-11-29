//
//  NetContentVC.m
//  GYBase
//
//  Created by kenshin on 16/9/20.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    
    重点中的重点！！！
 
 
 */

#import "NetContentVC.h"
#import "Tools.h"

@interface NetContentVC ()

@end

@implementation NetContentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"网络编程";
//    self.automaticallyAdjustsScrollViewInsets = NO;//禁止控制器 自动改动ui y坐标[当控件是滚动视图或 表时[表也是滚动视图]]
    
}

- (IBAction)bottomBtn:(id)sender
{
    [Tools toast:@"点你妹啊" andCuView:self.view andHeight:300];
    
}


@end
