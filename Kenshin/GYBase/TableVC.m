//
//  TableVC.m
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    http://www.cnblogs.com/kenshincui/p/3931948.html
 
 */

#import "TableVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "ContactVC.h"
#import "CustomTableVC.h"
#import "KTableVC.h"
#import "KTableVC2.h"
#import "TableViewContentVC.h"

@interface TableVC ()

@end

@implementation TableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableUI];
    
}

- (void)initTableUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"TableView 综合";
    
    CGFloat widthbtn = screenWidth * 0.65;
    CGFloat xBtn     = screenWidth/2 - widthbtn/2;
    
    WS(ws);
    
    //默认表
    UIButtonK *btn1 = [[UIButtonK alloc] initWithFrame:CGRectMake(xBtn, 64 + margin_10, widthbtn, 44)];
    [btn1 setTitle:@"DefaultTable" forState:UIControlStateNormal];
    [btn1 setStyleGreen];
    [self.view addSubview:btn1];
    btn1.clickButtonBlock = ^(UIButtonK *b){
        ContactVC *vc = [ContactVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //自定义表
    UIButtonK *btn2 = [[UIButtonK alloc] initWithFrame:CGRectMake(xBtn, 64 + margin_10*2 + 44, widthbtn, 44)];
    [btn2 setTitle:@"CustomTable" forState:UIControlStateNormal];
    [btn2 setStyleGreen];
    [self.view addSubview:btn2];
    btn2.clickButtonBlock = ^(UIButtonK *b){
        CustomTableVC *vc = [CustomTableVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //默认表控制器[可搜索]
    UIButtonK *btn3 = [[UIButtonK alloc] initWithFrame:CGRectMake(xBtn, 64 + margin_10*3 + 44*2, widthbtn, 44)];
    [btn3 setTitle:@"UITableViewController" forState:UIControlStateNormal];
    [btn3 setStyleGreen];
    [self.view addSubview:btn3];
    btn3.clickButtonBlock = ^(UIButtonK *b){
        KTableVC *vc = [KTableVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //默认表控制器[可搜索]优化搜索
    UIButtonK *btn4 = [[UIButtonK alloc] initWithFrame:CGRectMake(xBtn, 64 + margin_10*4 + 44*3, widthbtn, 44)];
    [btn4 setTitle:@"UITableViewController" forState:UIControlStateNormal];
    [btn4 setStyleGreen];
    [self.view addSubview:btn4];
    btn4.clickButtonBlock = ^(UIButtonK *b){
        KTableVC2 *vc = [KTableVC2 new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //深入学习
    UIButtonK *btn5 = [[UIButtonK alloc] initWithFrame:CGRectMake(xBtn, 64 + margin_10*5 + 44*4, widthbtn, 44)];
    [btn5 setTitle:@"由浅入深TableView" forState:UIControlStateNormal];
    [btn5 setStyleGreen];
    [self.view addSubview:btn5];
    btn5.clickButtonBlock = ^(UIButtonK *b){
        TableViewContentVC *vc = [TableViewContentVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
