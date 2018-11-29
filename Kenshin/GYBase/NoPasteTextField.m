//
//  NoPasteTextField.m
//  GYBase
//
//  Created by doit on 16/4/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NoPasteTextField.h"

@implementation NoPasteTextField

#pragma mark 禁止复制功能
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
    {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
    
}

@end
