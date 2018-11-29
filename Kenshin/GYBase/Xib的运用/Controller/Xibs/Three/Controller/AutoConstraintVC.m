//
//  AutoConstraintVC.m
//  GYBase
//
//  Created by kenshin on 16/8/27.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "AutoConstraintVC.h"

@interface AutoConstraintVC ()

@end

@implementation AutoConstraintVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"动态修改约束";
    
}

- (IBAction)chengeImgSize:(id)sender
{
    CGFloat size = _slider.value * 100;
    _widthImg.constant  = 40 + size;
    _heightImg.constant = 40 + size;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
