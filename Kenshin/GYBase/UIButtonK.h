//
//  UIButtonK.h
//  GYBase
//
//  Created by doit on 16/5/13.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    纯色按钮，响应的事件通过代码块的回调实现
    可以设置按钮两种状态下的背景色 normal 和 hightLight
 
 */

#import <UIKit/UIKit.h>
@class UIButtonK;

//定义了一个 代码块 类型 叫 ClickButton
typedef void (^ClickButtonBlock)(UIButtonK *);
typedef void (^PressButtonBlock)(UIButtonK *);

@interface UIButtonK : UIButton

//定义 代码块 属性
@property (nonatomic, copy)ClickButtonBlock clickButtonBlock;
@property (nonatomic, copy)PressButtonBlock pressButtonBlock;


//设置按钮背景色
//正常
- (void)setBackgroundNormalColor:(UIColor *)backgroundColor;

//高亮
- (void)setBackgroundHeightlightColor:(UIColor *)backgroundColor;

//按钮两端半圆
- (void)setYuanJiao;
- (void)setYuanJiao:(CGFloat)yuanJiao;


//设置按钮样式 绿色背景
- (void)setStyleGreen;
- (void)setStyleGray;
//- (void)setStyleRed;
//- (void)setStyleBlue;

@end
