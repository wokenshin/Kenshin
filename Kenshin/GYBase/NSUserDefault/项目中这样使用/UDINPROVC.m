//
//  UDINPROVC.m
//  GYBase
//
//  Created by kenshin on 17/2/10.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "UDINPROVC.h"
#import "Tools.h"

@interface UDINPROVC ()

@end

@implementation UDINPROVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"项目中的运用";
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
