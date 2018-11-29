//
//  BlockBaseVC2.m
//  GYBase
//
//  Created by kenshin on 17/1/24.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "BlockBaseVC2.h"

@interface BlockBaseVC2 ()

@end

@implementation BlockBaseVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"block回传值";
    
}


- (IBAction)btnBlockRed:(id)sender
{
    //声明一个颜色
    UIColor *color = [UIColor redColor];
    //用刚刚声明的那个Block去回调修改上一界面的背景色
    self.backgroundColor(color);
    
}

- (IBAction)btnBlockYellow:(id)sender
{
    UIColor *color = [UIColor yellowColor];
    self.backgroundColor(color);
    
}



@end
