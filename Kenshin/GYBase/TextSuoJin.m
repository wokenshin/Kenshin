//
//  TextSuoJin.m
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "TextSuoJin.h"

@implementation TextSuoJin


#pragma mark 覆盖父类方法［缩进的效果］
//控制文本所在的的位置，左右缩 10[初始化 set上值的时候]
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
    
}

//控制编辑文本时所在的位置，左右缩 10[编辑的时候]
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
    
}

@end
