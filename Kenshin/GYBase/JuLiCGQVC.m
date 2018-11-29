//
//  JuLiCGQVC.m
//  GYBase
//
//  Created by kenshin on 16/9/8.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "JuLiCGQVC.h"
#import "Tools.h"

@interface JuLiCGQVC ()

@end

@implementation JuLiCGQVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //监听距离传感器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(ProximityStateDidChange)
                                        name:UIDeviceProximityStateDidChangeNotification object:nil];
    
}


//打开传感器【我英语不好】
- (IBAction)openFeel:(id)sender
{
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
}

//关闭传感器
- (IBAction)closeFeel:(id)sender
{
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    
}

//监听距离传感器后 触发的方法
- (void)ProximityStateDidChange
{
    NSLog(@"距离传感器的状态发生改变了");
    if ([UIDevice currentDevice].proximityState)
    {
        NSLog(@"有物品靠近！");
    }
    else
    {
        NSLog(@"有物品离开！");
    }
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    
}

@end
