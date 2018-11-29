//
//  LeftDelAndPartRefreshVC.m
//  GYBase
//
//  Created by kenshin on 16/8/27.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "LeftDelAndPartRefreshVC.h"

@interface LeftDelAndPartRefreshVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSources;

@end

@implementation LeftDelAndPartRefreshVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"左滑删除";
    [self initMyData];
    [self initMyTable];
    
}

- (void)initMyData
{
    _dataSources = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i ++)
    {
        NSString *str = [NSString stringWithFormat:@"这里是第%zd行", i];
        [_dataSources addObject:str];
    }
    
}

- (void)initMyTable
{
    //由于Table放在了导航控制器里面，所以table得内容自动下移了导航条个高度【64】，这里table的高度需要减去64，不让当数据多时，底部的cell无法显示完整
    //因为底部的cell显示的区域超出了手机屏幕,原因就是因为这里自动下滑导致的，所以需要调整table的可视化高度
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark UITableViewDataSource
//返回cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSources count];
    
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ABC"];
    cell.textLabel.text  = [_dataSources objectAtIndex:indexPath.row];
    return cell;
    
}

// 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
    
}

//实现左滑删除【第一步】IOS8之后的api
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //此处的EditingStyle可等于任意UITableViewCellEditingStyle，该行代码只在iOS8.0以前版本有作用，也可以不实现。
    editingStyle = UITableViewCellEditingStyleDelete;
    
}

//实现左滑删除【第二步】
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(ws);
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction
                                             rowActionWithStyle:UITableViewRowActionStyleDestructive
                                             title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                 [ws deleteCellDataWith:indexPath];
    }];
    
    //此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
    UITableViewRowAction *editRowAction = [UITableViewRowAction
                                           rowActionWithStyle:UITableViewRowActionStyleNormal
                                           title:@"其他"
                                           handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
    }];
    
    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[deleteRoWAction, editRowAction];//最后返回这俩个RowAction 的数组
}

//删除cell数据
- (void)deleteCellDataWith:(NSIndexPath *)indexPath
{
    [_dataSources removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
