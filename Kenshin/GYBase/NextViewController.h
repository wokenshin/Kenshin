//
//  NextViewController.h
//  BaseGY
//
//  Created by doit on 16/4/6.
//  Copyright © 2016年 kenshin. All rights reserved.

//  作用 block 传值到另一个页面

#import <UIKit/UIKit.h>

@interface NextViewController : UIViewController

@property (nonatomic, strong) UITextField *inputTF;

@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText);

@end
