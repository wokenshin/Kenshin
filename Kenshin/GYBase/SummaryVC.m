//
//  OneVC.m
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SummaryVC.h"
#import "SummaryModel.h"
#import "SummaryFrame.h"
#import "SummaryCell.h"
#import "Tools.h"

@interface SummaryVC ()
/**
 *  存放所有cell的frame模型数据
 */
@property (nonatomic, strong) NSArray     *modelFrames;
@property (nonatomic, strong) UIControl   *netWarningCtrl;
@end

@implementation SummaryVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSummaryVCUI];
    
    //接收实时的网络状态通知[本页面初始化的时候 收不到当前的网络状态通知，因为在第一次发送通知的时候 本页面尚未初始化，
    //只有改变网络状态时且本页面初始化完成后 才能收到通知]
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(realCheckNetstatus:)
                                                 name:@"REAL_NET_STATUS"
                                               object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Tools setNavigationBarBackgroundColor:RGB2Color(20, 30, 50) andTextColor:[UIColor whiteColor]];
    
}

//实时监测网络状态 from AppDelegate.m中的通知
- (void)realCheckNetstatus:(NSNotification *)notice
{
    NSDictionary *dic = [notice userInfo];
    NSString *cuNetStatus = [dic objectForKey:@"REAL_NET_STATUS"];
    
    if (self.netWarningCtrl == nil)
    {
        self.netWarningCtrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
        self.netWarningCtrl.backgroundColor = RGB2Color(254, 223, 226);
        [self.netWarningCtrl addTarget:self action:@selector(pressNetStatusWarningTip) forControlEvents:UIControlEventTouchUpInside];
        //图片
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, (44-25)/2.0, 25, 25)];
        imgV.image = [UIImage imageNamed:@"gantanhao"];
        
        //文本
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
        title.text = @"当前网络不可用，请检查你的网络设置";
        title.textColor = RGB2Color(115, 101, 101);
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        
        [self.netWarningCtrl addSubview:imgV];
        [self.netWarningCtrl addSubview:title];
        
    }
    
    if ([cuNetStatus isEqualToString:@"未知"] || [cuNetStatus isEqualToString:@"无连接"])
    {
        self.netWarningCtrl.hidden = NO;
         self.tableView.tableHeaderView = self.netWarningCtrl;
        
    }
    else
    {
        self.netWarningCtrl.hidden = YES;
        self.tableView.tableHeaderView = nil;
        
    }
    
}


- (void)pressNetStatusWarningTip
{
    //仿微信跳转到一个说明页面
    [Tools toast:@"未处理" andCuView:self.view];
    
}

- (void)initSummaryVCUI
{
    self.navigationItem.title = @"Summary";
    self.tableView.separatorStyle = NO;//隐藏分割线
    self.tableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    
}

#pragma mark 数据源
- (NSArray *)modelFrames
{
    if (_modelFrames == nil)
    {
        // 初始化
        // 1.获得plist的全路径［plist是一个数组，数组里面存放的是若干相同结构的字典］
        NSString *path = [[NSBundle mainBundle] pathForResource:@"summary.plist" ofType:nil];
        
        // 2.加载数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *modelsFrameArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray)
        {
            // 3.1.创建模型对象
            SummaryModel *models = [SummaryModel summaryModel:dict];
            
            // 3.2.创建模型对象
            SummaryFrame *statusFrame = [[SummaryFrame alloc] init];
            statusFrame.summaryModel = models;
            
            // 3.2.添加模型对象到数组中
            [modelsFrameArray addObject:statusFrame];
        }
        
        // 4.赋值
        _modelFrames = modelsFrameArray;

    }
    return _modelFrames;
    
}

#pragma mark - 实现数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelFrames.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    SummaryCell *cell = [SummaryCell cellWithTableView:tableView];
    
    // 2.在这个方法算好了cell的高度
    cell.modelFrame = self.modelFrames[indexPath.row];
    
    // 3.返回cell
    return cell;
    
}

#pragma mark - 实现代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出这行对应的frame模型
    SummaryFrame *modelsFrame = self.modelFrames[indexPath.row];
    return modelsFrame.cellHeight;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [Tools NSLogClassDestroy:self];
    
}

- (void)dealloc
{
    //删除通知
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:@"REAL_NET_STATUS" object:nil];
    
    [Tools NSLogClassDestroy:self];
    self.modelFrames    = nil;
    self.netWarningCtrl = nil;
    
}


@end
