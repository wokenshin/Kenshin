//
//  XibVC.m
//  GYBase
//
//  Created by doit on 16/4/23.
//  Copyright © 2016年 kenshin. All rights reserved.
//
/*
 以前项目里面都是纯代码开发的。
 现在的项目基本上会用到xib 但是不是绝对的，因为对于某些页面使用xib开发起来相对会比较简单。
 在这里丰富一下吧。
 将自己学习的内容放在本demo里面，并且将学习的内容发到自己的博客 或者给出 链接
 
 */
#import "XibVC.h"

@interface XibVC ()

@end

@implementation XibVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initXibUI];
    
}

- (void)initXibUI
{
   self.navigationItem.title = @"xib";
    self.imgV.image = [UIImage imageNamed:@"appIcon120"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
