//
//  ContactVC.m
//  GYBase
//
//  Created by doit on 16/5/31.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    默认样式
 
    值得指出的是生成单元格的方法并不是一次全部调用，而是只会生产当前显示在界面上的单元格，当用户滚动操作时再显示其他单元格。
 
    注意 cell重用
    代码中如果有些UITableViewCell的UISwitch设置为on当其他控件重用时状态也是on，解决这个问题可以在模型中设置对应的属性记录其状态，
    在生成cell时设置当前状态 本demo就不做修复了[这个bug 在 遵移红城先锋app 中 记录某行是否被点击过 的需求中 有得到解决]
 
 */

#import "ContactVC.h"
#import "Tools.h"
#import "KContact.h"
#import "KContactGroup.h"

#define kContactToolbarHeight 44

@interface ContactVC ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *contacts;//模型数据源
@property (nonatomic, strong) NSIndexPath       *selectedIndexPath;//当前选中的组和行
@property (nonatomic, strong) UIToolbar         *toolbar;
@property (nonatomic, assign) BOOL              isInsert;//记录是点击了插入还是删除按钮

@end

@implementation ContactVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initContactUI];
    [self setEditingStatus];
    
}

- (void)setEditingStatus
{
    //直接通过下面的方法设置编辑状态没有动画
    //_tableView.editing=!_tableView.isEditing;
    
    [_tableView setEditing:!_tableView.isEditing animated:true];
    
}

//初始化数据
- (void)initData
{
    _contacts = [[NSMutableArray alloc]init];
    
    //初始化联系人数据
    //group1
    KContact *contact1 = [KContact initWithFirstName:@"陈" andLastName:@"思倩" andPhoneNumber:@"18500131234"];
    KContact *contact2 = [KContact initWithFirstName:@"陈" andLastName:@"艳红" andPhoneNumber:@"18500131237"];
    
    //group2
    KContact *contact3 = [KContact initWithFirstName:@"李" andLastName:@"旭"   andPhoneNumber:@"18500131238"];
    KContact *contact4 = [KContact initWithFirstName:@"李" andLastName:@"桃"   andPhoneNumber:@"18500131239"];
    KContact *contact5 = [KContact initWithFirstName:@"李" andLastName:@"意俊" andPhoneNumber:@"18500131240"];
    
    //group3
    KContact *contact6 = [KContact initWithFirstName:@"孙" andLastName:@"悟空" andPhoneNumber:@"18500131235"];
    KContact *contact7 = [KContact initWithFirstName:@"孙" andLastName:@"悟饭" andPhoneNumber:@"18500131236"];
    
    //group4
    KContact *contact8  = [KContact initWithFirstName:@"王" andLastName:@"能红" andPhoneNumber:@"18500131241"];
    KContact *contact9  = [KContact initWithFirstName:@"王" andLastName:@"静"   andPhoneNumber:@"18500131242"];
    KContact *contact10 = [KContact initWithFirstName:@"王" andLastName:@"克强" andPhoneNumber:@"18500131243"];
    KContact *contact11 = [KContact initWithFirstName:@"汪" andLastName:@"静雅" andPhoneNumber:@"18500131244"];
    KContact *contact12 = [KContact initWithFirstName:@"汪" andLastName:@"可可" andPhoneNumber:@"18500131245"];
    
    //group5
    KContact *contact13 = [KContact initWithFirstName:@"张" andLastName:@"旭"   andPhoneNumber:@"18500131246"];
    KContact *contact14 = [KContact initWithFirstName:@"张" andLastName:@"龙"   andPhoneNumber:@"18500131247"];
    KContact *contact15 = [KContact initWithFirstName:@"张" andLastName:@"雨童" andPhoneNumber:@"18500131248"];
    
    //将联系人添加到分组中
    KContactGroup *group1 = [KContactGroup initWithName:@"C"
                                              andDetail:@"With names beginning with C"
                                            andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    
    KContactGroup *group2 = [KContactGroup initWithName:@"L"
                                              andDetail:@"With names beginning with L"
                                            andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    
    KContactGroup *group3 = [KContactGroup initWithName:@"S"
                                              andDetail:@"With names beginning with S"
                                            andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    
    KContactGroup *group4 = [KContactGroup initWithName:@"W"
                                              andDetail:@"With names beginning with W"
                                            andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    
    KContactGroup *group5 = [KContactGroup initWithName:@"Z"
                                              andDetail:@"With names beginning with Z"
                                            andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    
    
    [_contacts addObject:group1];
    [_contacts addObject:group2];
    [_contacts addObject:group3];
    [_contacts addObject:group4];
    [_contacts addObject:group5];
    
}

- (void)initContactUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"联系人";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建一个分组样式的UITableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, screenWidth, screenHeight-108) style:UITableViewStyleGrouped];
//     _tableView.contentInset=UIEdgeInsetsMake(kContactToolbarHeight, 0, 0, 0);//table内容下移kContactToolbarHeight
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    
    [self.view addSubview:_tableView];
    
    //添加工具栏
    [self addToolbar];
}

#pragma mark 添加工具栏
-(void)addToolbar
{
    CGRect frame = self.view.frame;
    _toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 64, frame.size.width, kContactToolbarHeight)];
    
    [self.view addSubview:_toolbar];
    
    UIBarButtonItem *removeButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                 target:self action:@selector(remove)];
    
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil action:nil];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                            target:self action:@selector(add)];
    
    NSArray *buttonArray = [NSArray arrayWithObjects:removeButton, flexibleButton, addButton, nil];
    _toolbar.items = buttonArray;
    
}

