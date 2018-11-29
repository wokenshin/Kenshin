//
//  BaseVC.m
//  GYBase
//
//  Created by doit on 16/5/10.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;//禁止控制器 自动改动ui y坐标[当控件是滚动视图或 表时[表也是滚动视图]]
    
    [self.view setBackgroundColor:RGB2Color(242, 242, 242)];//灰白色
    
    self.hidesBottomBarWhenPushed = YES;//当控制器push出来时，隐藏底部的TabBarButton
    
    //下面的代码可以让控制器里UI 下移导航条个高度
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 7.0 )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        /*UIRectEdgeAll的时候会让tableView从导航栏下移44px，设置为UIRectEdgeNone的时候，刚刚在导航栏下面*/
        
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
    }
    
    //添加手势   点击空白关闭软键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(closeKeyBoardWhenTouchBackView)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    //设置返回按钮文字内容
    
}

#pragma mark 关闭软键盘
//触摸空白view时 关闭软键盘
- (void)closeKeyBoardWhenTouchBackView
{
    //本方法 应由子类覆盖 让当前控制器累的全部text 失去第一响应即可达到目的
    //eg:[self.text resignFirstResponder];
    
}

#pragma mark 返回按钮是否可见
//设置导航栏返回按钮是否可见
- (void)backNavigationBarButtonHidden:(BOOL)hidden
{
    self.navigationItem.hidesBackButton = hidden;
    
}

- (void)showJuHua:(NSString *)content
{
    [self hidenJuHua];
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeIndeterminate;
    hub.label.text = content;
    
}

- (void)hidenJuHua
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
































@end
