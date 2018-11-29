//
//  UIButtonK.m
//  GYBase
//
//  Created by doit on 16/4/22.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "UIControlK.h"
#import "Tools.h"

@interface UIControlK()
{
    BOOL    isAlertnateCtrl;
    BOOL    alertnateFlag;
    
}
//默认背景，高亮背景
@property (nonatomic, strong) UIImageView *backNormal;
@property (nonatomic, strong) UIImageView *backHighlight;

@end

@implementation UIControlK

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //触发函数
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        
        //触发背景
        [self addTarget:self action:@selector(touchDownAction) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUpAction) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
                
    }
    return self;
    
}

- (void)clickAction
{
    //调用代码块
    if (_clickBlock)
    {
        _clickBlock(self);
    }
    
    if (isAlertnateCtrl)//如果当前空间设置为交替切换背景
    {
        //第一次点击 显示高亮，下一次点击显示普通，周期循环
        if (alertnateFlag)
        {
            alertnateFlag = NO;
            self.backHighlight.hidden = YES;
            self.backNormal.hidden    = NO;
        }
        else
        {
            alertnateFlag = YES;
            self.backHighlight.hidden = NO;
            self.backNormal.hidden    = YES;
        }
        
    }
    
}

//显示高亮图片
- (void)touchDownAction
{
    if (!isAlertnateCtrl)
    {
        if (self.backHighlight)
        {
            self.backHighlight.hidden = NO;
        }
        if (self.backNormal)
        {
            self.backNormal.hidden = YES;
        }
    }
    
    
}

//显示默认图片
- (void)touchUpAction
{
    if (!isAlertnateCtrl)
    {
        if (self.backHighlight)
        {
            self.backHighlight.hidden = YES;
        }
        if (self.backNormal)
        {
            self.backNormal.hidden = NO;
        }
    }
    
}

//默认背景
- (void)setBackgroundImgNormal:(NSString *)imgName
{
    if (self)
    {
        if (self.backNormal == nil)
        {
            self.backNormal = [UIImageView new];
        }
        
        self.backNormal.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        if ([UIImage imageNamed:imgName] == nil)
        {
            imgName = @"defaultPic";
        }
        self.backNormal.image = [UIImage imageNamed:imgName];
        [self addSubview:self.backNormal];
    }
    
}


//高亮背景
- (void)setBackgroundImgHighLight:(NSString *)imgName
{
    if (self)
    {
        if (self.backHighlight == nil)
        {
            self.backHighlight = [UIImageView new];
        }
        
        self.backHighlight.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        if ([UIImage imageNamed:imgName] == nil)
        {
            imgName = @"defaultPic";
        }
        self.backHighlight.image = [UIImage imageNamed:imgName];
        [self addSubview:self.backHighlight];
        self.backHighlight.hidden = YES;//默认不显示 所以需要隐藏起来
    }
    
}

//设置成交替更换背景的控件 例如 用在 播放按钮上[当然设置了此处，也一样要设置normal 和 heightlight 背景]
- (void)setBackgroundIsAlternate
{
    isAlertnateCtrl = YES;
}

//设置圆角
- (void)setYuanJiao:(CGFloat )num
{
    [Tools setCornerRadiusWithView:self andAngle:num];
    
}


@end