#pragma mark 删除
-(void)remove
{
    //直接通过下面的方法设置编辑状态没有动画
    //_tableView.editing=!_tableView.isEditing;
    _isInsert = false;
    [_tableView setEditing:!_tableView.isEditing animated:true];
    
}

#pragma mark 添加
-(void)add
{
    _isInsert = true;
    [_tableView setEditing:!_tableView.isEditing animated:true];
    
}

#pragma mark 编辑操作（删除或添加）
//实现了此方法向左滑动就会显示删除（或添加）图标
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    KContactGroup *group =_contacts[indexPath.section];
    KContact *contact=group.contacts[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)//删除
    {
        [group.contacts removeObject:contact];
        //考虑到性能这里不建议使用reloadData
        //[tableView reloadData];
        //使用下面的方法既可以局部刷新又有动画效果
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        //如果当前组中没有数据则移除组刷新整个表格
        if (group.contacts.count == 0)
        {
            [_contacts removeObject:group];
            [tableView reloadData];
        }
        
    }
    else if(editingStyle==UITableViewCellEditingStyleInsert)//添加
    {
        KContact *newContact=[[KContact alloc]init];
        newContact.firstName=@"ken";
        newContact.lastName=@"shin";
        newContact.phoneNumber=@"18353125152";
        [group.contacts insertObject:newContact atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];//注意这里没有使用reladData刷新
    
    }
    
}

#pragma mark 排序
//只要实现这个方法在编辑状态右侧就有排序图标
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    KContactGroup *sourceGroup = _contacts[sourceIndexPath.section];
    KContact *sourceContact = sourceGroup.contacts[sourceIndexPath.row];
    KContactGroup *destinationGroup = _contacts[destinationIndexPath.section];
    
    [sourceGroup.contacts removeObject:sourceContact];
    [destinationGroup.contacts insertObject:sourceContact atIndex:destinationIndexPath.row];
    if(sourceGroup.contacts.count == 0)
    {
        [_contacts removeObject:sourceGroup];
        [tableView reloadData];
        
    }
    
}

#pragma mark 取得当前操作状态，根据不同的状态左侧出现不同的操作按钮
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isInsert)
    {
        return UITableViewCellEditingStyleInsert;
        
    }
    return UITableViewCellEditingStyleDelete;

}

