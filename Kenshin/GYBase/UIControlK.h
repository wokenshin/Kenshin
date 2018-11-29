//
//  UIButtonK.h
//  GYBase
//
//  Created by doit on 16/4/22.
//  Copyright © 2016年 kenshin. All rights reserved.
//
/*
    UIControl 完全可以代替 UIButton 并且 UIControl 中还可以添加视图 所以它用起来会比UIButton 更方便 好用.
    
    本类为自己封装的UIControl
 
    功能描述:
    1.可以通过代码块的回调 设置触发的事件内容
    2.可以直接通过图片名称 设置背景图片 和 高亮背景图片，如果传入的名称有无 将显示默认图片。
    3.UI圆角
 */
#import <UIKit/UIKit.h>

@class UIControlK;
//定义一个代码块 类型 叫 clickControl
typedef void (^ControlBlock)(UIControlK*);


@interface UIControlK : UIControl


//定义一个代码块属性
@property (nonatomic, copy)ControlBlock clickBlock;


//设置背景
- (void)setBackgroundImgNormal:(NSString *)imgName;
- (void)setBackgroundImgHighLight:(NSString *)imgName;

//设置圆角
- (void)setYuanJiao:(CGFloat )num;

//设置成交替更换背景 即 每点击一次交替更换一次背景[单选按钮的感觉]
- (void)setBackgroundIsAlternate;
@end























