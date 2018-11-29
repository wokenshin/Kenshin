//
//  NoDelayScroll.m
//  GYBase
//
//  Created by doit on 16/6/1.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NoDelayScroll.h"

@implementation NoDelayScroll

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delaysContentTouches = NO;//禁止滑动延时
        
    }
    return self;
    
}

//重载
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
    
}

@end