#pragma mark - UITableViewDataSource
#pragma mark 返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"计算分组数");
    return _contacts.count;
    
}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"计算每组(组%li)行数",(long)section);
    KContactGroup *group = _contacts[section];
    return group.contacts.count;
    
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSIndexPath是一个结构体，记录了组和行信息
//    NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    
    KContactGroup *group = _contacts[indexPath.section];//获取分组
    KContact *contact = group.contacts[indexPath.row];//获取对应分组的联系人
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    static NSString *cellIdentifierForFirstRow=@"UITableViewCellIdentifierKeyWithSwitch";
    
    //首先根据标示去缓存池取
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierForFirstRow];
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
    }
    
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(cell == nil)
    {
        if (indexPath.row == 0)
        {
            //代码中如果有些UITableViewCell的UISwitch设置为on当其他控件重用时状态也是on，解决这个问题可以在模型中设置对应的属性记录其状态，在生成cell时设置当前状态
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifierForFirstRow];
            UISwitch *sw = [[UISwitch alloc]init];
            [sw addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            
            cell.accessoryView = sw;
            
        }
        else
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDetailButton;
            
        }
    }
    
    if(indexPath.row == 0)//设置标记
    {
        ((UISwitch *)cell.accessoryView).tag = indexPath.section;
    }
    
    //赋值
    cell.textLabel.text = [contact getName];
    cell.detailTextLabel.text = contact.phoneNumber;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];//设置cell右边的指示器
    NSLog(@"%@", cell);
    return cell;
    
    /*
     typedef NS_ENUM(NSInteger, UITableViewCellAccessoryType) {
     UITableViewCellAccessoryNone,                   // 不显示任何图标
     UITableViewCellAccessoryDisclosureIndicator,    // 跳转指示图标
     UITableViewCellAccessoryDetailDisclosureButton, // 内容详情图标和跳转指示图标
     UITableViewCellAccessoryCheckmark,              // 勾选图标
     UITableViewCellAccessoryDetailButton NS_ENUM_AVAILABLE_IOS(7_0) // 内容详情图标
     };
     */
}

//开关响应
- (void)switchValueChange:(UISwitch *)sw
{
    NSLog(@"第%li个分区的开关被点击 状态为%i", sw.tag, sw.on);
    
}

#pragma mark 返回每组头标题名称
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    NSLog(@"生成组（组%li）名称",(long)section);
    KContactGroup *group = _contacts[section];
    return group.name;
    
}

#pragma mark 返回每组尾部说明
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
//    NSLog(@"生成尾部（组%li）详情",(long)section);
    KContactGroup *group=_contacts[section];
    return group.detail;
    
}

/*
 字母检索, 构建一个分组标题的数组即可实现。数组元素的内容和组标题内容未必完全一致，
 UITableView是按照数组元素的索引和每组数据索引顺序来定位的而不是按内容查找。eg: indexs = @[@"1", @"2", @"3", @"4", @"5"];
 */
#pragma mark 返回每组标题索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    NSLog(@"生成组索引");
    NSMutableArray *indexs = [[NSMutableArray alloc]init];
    for(KContactGroup *group in _contacts)
    {
        [indexs addObject:group.name];
    }
//    indexs = @[@"1", @"2", @"3", @"4", @"5"];
    return indexs;
    
}


#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 50;
    }
    return 40;
    
}

#pragma mark 设置每行高度（每行高度可以不一样）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

#pragma mark 设置尾部说明内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
    
}

#pragma mark - UITableViewDelegate

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //记录当前选中的是下一行
    _selectedIndexPath = indexPath;
    KContactGroup *group = _contacts[indexPath.section];
    KContact *contact = group.contacts[indexPath.row];
    
    //创建弹出窗口
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Contact Info"
                                                   message:[contact getName] delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput; //设置窗口内容样式
    UITextField *textField = [alert textFieldAtIndex:0]; //取得文本框
    textField.text = contact.phoneNumber; //设置文本框内容
    [alert show]; //显示窗口
    
}

#pragma mark 窗口的代理方法，用户保存数据
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //当点击了第二个按钮（OK）
    if (buttonIndex == 1)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        //修改模型数据
        KContactGroup *group = _contacts[_selectedIndexPath.section];
        KContact *contact = group.contacts[_selectedIndexPath.row];
        contact.phoneNumber = textField.text;
        
        //刷新表格
//        [_tableView reloadData];//其实也可以局部刷新的，这里是全部刷新
        //刷新表格
        NSArray *indexPaths = @[_selectedIndexPath];//需要局部刷新的单元格的组、行
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];//后面的参数代表更新时的动画
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _tableView = nil;
    _contacts  = nil;
    _selectedIndexPath = nil;
    
}
@end
