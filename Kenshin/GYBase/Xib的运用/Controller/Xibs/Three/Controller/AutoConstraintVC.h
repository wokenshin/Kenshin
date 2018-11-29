//
//  AutoConstraintVC.h
//  GYBase
//
//  Created by kenshin on 16/8/27.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "BaseVC.h"

@interface AutoConstraintVC : BaseVC

@property (weak, nonatomic) IBOutlet UISlider *slider;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//头像的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightImg;


@end
