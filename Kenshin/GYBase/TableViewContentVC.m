//
//  TableViewContentVC.m
//  GYBase
//
//  Created by kenshin on 16/8/24.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "TableViewContentVC.h"
#import "TableDefOneVC.h"
#import "TableDefTwoVC.h"
#import "TableViewAddHeaderVCViewController.h"
#import "LeftDelAndPartRefreshVC.h"

@interface TableViewContentVC ()

@end

@implementation TableViewContentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"由浅入深TableView";
    
}


//tableView 默认样式 无分区
- (IBAction)btnTableDefaultOne:(id)sender
{
    TableDefOneVC *vc = [TableDefOneVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//tableView 默认样式 有分区
- (IBAction)btnTableDefaultTwo:(id)sender
{
    TableDefTwoVC *vc = [TableDefTwoVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//tableView 添加表头
- (IBAction)btnAddHeaderView:(id)sender
{
    TableViewAddHeaderVCViewController *vc = [TableViewAddHeaderVCViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//左滑删除+局部刷新
- (IBAction)btnLeftDelAndPartRefresh:(id)sender
{
    LeftDelAndPartRefreshVC *vc = [LeftDelAndPartRefreshVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
