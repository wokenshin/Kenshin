//
//  FuckingBlockVC.m
//  GYBase
//
//  Created by kenshin on 17/1/23.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "FuckingBlockVC.h"
#import "BlockBaseVC.h"
#import "FuckBlockVC.h"

//基础部分 参考 http://www.jianshu.com/p/17872da184fb 结合实际 简单明了
//深入部分 参考

@interface FuckingBlockVC ()

@end

@implementation FuckingBlockVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"block 学习目录";
    
}

#pragma mark block 基础篇
- (IBAction)btnBlockBase:(id)sender
{
    BlockBaseVC *vc = [[BlockBaseVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btnBlockAdvance:(id)sender
{
    FuckBlockVC *vc = [[FuckBlockVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
