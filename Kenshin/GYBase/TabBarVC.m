//
//  TabBarVC.m
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "TabBarVC.h"
#import "Tools.h"
#import "SummaryVC.h"
#import "CharactersVC.h"
#import "CartoonVC.h"
#import "MusicVC.h"
#import "SettingVC.h"

@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTabBarVCUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //必须的两个属性设置[如果没有 nav就没有返回 和 title了]//这行代码放在viewDidLoad中无效
    self.navigationController.navigationBarHidden = YES;
//    self.hidesBottomBarWhenPushed = NO;
}

- (void)initTabBarVCUI
{
    //初始化4个控制器
    SummaryVC     *one   = [SummaryVC    new];
    CharactersVC  *two   = [CharactersVC new];
    CartoonVC     *three = [CartoonVC    new];
    MusicVC       *four  = [MusicVC      new];
    SettingVC     *five  = [SettingVC    new];
    
    //返回四个导航控制器
    UINavigationController *navOne = [self subNavOfTabBarVCWith:@"赤木"
                                                 viewController:one
                                                      imageName:@"item_chimu"
                                              selectedImageName:@""];
    
    UINavigationController *navTwo = [self subNavOfTabBarVCWith:@"樱木"
                                                 viewController:two
                                                      imageName:@"item_yingmu"
                                              selectedImageName:@""];
    
    UINavigationController *navThree = [self subNavOfTabBarVCWith:@"三井"
                                                   viewController:three
                                                        imageName:@"item_sanjing"
                                                selectedImageName:@""];
    
    UINavigationController *navFour = [self subNavOfTabBarVCWith:@"流川"
                                                  viewController:four
                                                       imageName:@"item_liuchuan"
                                               selectedImageName:@""];
    
    UINavigationController *navFive = [self subNavOfTabBarVCWith:@"宫城"
                                                  viewController:five
                                                       imageName:@"item_gongcheng"
                                               selectedImageName:@""];
    
    //设置TabBarVC的四个子控制器
    self.viewControllers = [NSArray arrayWithObjects:navOne, navTwo, navThree, navFour, navFive, nil];
    
}

//创建TabBarVC 的子控制器 并设置为Nav
-(UINavigationController *)subNavOfTabBarVCWith:(NSString *)title
                                 viewController:(UIViewController *)viewController
                                      imageName:(NSString *)imageName
                              selectedImageName:(NSString *)selectedImageName
{
    
    //IOS 7以上要设置图片渲染模式
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//禁止渲染
    
    viewController.hidesBottomBarWhenPushed = NO;//当进入到viewController时 是否要隐藏底部的 bar
    
    UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    //设置Tab选中时文本文字颜色
    [navViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB2Color(255,70,70),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    //设置Tab未选中时颜色
    [navViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB2Color(190,190,190),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    if(image == nil || viewController == nil)
    {
        navViewController.tabBarItem.enabled = NO;
        
    }
    
    return navViewController;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
