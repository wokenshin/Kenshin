//
//  BlockBaseVC2.h
//  GYBase
//
//  Created by kenshin on 17/1/24.
//  Copyright © 2017年 kenshin. All rights reserved.
//
/*
 Block结合typedef使用
 
 自己定义一个Block类型，用定义的类型去创建Block，更加简单便捷。
 这里举例一个Block回调修改上一界面的背景颜色。
 ViewController1 控制器1，ViewController2 控制器2
 控制器1跳转到控制器2，然后在控制器2触发事件回调修改控制器1的背景颜色为红色。
 

 */

#import <UIKit/UIKit.h>


@interface BlockBaseVC2 : UIViewController

/**
 *  定义了一个changeColor的Block。这个changeColor必须带一个参数，这个参数的类型必须为id类型的
 *  无返回值
 *  @param id
 */
typedef void(^changeColor)(id);


/**
 *  用上面定义的changeColor声明一个Block,声明的这个Block必须遵守声明的要求。
 */
@property (nonatomic, copy) changeColor backgroundColor;
@end
