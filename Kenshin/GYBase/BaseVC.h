//
//  BaseVC.h
//  GYBase
//
//  Created by doit on 16/5/10.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    参考：母亲服务端
    
    功能描述：
    这是一个自定义的最基本的控制器，封装实现了很多常用的基本功能，之后创建的控制器都可以通过继承本控制器来直接调用一些常用功能
 
 */

#import <UIKit/UIKit.h>
#import "Tools.h"
#import "MBProgressHUD.h"

@interface BaseVC : UIViewController

//关闭软键盘－点击空白背景时    需覆盖本方法 调用 [self.text resignFirstResponder];
- (void)closeKeyBoardWhenTouchBackView;

//设置返回按钮是否显示(导航控制器)
- (void)backNavigationBarButtonHidden:(BOOL)hidden;

#pragma mark - 菊花[三方 MBProgressHUD]
- (void)showJuHua:(NSString *)content;
- (void)hidenJuHua;

@end
