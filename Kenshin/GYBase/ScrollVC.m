//
//  ScrollVC.m
//  GYBase
//
//  Created by doit on 16/5/27.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
 
 */

#import "ScrollVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "ScrollDemoVC.h"
#import "ScrollDemoVC1.h"
#import "ScrollDemoVC2.h"

@interface ScrollVC ()


@end

@implementation ScrollVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initScrollUI];
    
}

- (void)initScrollUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"滚动视图";
    
    WS(ws);
    
    //demo1
    UIButtonK *btn1 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, margin_10 + 64, 100, 44)];
    [btn1 setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [btn1 setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    [btn1 setYuanJiao:8];
    [btn1 setTitle:@"demo1" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    btn1.clickButtonBlock = ^(UIButtonK *b){
        ScrollDemoVC *demo1VC = [ScrollDemoVC new];
        [ws.navigationController pushViewController:demo1VC animated:YES];
        
    };
    
    //demo2
    UIButtonK *btn2 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*2 + 100, margin_10 + 64, 100, 44)];
    [btn2 setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [btn2 setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    [btn2 setYuanJiao:8];
    [btn2 setTitle:@"demo2" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    btn2.clickButtonBlock = ^(UIButtonK *b){
        ScrollDemoVC1 *demo2VC = [ScrollDemoVC1 new];
        [ws.navigationController pushViewController:demo2VC animated:YES];
        
    };
    
    //demo3
    UIButtonK *btn3 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*3 + 200, margin_10 + 64, 100, 44)];
    [btn3 setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [btn3 setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    [btn3 setYuanJiao:8];
    [btn3 setTitle:@"demo3" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    btn3.clickButtonBlock = ^(UIButtonK *b){
        ScrollDemoVC2 *demo2VC = [ScrollDemoVC2 new];
        [ws.navigationController pushViewController:demo2VC animated:YES];
        
    };
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
