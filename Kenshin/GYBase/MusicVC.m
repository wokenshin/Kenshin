//
//  FourVC.m
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "MusicVC.h"
#import "Tools.h"

@interface MusicVC ()

@end

@implementation MusicVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Music";
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Tools setNavigationBarBackgroundColor:RGB2Color(0, 234, 234) andTextColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}

@end
