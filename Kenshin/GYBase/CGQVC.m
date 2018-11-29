//
//  CGQVC.m
//  GYBase
//
//  Created by kenshin on 16/9/8.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CGQVC.h"
#import "Tools.h"
#import "JiaSuJiVC.h"
#import "JuLiCGQVC.h"
#import "JiaSuJiTwo.h"
#import "JiaSuJiPull.h"
#import "TuoLuoPushVC.h"
#import "TuoLuoPullVC.h"
#import "RockVC.h"
#import "StepsVC.h"
#import "StepsMoreVC.h"

@interface CGQVC ()

@end

@implementation CGQVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"只有真机才能测哦";
    
}

//距离传感器
- (IBAction)juLiCGQ:(id)sender
{
    JuLiCGQVC *vc = [JuLiCGQVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//加速器 老API
- (IBAction)jiasujiOldAPI:(id)sender
{
    JiaSuJiVC *vc = [JiaSuJiVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//加速器 实时获取
- (IBAction)jiasujiReal:(id)sender
{
    JiaSuJiTwo *vc = [JiaSuJiTwo new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//加速计 只获取一次
- (IBAction)jiaSuJiOnce:(id)sender
{
    JiaSuJiPull *vc = [JiaSuJiPull new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 陀螺仪 push方式
- (IBAction)tuoluoyi_push:(id)sender
{
    TuoLuoPushVC *vc = [TuoLuoPushVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 陀螺仪 pull方式
- (IBAction)tuoluoyi_pull:(id)sender
{
    TuoLuoPullVC *vc = [TuoLuoPullVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 摇一摇
- (IBAction)rock:(id)sender
{
    RockVC *vc = [RockVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 计步器
- (IBAction)steps:(id)sender
{   
    StepsVC *vc = [StepsVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 计步器列表数据
- (IBAction)tableData:(id)sender
{
    StepsMoreVC *vc = [StepsMoreVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark HealthKit 更牛逼
- (IBAction)HealthKitBtn:(id)sender
{
    [Tools toast:@"日后学习" andCuView:self.view];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
