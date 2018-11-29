//
//  XibLoginVC.m
//  GYBase
//
//  Created by kenshin on 16/8/17.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "XibLoginVC.h"
#import "EqualXibVC.h"
#import "Tools.h"

@interface XibLoginVC ()

@end

@implementation XibLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    _desc.text = @"xib中给UIScrollView 设置 contentSize 需要在UIScrollView中添加一个UIView,水平方向滚动UIView设置为垂直居中。竖直方向滚动UIView设置水平居中。如果竖直和水平方向都滚动 则不需要设置居中的约束。最后设置UIView的宽度 或者是高度即为UIScrolleView的contentSize 然后只需要将需要的UI 添加到这个UIView上就可以了";
    
    [Tools setCornerRadiusWithView:_btnNextVC andAngle:_btnNextVC.frame.size.height/2.0];//设置按钮圆角
}

- (IBAction)btnNextVC:(id)sender
{
    //下面正式开始进入完全由xib搭建的UI世界
    EqualXibVC *vc = [EqualXibVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools  NSLogClassDestroy:self];
    
}
@end
