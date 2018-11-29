//
//  FXW_MengBan.m
//  GYBase
//
//  Created by kenshin on 16/9/10.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "FXW_MaskView.h"
#import "AppDelegate.h"


@interface FXW_MaskView ()

@property (strong, nonatomic) UIView        *backgroundView;
@property (nonatomic, strong) UIButton      *screenBtn;


@end

@implementation FXW_MaskView

- (instancetype)init
{
    return [self initClickEmptClose];
    
}

//初始化的弹出框，点击空白处可关闭
- (instancetype)initClickEmptClose
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backgroundView];
        
        _screenBtn = [[UIButton alloc]initWithFrame:self.frame];
        [_screenBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_screenBtn];
        
    }
    return self;
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    _contentView.center = self.center;
    [self addSubview:_contentView];
    
}


//核心代码
- (void)show
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0)
    {
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }
    
}

//删除自身
- (void)removeSelf
{
    _contentView.hidden = YES;
    [self removeAlertAnimation];
    [self removeFromSuperview];
    
}


//背景色透明度的渐变动画
- (void)showBackground
{
    _backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.3;
    [UIView commitAnimations];
    
}

//缩放动画[弹出视图]
-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
    
}

/*
 删除自身的动画 其实这里的动画没有什么效果
 */
- (void)removeAlertAnimation
{
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.0;
    [UIView commitAnimations];
    
}

@end

