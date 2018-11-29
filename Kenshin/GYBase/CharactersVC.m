//
//  TwoVC.m
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CharactersVC.h"
#import "Tools.h"
#import "CharacterModel.h"
#import "CharacterCell.h"
#import "CharacterVC.h"

@interface CharactersVC ()
/**
 *  存放所有cell的Data模型数据
 */
@property (nonatomic, strong) NSArray *models;

@end

@implementation CharactersVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Characters";
    
    //添加导航栏按钮[用于添加人物]
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addCharacter)];
    NSArray *barBtns = @[shareItem];
    self.navigationItem.rightBarButtonItems = barBtns;
    
}

- (void)addCharacter
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Tools setNavigationBarBackgroundColor:RGB2Color(255, 30, 50) andTextColor:[UIColor whiteColor]];
    
}

#pragma mark 数据源
- (NSArray *)models
{
    if (_models == nil)
    {
        // 初始化
        // 1.获得plist的全路径［plist是一个数组，数组里面存放的是若干相同结构的字典］
        NSString *path = [[NSBundle mainBundle] pathForResource:@"characters.plist" ofType:nil];
        
        // 2.加载数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *modelsArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray)
        {
            // 3.1.创建模型对象
            CharacterModel *models = [CharacterModel characterModel:dict];
            
            // 3.2.添加模型对象到数组中
            [modelsArray addObject:models];
        }
        
        // 4.赋值
        _models = modelsArray;
        
    }
    return _models;
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;//这里的self.models 相当于 [self models];
    
}
#pragma mark 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    CharacterCell *cell = [CharacterCell cellWithTableView:tableView];
    
    // 2.在这个方法算好了cell的高度
    cell.modelCharacter = self.models[indexPath.row];
    
    // 3.返回cell
    return cell;
    
}

#pragma mark 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

#pragma mark cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CharacterModel *model = self.models[indexPath.row];
    
    CharacterVC *vc = [CharacterVC new];
    if (model.name != nil && ![model.name isEqualToString:@""])
    {
        vc.name = model.name;
    }
    
    [vc setHidesBottomBarWhenPushed:YES];//切换控制器后，隐藏底部的tabBarItem
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
