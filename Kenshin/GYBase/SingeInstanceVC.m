//
//  SingeInstanceVC.m
//  GYBase
//
//  Created by kenshin on 16/8/30.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SingeInstanceVC.h"
#import "SingleInstancek.h"

@interface SingeInstanceVC ()

@end

@implementation SingeInstanceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"单例模式";
    
}

- (IBAction)btnCreateSingleInstance:(id)sender
{
    SingleInstancek *instantce_0 = [[SingleInstancek alloc] init];
    SingleInstancek *instantce_1 = [[SingleInstancek alloc] init];
    SingleInstancek *instantce_2 = [SingleInstancek shareSingleInstancek];
    SingleInstancek *instantce_3 = [instantce_0 copy];
    SingleInstancek *instantce_4 = [instantce_0 mutableCopy];
    
    //输出结果说明 它们都是指向同一块内存地址
    NSLog(@"instantce_0 --- %@", instantce_0);
    NSLog(@"instantce_1 --- %@", instantce_1);
    NSLog(@"instantce_2 --- %@", instantce_2);
    NSLog(@"instantce_3 --- %@", instantce_3);
    NSLog(@"instantce_4 --- %@", instantce_4);
    
}


@end
