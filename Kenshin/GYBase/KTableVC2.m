//
//  KTableVC2.m
//  GYBase
//
//  Created by doit on 16/6/1.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "KTableVC2.h"
#import "Tools.h"
#import "KContact.h"
#import "KContactGroup.h"
#define kSearchbarHeight 44

@interface KTableVC2 ()<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar                   *searchBar;
@property (nonatomic, strong) UISearchDisplayController     *searchDisplayController;//IOS8之后 不推荐使用UISearchController
@property (nonatomic, strong) NSMutableArray                *contacts;//联系人模型
@property (nonatomic, strong) NSMutableArray                *searchContacts;//符合条件的搜索联系人

@end

@implementation KTableVC2

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initData];
    [self addSearchBar];
    
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    if (_isSearching) {
    //        return 1;
    //    }
    //如果当前是UISearchDisplayController内部的tableView则不分组
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
        
    }
    return _contacts.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (_isSearching) {
    //        return _searchContacts.count;
    //    }
    //如果当前是UISearchDisplayController内部的tableView则使用搜索数据
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return _searchContacts.count;
    
    }
    KContactGroup *group1=_contacts[section];
    return group1.contacts.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KContact *contact=nil;
    
    //    if (_isSearching) {
    //        contact=_searchContacts[indexPath.row];
    //    }else{
    //        KContactGroup *group=_contacts[indexPath.section];
    //        contact=group.contacts[indexPath.row];
    //    }
    //如果当前是UISearchDisplayController内部的tableView则使用搜索数据
    if (tableView==self.searchDisplayController.searchResultsTableView)
    {
        contact=_searchContacts[indexPath.row];
        
    }
    else
    {
        KContactGroup *group=_contacts[indexPath.section];
        contact=group.contacts[indexPath.row];
        
    }
    
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(cell == nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
    }
    
    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text=contact.phoneNumber;
    
    return cell;
    
}

#pragma mark - 代理方法
#pragma mark 设置分组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return @"搜索结果";
    }
    KContactGroup *group = _contacts[section];
    return group.name;
}
#pragma mark 选中之前
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];//退出键盘
    return indexPath;

}


#pragma mark - 搜索框代理
//#pragma mark  取消搜索
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    //_isSearching=NO;
//    _searchBar.text=@"";
//    //[self.tableView reloadData];
//    [_searchBar resignFirstResponder];
//}
//
//#pragma mark 输入搜索关键字
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    if([_searchBar.text isEqual:@""]){
//        //_isSearching=NO;
//        //[self.tableView reloadData];
//        return;
//    }
//    [self searchDataWithKeyWord:_searchBar.text];
//}

//#pragma mark 点击虚拟键盘上的搜索时
//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//
//    [self searchDataWithKeyWord:_searchBar.text];
//
//    [_searchBar resignFirstResponder];//放弃第一响应者对象，关闭虚拟键盘
//}

#pragma mark - UISearchDisplayController代理方法
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self searchDataWithKeyWord:searchString];
    return YES;
    
}


#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark 加载数据
-(void)initData
{
    _contacts=[[NSMutableArray alloc]init];
    
    KContact *contact1 = [KContact initWithFirstName:@"K" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    KContact *contact2 = [KContact initWithFirstName:@"K" andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    KContactGroup *group1 = [KContactGroup initWithName:@"K" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    [_contacts addObject:group1];
    
    
    
    KContact *contact3 = [KContact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    KContact *contact4 = [KContact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    KContact *contact5 = [KContact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    KContactGroup *group2 = [KContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    [_contacts addObject:group2];
    
    
    KContact *contact6 = [KContact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    KContact *contact7 = [KContact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];
    
    KContactGroup *group3 = [KContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    [_contacts addObject:group3];
    
    
    KContact *contact8 = [KContact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    KContact *contact9 = [KContact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
    KContact *contact10 = [KContact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
    KContact *contact11 = [KContact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
    KContact *contact12 = [KContact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
    KContactGroup *group4 = [KContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    [_contacts addObject:group4];
    
    
    KContact *contact13 = [KContact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    KContact *contact14 = [KContact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    KContact *contact15 = [KContact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    KContactGroup *group5 = [KContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    [_contacts addObject:group5];
    
}

#pragma mark 搜索形成新数据
-(void)searchDataWithKeyWord:(NSString *)keyWord
{
    //_isSearching=YES;
    _searchContacts=[NSMutableArray array];
    [_contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        KContactGroup *group=obj;
        [group.contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            KContact *contact=obj;
            if ([contact.firstName.uppercaseString containsString:keyWord.uppercaseString]||[contact.lastName.uppercaseString containsString:keyWord.uppercaseString]||[contact.phoneNumber containsString:keyWord])
            {
                [_searchContacts addObject:contact];
            }
        }];
    }];
    
    //刷新表格
    //[self.tableView reloadData];
}

#pragma mark 添加搜索栏
-(void)addSearchBar
{
    _searchBar = [[UISearchBar alloc]init];
    [_searchBar sizeToFit];//大小自适应容器
    _searchBar.placeholder = @"Please input key word...";
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.showsCancelButton = YES;//显示取消按钮
    //添加搜索框到页眉位置
    _searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchBar;
    
    _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    [_searchDisplayController setActive:NO animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
