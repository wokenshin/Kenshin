//
//  EqualXibVC.m
//  GYBase
//
//  Created by kenshin on 16/8/22.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "EqualXibVC.h"
#import "XibTwoVC.h"
#import "UIButtonK.h"

@interface EqualXibVC ()


@end

@implementation EqualXibVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"常用xib布局一";
    
}

- (IBAction)btnNextVC:(id)sender
{
    XibTwoVC *vc = [XibTwoVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools  NSLogClassDestroy:self];
    
}
@end
