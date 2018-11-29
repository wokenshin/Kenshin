//
//  KTableVC.m
//  GYBase
//
//  Created by doit on 16/6/1.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    可搜索
 
    在下面的搜索中除了使用一个_contacts变量去保存联系人数据还专门定义了一个_searchContact变量用于保存搜索的结果。在输入搜索关键字时我们刷新了表格，此时会调用表格的数据源方法，在这个方法中我们根据定义的搜索状态去决定显示原始数据还是搜索结果。
 
 我们发现每次搜索完后都需要手动刷新表格来显示搜索结果，而且当没有搜索关键字的时候还需要将当前的tableView重新设置为初始状态。也就是这个过程中我们要用一个tableView显示两种状态的不同数据，自然会提高程序逻辑复杂度。为了简化这个过程，我们可以使用UISearchDisplayController，UISearchDisplayController内部也有一个UITableView类型的对象searchResultsTableView，如果我们设置它的数据源代理为当前控制器，那么它完全可以像UITableView一样加载数据。同时它本身也有搜索监听的方法，我们不必在监听UISearchBar输入内容，直接使用它的方法即可自动刷新其内部表格。为了和前面的方法对比在下面的代码中没有直接删除原来的方式而是注释了对应代码大家可以对照学习：
 
    本demo的优化代码写在KTableVC2.m类中
 */

#import "KTableVC.h"
#import "Tools.h"
#import "KContact.h"
#import "KContactGroup.h"
#define kSearchbarHeight 44

@interface KTableVC ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar           *searchBar;
@property (nonatomic, strong) NSMutableArray        *contacts;//联系人模型
@property (nonatomic, strong) NSMutableArray        *searchContacts;//符合条件的搜索联系人
@property (nonatomic, assign) BOOL                  isSearching;

@end

@implementation KTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self addSearchBar];
    
}

#pragma mark - 数据源方法

//返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearching)//当在使用搜索功能时 只有一个分区
    {
        return 1;
        
    }
    return _contacts.count;;
    
}

//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearching)
    {
        return _searchContacts.count;
        
    }
    KContactGroup *group = _contacts[section];
    return group.contacts.count;
    
}

//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KContact *contact = nil;
    
    if (_isSearching)
    {
        contact = _searchContacts[indexPath.row];
        
    }
    else
    {
        KContactGroup *group = _contacts[indexPath.section];
        contact = group.contacts[indexPath.row];
        
    }
    
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    
    //首先根据标识去缓存池取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [contact getName];
    cell.detailTextLabel.text = contact.phoneNumber;
    
    return cell;
    
}

#pragma mark - 代理方法
#pragma mark 设置分组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    KContactGroup *group = _contacts[section];
    return group.name;
}

//cell 选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];//放弃第一响应者对象，关闭虚拟键盘
    
}

//table 滑动事件
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
    
}
#pragma mark - 搜索框代理
#pragma mark  取消搜索
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _isSearching = NO;
    _searchBar.text = @"";
    [self.tableView reloadData];
    
}

#pragma mark 输入搜索关键字
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([_searchBar.text isEqual:@""])
    {
        _isSearching=NO;
        [self.tableView reloadData];
        return;
        
    }
    [self searchDataWithKeyWord:_searchBar.text];
    
}

#pragma mark 点击虚拟键盘上的搜索时
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchDataWithKeyWord:_searchBar.text];
    
    [_searchBar resignFirstResponder];//放弃第一响应者对象，关闭虚拟键盘
    
}

#pragma mark 加载数据
-(void)initData
{
    _contacts=[[NSMutableArray alloc]init];
    
    KContact *contact1=[KContact initWithFirstName:@"K"  andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    KContact *contact2=[KContact initWithFirstName:@"K"  andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    KContactGroup *group1=[KContactGroup initWithName:@"K" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    [_contacts addObject:group1];
    
    
    
    KContact *contact3=[KContact initWithFirstName:@"Lee"  andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    KContact *contact4=[KContact initWithFirstName:@"Lee"  andLastName:@"Jack"  andPhoneNumber:@"18500131239"];
    KContact *contact5=[KContact initWithFirstName:@"Lee"  andLastName:@"Rose"  andPhoneNumber:@"18500131240"];
    KContactGroup *group2=[KContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    [_contacts addObject:group2];
    
    
    
    KContact *contact6=[KContact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    KContact *contact7=[KContact initWithFirstName:@"Sun" andLastName:@"Rosa"  andPhoneNumber:@"18500131236"];
    
    KContactGroup *group3=[KContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    [_contacts addObject:group3];
    
    
    KContact *contact8=[KContact initWithFirstName:@"Wang"  andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    KContact *contact9=[KContact initWithFirstName:@"Wang"  andLastName:@"Lucy"     andPhoneNumber:@"18500131242"];
    KContact *contact10=[KContact initWithFirstName:@"Wang" andLastName:@"Lily"     andPhoneNumber:@"18500131243"];
    KContact *contact11=[KContact initWithFirstName:@"Wang" andLastName:@"Emily"    andPhoneNumber:@"18500131244"];
    KContact *contact12=[KContact initWithFirstName:@"Wang" andLastName:@"Andy"     andPhoneNumber:@"18500131245"];
    KContactGroup *group4=[KContactGroup initWithName:@"W"  andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    [_contacts addObject:group4];
    
    
    KContact *contact13=[KContact initWithFirstName:@"Zhang" andLastName:@"Joy"   andPhoneNumber:@"18500131246"];
    KContact *contact14=[KContact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    KContact *contact15=[KContact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    KContactGroup *group5=[KContactGroup initWithName:@"Z"   andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    [_contacts addObject:group5];
    
}

#pragma mark 搜索形成新数据
-(void)searchDataWithKeyWord:(NSString *)keyWord
{
    _isSearching = YES;
    _searchContacts = [NSMutableArray array];
    
    //遍历
    [_contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        KContactGroup *group = obj;
        [group.contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            KContact *contact = obj;
            if ([contact.firstName.uppercaseString containsString:keyWord.uppercaseString]||
                [contact.lastName.uppercaseString containsString:keyWord.uppercaseString]||
                [contact.phoneNumber containsString:keyWord])
            {
                [_searchContacts addObject:contact];
            }
        }];
    }];
    
    //刷新表格
    [self.tableView reloadData];
    
}

#pragma mark 添加搜索栏
-(void)addSearchBar
{
    CGRect searchBarRect = CGRectMake(0, 0, self.view.frame.size.width, kSearchbarHeight);
    _searchBar = [[UISearchBar alloc]initWithFrame:searchBarRect];
    _searchBar.placeholder=@"Please input key word...";
    //_searchBar.keyboardType=UIKeyboardTypeAlphabet;//键盘类型
    //_searchBar.autocorrectionType=UITextAutocorrectionTypeNo;//自动纠错类型
    //_searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;//哪一次shitf被自动按下
    _searchBar.showsCancelButton = YES;//显示取消按钮
    //添加搜索框到页眉位置
    _searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchBar;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
