//
//  TableDefTwoVC.m
//  GYBase
//
//  Created by kenshin on 16/8/24.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "TableDefTwoVC.h"

@interface TableDefTwoVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, assign) BOOL                  isSetCell;

@end

@implementation TableDefTwoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"有分区";
    [self initMyData];//要先有数据，不然下面表的代理在访问dataSource时会是nil
    [self initMyTable];
    [self addNavRightBtn_setCellStyle];
    
}

- (void)addNavRightBtn_setCellStyle
{
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                target:self
                                action:@selector(setCellStyleAction)];
    NSArray *arrBtns = @[btnItem];
    self.navigationItem.rightBarButtonItems = arrBtns;
    
}

- (void)setCellStyleAction
{
    _isSetCell = !_isSetCell;
    [self.tableView reloadData];
    
}

- (void)initMyTable
{
    //style:只有两种样式 一种是有分区的 另一种是没有分区的
    //UITableViewStylePlain,          // regular table view
    //UITableViewStyleGrouped         // preferences style table view
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    
}

- (void)initMyData
{
    NSMutableDictionary *model_1 = [NSMutableDictionary new];
    [model_1 setObject:@"appIcon120"        forKey:@"img"];
    [model_1 setObject:@"用木花道"             forKey:@"title"];
    [model_1 setObject:@"自称天才！因为喜欢晴子而开始打篮球。"            forKey:@"detail"];
    
    NSMutableDictionary *model_2 = [NSMutableDictionary new];
    [model_2 setObject:@"charater_caizi"    forKey:@"img"];
    [model_2 setObject:@"彩子"             forKey:@"title"];
    [model_2 setObject:@"篮球部经理二年级，是宫城单恋的女生。"            forKey:@"detail"];
    
    NSMutableDictionary *model_3 = [NSMutableDictionary new];
    [model_3 setObject:@"charater_liuchuan" forKey:@"img"];
    [model_3 setObject:@"流川枫"             forKey:@"title"];
    [model_3 setObject:@"喜欢睡觉，耍酷。篮球技术一流。"            forKey:@"detail"];
    
    NSMutableArray *arrM = [NSMutableArray new];
    [arrM addObject:model_1];
    [arrM addObject:model_2];
    [arrM addObject:model_3];
    
    _dataSource = [NSMutableArray new];
    [_dataSource addObject:arrM];
    [_dataSource addObject:arrM];
    
}

#pragma mark UITableViewDataSource
//返回多少分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSource count];
    
}

//在每个分区里返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
    
}

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     UITableViewCellStyleDefault    :   左边 UIImageView + Lable
     UITableViewCellStyleSubtitle   :   左边 UIImageView + Label，detailLab在Label正下方
     UITableViewCellStyleValue1     :   左边 UIImageView + Label + 右边detailLab
     UITableViewCellStyleValue2     :   Label + detailLab
     */
    
    //这里的Cell的UIImageView的Size 是由Cell的高度决定的 它们相等
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"kenshin"];
    NSDictionary *dic = _dataSource[indexPath.section][indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.textLabel.text  = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
    
    if (_isSetCell) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor blueColor];
        [Tools setCornerRadiusWithView:cell.imageView andAngle:30];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置箭头
    }
    
    return cell;
    
}

#pragma mark 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

#pragma mark 返回分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;

}

#pragma mark 返回分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
    
}

#pragma mark 设置分组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        [tableView setSectionHeaderHeight:30];
        return @"湘北篮球队";
    }
    return nil;
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
