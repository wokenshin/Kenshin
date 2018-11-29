//
//  SearchVC.m
//  GYBase
//
//  Created by doit on 16/6/2.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    ios8之后推荐使用的搜索栏 UISearchController， 可以讲它作为控制器的一个属性来使用，需要注意的是 这个东西貌似是添加在窗口上的，
    所以在切换控制器的时候 他毅然会现实在界面上。
    要解决这个问题 可以在控制器即将消失的回调函数里面释放掉 就可以了。
 
 
     UISearchController的使用步骤：
     
     1、创建
     
     //创建UISearchController
     _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
     
     
     2、设置代理
     
     //设置代理
     _searchController.delegate = self;
     _searchController.searchResultsUpdater= self;
     
     
     3、设置属性
     
     //设置UISearchController的显示属性，以下3个属性默认为YES
     //搜索时，背景变暗色
     _searchController.dimsBackgroundDuringPresentation = NO;
     //搜索时，背景变模糊
     _searchController.obscuresBackgroundDuringPresentation = NO;
     //隐藏导航栏
     _searchController.hidesNavigationBarDuringPresentation = NO;
     
     
     4、实现代理
     
     - (void)willPresentSearchController:(UISearchController *)searchController;
     - (void)didPresentSearchController:(UISearchController *)searchController;
     - (void)willDismissSearchController:(UISearchController *)searchController;
     - (void)didDismissSearchController:(UISearchController *)searchController;
     - (void)presentSearchController:(UISearchController *)searchController;
     
     - (void)updateSearchResultsForSearchController:(UISearchController *)searchController;
 */

#import "SearchVC.h"
#import "Tools.h"

@interface SearchVC ()<UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating>


@property (nonatomic, strong)  UITableView              *tableView;
@property (nonatomic, strong)  UISearchController       *searchController;

//数据源
@property (nonatomic, strong) NSMutableArray            *dataList;
@property (nonatomic, strong) NSMutableArray            *searchList;


@end

@implementation SearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSearchUIAndData];
    
}

//在视图即将消失的时候释放资源，不然搜索栏会一值停留在洁面上[应该是添加到窗口上了，因为控制器已经释放了]
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

- (void)initSearchUIAndData
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索IOS8之后";
    
    //初始化数据源
    _dataList   = [NSMutableArray array];
    _searchList = [NSMutableArray array];
    
    self.dataList = [NSMutableArray arrayWithCapacity:100];//容量
    
    //产生100个“数字+三个随机字母”
    for (NSInteger i = 0; i < 100; i++)
    {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
        
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    //设置代理
//    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;//取消分割线
    
    //创建UISearchController
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    
    //下面注释掉的三行代码需要关注下： 如果都设置为NO 搜索栏是不会移动到导航栏的位置，当搜索栏处于编辑状态的时候 也可以直接点击返回按钮切换控制器
    //当搜索栏处于编辑状态的时候pop了 搜索栏将会显示在切换后的控制器上 this is 啊 bug
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
//    _searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
//    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    [self.view addSubview:_tableView];
    
}

//生成三个随机字母
- (NSString *)shuffledAlphabet
{
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",
                                                                         @"H",@"I",@"J",@"K",@"L",@"M",@"N",
                                                                         @"O",@"P",@"Q",@"R",@"S",@"T",@"U",
                                                                         @"V",@"W",@"X",@"Y",@"Z"]];
    
    NSString *strTest = [[NSString alloc]init];
    
    for (int i = 0; i < 3; i++)
    {
        int x = arc4random() % 25;//0~24 的随机数
        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
        
    }
    
    return strTest;
}

#pragma mark - UITableViewDataSource

//table 返回的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active)//如果正在搜索
    {
        return [self.searchList count];
        
    }
    else
    {
        return [self.dataList count];
        
    }
    
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *flag = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    
    }
    if (self.searchController.active)//如果正在搜索
    {
        [cell.textLabel setText:self.searchList[indexPath.row]];
        
    }
    else//如果没有搜索
    {
        [cell.textLabel setText:self.dataList[indexPath.row]];
        
    }
    return cell;
    
}

#pragma mark - UISearchControllerDelegate
//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
    
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
    
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
    
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
    
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
    
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil)
    {
        [self.searchList removeAllObjects];
        
    }
    //过滤数据
    self.searchList = [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _tableView        = nil;
    _searchController = nil;
    _dataList         = nil;
    _searchList       = nil;
}
@end
