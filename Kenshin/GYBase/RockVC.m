//
//  RockVC.m
//  GYBase
//
//  Created by kenshin on 16/9/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "RockVC.h"
#import "Tools.h"

@interface RockVC ()

@end

@implementation RockVC

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [Tools toast:@"摇你妹啊！" andCuView:self.view andHeight:300];
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //比如在摇晃时 突然来了个电话? 其实自己可以测试一下
    NSLog(@"不知道啥时候触发？");
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    NSLog(@"摇晃动作一停止就会触发");
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
