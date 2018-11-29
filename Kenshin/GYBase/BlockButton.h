//
//  BlockButton.h
//  BaseGY
//
//  Created by doit on 16/4/6.
//  Copyright © 2016年 kenshin. All rights reserved.

//  作用 用block代替触发事件函数
//  定义两种状态的背景颜色 按下色 抬起色    纯色按钮


#import <UIKit/UIKit.h>
@class BlockButton;

//定义了一个 代码块 类型 叫 TouchButton
typedef void (^TouchButton)(BlockButton*);



@interface BlockButton : UIButton

@property (nonatomic, copy)TouchButton block;//定义了一个 代码块 属性



@end
