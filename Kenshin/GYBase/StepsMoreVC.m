//
//  StepsMoreVC.m
//  GYBase
//
//  Created by kenshin on 16/9/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "StepsMoreVC.h"
#import <CoreMotion/CoreMotion.h>
#import "MJRefresh.h"
#import "DateUtil.h"
@interface StepsMoreVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) CMPedometer           *pedometer;
@property (nonatomic, strong) NSMutableArray        *datas;
@end

@implementation StepsMoreVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable])
    {
        NSLog(@"计步器不可用");
        return;
    }
    
    //2.创建计步器对象
    self.pedometer = [[CMPedometer alloc] init];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    [self setupTableRefresh];
    
}

#pragma mark 懒加载 pedometer
- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
    
}

- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
    
}

- (void)setupTableRefresh
{
    WS(ws);
    //下拉刷新[头部刷新]【加载最新数据】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws loadLastestDatas];
    }];
    
    //上啦刷新[底部刷新]【加载更多数据】
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [ws loadMoreDatas];
//    }];
    [self.tableView.mj_footer setHidden:YES];//初始刷新的时候只显示表头的刷新ui就好了
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
    
}

//加载最新数据
- ( void)loadLastestDatas
{
    //获取最近七天的凌晨的时间 用来获取最近七天的计步数据
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];//当前的时间
    
    //凌晨的时间[零时区]
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    
    for (int i = 0; i <= 20; i++)
    {
        NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-i toDate:startDate options:0];
        [self addStepsDataWithDate:endDate];
        
    }
    
    [self endRefresh];
    [self.tableView reloadData];
}

- (void)addStepsDataWithDate:(NSDate *)fromDate
{
    WS(ws);
    [self.pedometer queryPedometerDataFromDate:fromDate
                                        toDate:[fromDate dateByAddingTimeInterval:60*60*24]//后一天
                                   withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        //回到主线程 更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (pedometerData == nil)
            {
                return;
            }
            NSString *str = [NSString stringWithFormat:@"%@ 走了%@步", fromDate, pedometerData.numberOfSteps];
            NSLog(@"%@", str);
            [ws.datas addObject:str];
        }];
    }];
    
}

#pragma mark - 获取某年某月的天数
- (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

#pragma mark UITableViewDataSource
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas count];
    
}

#pragma mark UITableViewDelegate
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"kenshin"];
    cell.textLabel.text  = [self.datas objectAtIndex:indexPath.row];
    return cell;
    
}

//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
