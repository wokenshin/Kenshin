//
//  WeiBoVC.m
//  GYBase
//
//  Created by doit on 16/5/23.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    xib 界面，约束布局
    监听table滚动，动态修改导航条样式 和 头部视图(UIview)高度
 
 */

#define XMGHeadViewH 200

#define XMGHeadViewMinH 64

#define XMGTabBarH 44

#import "WeiBoVC.h"
#import "Tools.h"
#import "UIImage+Image.h"

@interface WeiBoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView            *tableView;
@property (nonatomic, strong) UILabel                       *navTitleLab;
@property (nonatomic, assign) CGFloat                       oriOffsetY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *headHeight;

@end

@implementation WeiBoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    //设置导航条样式
    [self setNavigationBarStyle];
    
    // 不需要添加额外的滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 先记录最开始偏移量
    _oriOffsetY = -(244);
    
    // 设置tableView顶部额外滚动区域`
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);

}

#pragma mark - UIScrollView Delegate
//滚动时调用 设置 contentInset调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算下tableView滚动了多少
    
    // 偏移量:tableView内容与可视范围的差值
    
    // 获取当前偏移量y值
    CGFloat curOffsetY = scrollView.contentOffset.y;
    
    // 计算偏移量的差值 == tableView滚动了多少
    // 获取当前滚动偏移量 - 最开始的偏移量(-244)
    CGFloat delta = curOffsetY - _oriOffsetY;
    
    // 计算下头部视图的高度
    CGFloat h = XMGHeadViewH - delta;
    if (h < XMGHeadViewMinH) {
        h = XMGHeadViewMinH;
    }
    
    // 修改头部视图高度,有视觉差效果
    _headHeight.constant = h;
    NSLog(@"%f", h);
    // 处理导航条业务逻辑
    
    // 计算透明度
    CGFloat alpha = delta / (XMGHeadViewH - XMGHeadViewMinH);
    
    if (alpha > 1) {
        alpha = 0.99;//因为 ＝＝1时 ios系统会自动将view的效果弄成半透明，所以 不让alpha ＝＝1
    }
    
    // 设置导航条背景图片
    // 根据当前alpha值生成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 设置导航条标题颜色
    _navTitleLab.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    NSLog(@"%f",alpha);
    
}



#pragma mark - UITableView Delegate
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
    
}

//绘制每一行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];

}

//这里设置了导航条的样式后 pop回去 导航条的样式应该改回来 在pop之前 不然pop后就不显示导航条了
- (void)setNavigationBarStyle
{
    self.navigationItem.hidesBackButton = YES;//隐藏返回按钮
    
    // 设置导航条背景为透明
    // UIBarMetricsDefault只有设置这种模式,才能设置导航条背景图片
    // 传递一个空的UIImage
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 清空导航条的阴影的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置导航条标题为透明
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Kenshin";
    
    _navTitleLab = label;
    
    // 设置文字的颜色
    label.textColor = [UIColor colorWithWhite:1 alpha:0];
    
    // 尺寸自适应:会自动计算文字大小
    [label sizeToFit];
    
    [self.navigationItem setTitleView:label];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
