//
//  DuoXuanVC.m
//  GYBase
//
//  Created by 刘万兵 on 17/1/9.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "DuoXuanVC.h"
#import "Tools.h"
#import "CellTest.h"

@interface DuoXuanVC ()<UITableViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) UIButton          *rightBtn;
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *datasM;

@end

@implementation DuoXuanVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initRightBtn];//点击cell中的多选按钮的时候 通过回调代码块来实现对数据源的修改
    [self initTable];
    
    
}

- (void)initTable
{
    //表
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"CellTest" bundle:nil] forCellReuseIdentifier:@"CellTest"];
    
    NSArray *arr = @[@"NO", @"NO", @"NO", @"NO", @"NO", @"NO", @"NO", @"NO", @"NO", @"NO"
                     , @"NO", @"NO", @"NO", @"NO", @"NO", @"NO", @"NO", @"NO", @"NO"];
    _datasM = [NSMutableArray arrayWithArray:arr];
    
}

- (void)initRightBtn
{
    _rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:RGB2Color(251, 93, 95) forState:UIControlStateNormal];
    [_rightBtn setTitleColor:RGB2Color(251, 80, 80) forState:UIControlStateHighlighted];
    _rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [_rightBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
}

- (void)submitAction
{
    NSLog(@"%@", _datasM);
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasM.count;
    
}

#pragma mark 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.创建cell
    CellTest *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTest" forIndexPath:indexPath];
    
    cell.model = [_datasM objectAtIndex:indexPath.row];
    cell.lineNum = [NSString stringWithFormat:@"第%zd行", indexPath.row];
    //阻挡长按变灰
    cell.selectedBackgroundView = [[UIView alloc] init];
    
    WS(ws);//核心代码
    cell.clickButtonBlock = ^(UIButton *btn){
        NSString *modelStr = [ws.datasM objectAtIndex:indexPath.row];
        if ([modelStr isEqualToString:@"YES"])
        {
            [ws.datasM replaceObjectAtIndex:indexPath.row withObject:@"NO"];
        }
        else
        {
            [ws.datasM replaceObjectAtIndex:indexPath.row withObject:@"YES"];
        }
        
        NSLog(@"%@", ws.datasM);
        [ws.tableView reloadData];
    };
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

#pragma mark 点击事件——cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
