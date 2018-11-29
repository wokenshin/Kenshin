//
//  LifeVC.m
//  GYBase
//
//  Created by doit on 16/5/15.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "LifeVC.h"
#import "Tools.h"

@implementation LifeVC

//控制器的生命周期：就时控制器中部分父类方法的执行顺序，一般时以view开头的方法都是生命周期中的方法

//控制器的view加载完成的时候［调用］
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    
    self.navigationItem.title = @"控制器的生命周期";
    self.view.backgroundColor = RGB2Color(148, 199, 11);
    [Tools toast:@"看codes" andCuView:self.view];
    
}

//控制器的view即将显示的时候［调用］
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
    
}

//控制器的view完全显示的时候［调用］
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s", __func__);
    
}

//控制器的view即将消失的时候［调用］
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%s", __func__);
    
}

//控制器的view完全消失的时候［调用］
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"%s", __func__);
    
}

//控制器的view即将布局子控件的时候［调用］
- (void)viewWillLayoutSubviews
{
    NSLog(@"%s", __func__);
    
}

//控制器的view布局子控件完成的时候［调用］
- (void)viewDidLayoutSubviews
{
    NSLog(@"%s", __func__);
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
