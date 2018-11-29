//
//  TableDefOneVC.m
//  GYBase
//
//  Created by kenshin on 16/8/24.
//  Copyright © 2016年 kenshin. All rights reserved.
//

/*
 
 UITableView 默认有两种样式：一种是不带分区的   一种是带分区的 可是在初始化的时候指定选择哪种样式
 
 typedef NS_ENUM(NSInteger, UITableViewStyle) {
 
 UITableViewStylePlain,          // regular table view
 UITableViewStyleGrouped         // preferences style table view
 };
 
 
 UITableViewCell 默认有四中样式：
 typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
 
 UITableViewCellStyleDefault,    // 左侧显示textLabel（不显示detailTextLabel），imageView可选（显示在最左边）
 UITableViewCellStyleValue1,     // 左侧显示textLabel、右侧显示detailTextLabel（默认蓝色），imageView可选（显示在最左边）
 UITableViewCellStyleValue2,     // 左侧依次显示textLabel(默认蓝色)和detailTextLabel，imageView可选（显示在最左边）
 UITableViewCellStyleSubtitle    // 左上方显示textLabel，左下方显示detailTextLabel（默认灰色）,imageView可选（显示在最左边）
 };
 
 */
#import "TableDefOneVC.h"

@interface TableDefOneVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) NSMutableArray                *dataSource;
@property (nonatomic, assign) BOOL                          isSetCell;


@end

@implementation TableDefOneVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"无分区";
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    
}

- (void)initMyData
{
    NSMutableDictionary *model_1 = [NSMutableDictionary new];
    [model_1 setObject:@"appIcon120"        forKey:@"img"];
    [model_1 setObject:@"樱木花道"             forKey:@"title"];
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
    
    _dataSource = arrM;
    
}

#pragma mark UITableViewDataSource

//在每个分区里返回多少行【当没有设置分区样式的时候 默认只有一个分区】
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
    
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
    NSDictionary *dic = [_dataSource objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.textLabel.text  = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
    
    if (_isSetCell) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor blueColor];
        [Tools setCornerRadiusWithView:cell.imageView andAngle:30];
        //UITableViewCellAccessoryNone 默认样式  啥都没有
        //UITableViewCellAccessoryCheckmark 钩钩
        //UITableViewCellAccessoryDisclosureIndicator 箭头
        //UITableViewCellAccessoryDetailButton 信息符号的 圆形按钮
        //UITableViewCellAccessoryDisclosureIndicator 箭头
        //UITableViewCellAccessoryDetailDisclosureButton 圆形按钮 + 箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置箭头
    }
    
    return cell;
    
}

#pragma mark 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

@end
