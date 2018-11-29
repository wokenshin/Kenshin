//
//  LoginVC.h
//  GYBase
//
//  Created by doit on 16/4/8.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockButton.h"
#import "BaseVC.h"

@interface LoginVC : BaseVC

@property (nonatomic, strong) UIImageView       *logoView;
@property (nonatomic, strong) UIView            *loginRect;
@property (nonatomic, strong) UITextField       *userNameTxt;
@property (nonatomic, strong) UITextField       *passWordTxt;
@property (nonatomic, strong) BlockButton       *loginBtn;
@end
