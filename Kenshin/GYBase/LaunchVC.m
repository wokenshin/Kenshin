//
//  LaunchVC.m
//  GYBase
//
//  Created by doit on 16/4/15.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "LaunchVC.h"
#import "Tools.h"


@interface LaunchVC ()

@end

@implementation LaunchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    backView.contentMode  = UIViewContentModeScaleAspectFill;
    backView.image = [UIImage imageNamed:@"qingzi"];
    [self.view addSubview:backView];
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
