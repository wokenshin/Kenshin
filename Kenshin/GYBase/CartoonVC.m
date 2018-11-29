//
//  ThreeVC.m
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CartoonVC.h"
#import "Tools.h"
#import "CartoonTableVC.h"
#import "UIControlK.h"
#import "WebViewVC.h"

@interface CartoonVC ()<UIScrollViewDelegate>
{
    NSArray         *menusArr;
    UIScrollView    *menuScroll;
    UIScrollView    *cartoonsScroll;
    UIView          *selectedMenuRedLine;
    NSArray         *titleLabArray;
    BOOL            isFromClickMenu;
    UIImageView     *arrow;
    BOOL            menuSwitch;
    
}
@end

@implementation CartoonVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Cartoon";
    [self initMenu];
    [self initCartoons];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Tools setNavigationBarBackgroundColor:RGB2Color(80, 100, 0) andTextColor:[UIColor whiteColor]];
    
}

- (void)initMenu
{
    menusArr = @[@"第一章",
                 @"第二章",
                 @"第三章",
                 @"第四章",
                 @"第五章",
                 @"第六章",
                 @"第七章"];
    
    //设置新闻菜单
    CGFloat widthCtrl = 44;
    CGFloat widthMenu = screenWidth;// - widthCtrl;
    CGFloat wTitleBtn = widthMenu/3;
    self.automaticallyAdjustsScrollViewInsets = NO;//这行代码非常关键 如果没有滚动视图就不正常显示了
    
    menuScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, widthMenu, widthCtrl)];
    menuScroll.bounces = NO;//禁止果冻
    [menuScroll setContentSize:CGSizeMake([menusArr count] * wTitleBtn, 0)];
    [menuScroll setShowsHorizontalScrollIndicator:NO];//隐藏水平滚滚动条
    
    NSMutableArray *titleArrM = [[NSMutableArray alloc]init];
    for (int i = 0; i < [menusArr count]; i++)
    {
        NSString *titleName = [menusArr objectAtIndex:i];
        
        UIControl *ctrl     = [[UIControl alloc]initWithFrame:CGRectMake(i * wTitleBtn, 0, wTitleBtn, 44)];
        UILabel   *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, wTitleBtn, 44)];
        titleLab.text = titleName;
        [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        titleLab.textAlignment = NSTextAlignmentCenter;
        
        if (i == 0)
        {
            titleLab.textColor = [UIColor redColor];//将第一个标题设置成红色 默认选中
        }

        [ctrl addSubview:titleLab];
        ctrl.tag = i;
        [ctrl addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleArrM addObject:titleLab];
        [menuScroll addSubview: ctrl];
        
    }
    
    //红线
    selectedMenuRedLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44 - 5, wTitleBtn-20, 3)];
    UILabel *redLineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, wTitleBtn - 20, 3)];
    redLineLab.center = CGPointMake(wTitleBtn/2, 3/2);
    redLineLab.backgroundColor = [UIColor redColor];
    redLineLab.layer.cornerRadius = 2;
    redLineLab.layer.masksToBounds = YES;
    [selectedMenuRedLine addSubview:redLineLab];
    [menuScroll addSubview:selectedMenuRedLine];
    [self.view addSubview:menuScroll];
    titleLabArray = titleArrM;
    
}

- (void)initCartoons
{
    cartoonsScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 44, screenWidth, screenHeight - 64 - 49)];
    [cartoonsScroll setContentSize:CGSizeMake(screenWidth * [menusArr count], 0)];//设置内容的滚动范围
    
    [cartoonsScroll setBounces:NO];//禁止上下果冻
    [cartoonsScroll setDelegate:self];
    [cartoonsScroll setPagingEnabled:YES];//开启滚动分页功能，如果不需要这个功能可以关闭
    [cartoonsScroll setShowsHorizontalScrollIndicator:NO];//隐藏滚动条
    
    for (int i = 0; i < [menusArr count]; i ++)//滚动视图包含多个table
    {
        WebViewVC *webVC = [WebViewVC new];
        webVC.view.frame = CGRectMake(i * screenWidth, 0, screenWidth, screenHeight - 49);//49是底部栏的高度
        [self addChildViewController:webVC];
        [cartoonsScroll addSubview:webVC.view];
        
    }
    
    [self.view addSubview:cartoonsScroll];

}

- (void)menuClick:(UIControl *)ctrl
{
    isFromClickMenu = YES;
    CGFloat leftMove = 0;//44;//滚动条的长度为 screenWidth - 44
    CGFloat widthMenuBtn = (screenWidth - leftMove)/3.0;
    CGFloat menuPage = ctrl.tag + 1 > [menusArr count] - 2?[menusArr count] - 3:ctrl.tag;
    [menuScroll setContentOffset:CGPointMake(menuPage * widthMenuBtn, 0) animated:YES];
    
    [cartoonsScroll setContentOffset:CGPointMake(ctrl.tag * screenWidth, 0) animated:YES];//滚动到当前点击的界面
    [self changCurrentMenuTitleColorWith:ctrl.tag];//设置菜单[当前点击菜单字体变红，其他字体变黑]
    
}

#pragma mark 修改菜单中字体的颜色 [index 字体变红，其他变黑]
- (void)changCurrentMenuTitleColorWith:(NSInteger)index
{
    for (int i = 0; i < [titleLabArray count]; i++)
    {
        [[titleLabArray objectAtIndex:i] setTextColor:[UIColor blackColor]];
    }
    [[titleLabArray objectAtIndex:index] setTextColor:[UIColor redColor]];
    
}


#pragma mark- 代理 滚动刚结束时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前画动对应的菜单索引
    CGFloat  indexF = (scrollView.contentOffset.x)/screenWidth;
    NSInteger index = indexF/1;
    
    //设置菜单[当前滑动到的新闻界面对应的菜单字体变红，其他字体变黑]
    [self changCurrentMenuTitleColorWith:index];
    
}

#pragma mark  滚动视图----------[代理]
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //当包含表的滚动试图滚动动画结束的时候调用
    isFromClickMenu = NO;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat widthMenuBtn = (screenWidth /*- 44*/)/3.0;
    
    CGPoint point = menuScroll.contentOffset;
    point.x = scrollView.contentOffset.x/screenWidth*widthMenuBtn;
    selectedMenuRedLine.frame = CGRectMake(point.x, 44 - 5, widthMenuBtn, 3);
    if (!isFromClickMenu)
    {
        if (point.x + screenWidth < menuScroll.contentSize.width/* + 44*/)
        {
            menuScroll.contentOffset = point;
        }
        else
        {
            //移动到最后显示三个item的位置
            point.x = screenWidth * ([menusArr count] - 3)/screenWidth*widthMenuBtn;
            menuScroll.contentOffset = point;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
    menusArr            = nil;
    menuScroll          = nil;
    cartoonsScroll      = nil;
    selectedMenuRedLine = nil;
    titleLabArray       = nil;
    arrow               = nil;
    
}

@end
