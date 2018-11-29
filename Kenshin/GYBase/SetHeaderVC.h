//
//  SetHeaderVC.h
//  GYBase
//
//  Created by doit on 16/5/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//  参考 原来 博文智控 

#import <UIKit/UIKit.h>

//设置好的头像 保存到数据库中
@interface SetHeaderVC : UIViewController

@property (nonatomic, strong)UIControl      *headerCtrl;
@property (nonatomic, strong)UIImageView    *headerImg;
@property (nonatomic, strong)UIImageView    *backView;

@end
