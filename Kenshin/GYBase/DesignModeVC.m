//
//  DesignModeVC.m
//  GYBase
//
//  Created by kenshin on 16/8/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "DesignModeVC.h"
#import "Tools.h"
#import "SingeInstanceVC.h"
@interface DesignModeVC ()

@end

@implementation DesignModeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"设计模式";
    
}

#pragma mark 单例模式
- (IBAction)btnSingleObjModel:(id)sender
{
    SingeInstanceVC *vc = [SingeInstanceVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
