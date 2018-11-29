//
//  UIButtonK.m
//  GYBase
//
//  Created by doit on 16/5/13.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "UIButtonK.h"
#import "Tools.h"

@interface UIButtonK()

@property (nonatomic, strong)UIColor        *normalColor;
@property (nonatomic, strong)UIColor        *heightLightColor;

@end

@implementation UIButtonK

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        //可以给不同的事件 设置不同的block
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(pressAction) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(upAction)    forControlEvents:UIControlEventTouchUpOutside];
        
    }
    return self;
    
}

- (void)clickAction
{
    if (_normalColor != nil)
    {
        self.backgroundColor = _normalColor;
    }
    
    //调用代码块
    if (_clickButtonBlock)
    {
        _clickButtonBlock(self);
    }
    
}

- (void)pressAction
{
    if (_heightLightColor != nil)
    {
        self.backgroundColor = _heightLightColor;
    }
    
    //调用代码块
    if (_pressButtonBlock)
    {
        _pressButtonBlock(self);
    }
    
}

- (void)upAction
{
    if (_normalColor != nil)
    {
        self.backgroundColor = _normalColor;
    }
    
}

//正常 背景色
- (void)setBackgroundNormalColor:(UIColor *)backgroundColor
{
    _normalColor = backgroundColor;
    self.backgroundColor = backgroundColor;
    
}

//高亮 背景色
- (void)setBackgroundHeightlightColor:(UIColor *)backgroundColor
{
    _heightLightColor = backgroundColor;
    
}

- (void)setYuanJiao
{
    [Tools setCornerRadiusWithView:self andAngle:self.frame.size.height/2];
    
}

- (void)setYuanJiao:(CGFloat)yuanJiao
{
    if (yuanJiao < 0)
    {
        return;
    }
    [Tools setCornerRadiusWithView:self andAngle:yuanJiao];
    
}

- (void)setStyleGreen
{
    [self setYuanJiao:8];
    [self setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [self setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    
}

- (void)setStyleGray
{
    [self setYuanJiao:8];
    [self setBackgroundNormalColor:RGB2Color(124, 124, 124)];
    [self setBackgroundHeightlightColor:RGB2Color(162, 162, 162)];

}

- (void)dealloc
{
//    [Tools NSLogClassDestroy:self];
    self.clickButtonBlock = nil;
    self.pressButtonBlock = nil;
    
}

@end
