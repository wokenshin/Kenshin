//
//  FXW_MengBan.h
//  GYBase
//
//  Created by kenshin on 16/9/10.
//  Copyright © 2016年 kenshin. All rights reserved.
//

/*
    这是一个蒙版View
    Mask 就是蒙版的意思
 
    本来是参考原来 博文智控 项目中 使用的一个三方类来实现的 ：FDAlertView
    这里的蒙版实际上并不是全屏的，它没有覆盖掉状态栏的位置
 
 
 */
#import <UIKit/UIKit.h>

@interface FXW_MaskView : UIView

/**
 *我们顶底的View 就可以赋值给 contentView
 */
@property (strong, nonatomic) UIView *contentView;


/**
 *显示
 */
- (void)show;

/**
 *删除自身
 */
- (void)removeSelf;



@end
