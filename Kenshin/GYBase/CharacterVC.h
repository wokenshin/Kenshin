//
//  CharacterVC.h
//  GYBase
//
//  Created by doit on 16/4/25.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    根据table点击的数据 显示对应的数据
 
 */

#import <UIKit/UIKit.h>

@interface CharacterVC : UIViewController

@property (nonatomic, copy)   NSString    *name;//该属性用于 从数据库中获取相应数据的参考

@property (nonatomic, strong) UIImageView *headV;
@property (nonatomic, strong) UILabel     *nameLab;
@property (nonatomic, strong) UILabel     *heightLab;
@property (nonatomic, strong) UILabel     *numLab;
@property (nonatomic, strong) UILabel     *weightLab;
@property (nonatomic, strong) UILabel     *locationLab;
@property (nonatomic, strong) UILabel     *detailLab;

@end
