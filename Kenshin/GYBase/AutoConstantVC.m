//
//  AutoConstantVC.m
//  GYBase
//
//  Created by doit on 16/5/18.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "AutoConstantVC.h"
#import "Tools.h"

@interface AutoConstantVC ()
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginLeftGreen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginRightGreen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginTopGreen;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginBottomGreen;

@end

@implementation AutoConstantVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self autoConstantCodes];
    
}

- (void)autoConstantCodes
{
    //要修改的约束
    //1，将要修改的约束拖线出来关联属性
    //2，修改约束属性的内容
    
    //每一个view最多有四个约束：上，下，左，右， 它们的参照物 是当前的父view 距离自身 四个方向的距离
    self.marginTopGreen.constant    = 64+10;
    self.marginBottomGreen.constant = 10;
    self.marginLeftGreen.constant   = 10;
    self.marginRightGreen.constant  = 10;
    
//    [UIView animateWithDuration:2.0 animations:^{
//                [self.greenView layoutIfNeeded];
//            }];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
