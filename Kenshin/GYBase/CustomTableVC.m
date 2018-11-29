//
//  CustomTableVC.m
//  GYBase
//
//  Created by doit on 16/6/1.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    自定义 微博页面
 
 */

#import "CustomTableVC.h"
#import "Tools.h"
#import "KStatus.h"
#import "KStatusTableViewCell.h"

@interface CustomTableVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) NSMutableArray                *status;
@property (nonatomic, strong) NSMutableArray                *statusCells;//存储cell，用于计算高度
@end

@implementation CustomTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self initCustomTableUI];
    
}

- (void)initData
{
    
    NSArray *array = [Tools plistArrayTypeWithName:@"CustomTable.plist"];
    _status = [NSMutableArray new];
    _statusCells = [NSMutableArray new];
    
    //遍历
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_status addObject:[KStatus statusWithDictionary:obj]];
        KStatusTableViewCell *cell = [[KStatusTableViewCell alloc]init];
        [_statusCells addObject:cell];
        
    }];
    
}

- (void)initCustomTableUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"自定义table";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //创建一个分组样式的UITableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    
    [self.view addSubview:_tableView];

}

#pragma mark - UITableViewDataSource
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _status.count;

}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"StatusCellId";
    KStatusTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[KStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    //在此设置微博，以便重新布局
    KStatus *status = _status[indexPath.row];
    cell.status = status;
    return cell;
    
}

#pragma mark - UITableViewDelegate

#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KStatusTableViewCell *cell = _statusCells[indexPath.row];
    cell.status = _status[indexPath.row];
    return cell.height;
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _tableView   = nil;
    _status      = nil;
    _statusCells = nil;
    
}
@end
