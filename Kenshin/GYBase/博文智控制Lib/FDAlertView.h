//
//  FDAlertView.h
//  FDAlertViewDemo
//
//  Created by fergusding on 15/5/26.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//
/**
    蒙版容器        这个类已经被kenshin 简化过了 它来自互联网
 */
#import <UIKit/UIKit.h>



@interface FDAlertView : UIView

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

