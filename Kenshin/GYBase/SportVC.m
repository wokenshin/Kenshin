//
//  SportVC.m
//  GYBase
//
//  Created by doit on 16/5/26.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    在iOS中和运动相关的有三个事件:开始运动、结束运动、取消运动。
 
    监听运动事件对于UI控件有个前提就是监听对象必须是第一响应者（对于UIViewController视图控制器和UIAPPlication没有此要求）。
    这也就意味着如果监听的是一个UI控件那么-(BOOL)canBecomeFirstResponder;方法必须返回YES。
    同时控件显示时（在-(void)viewWillAppear:(BOOL)animated;事件中）调用视图控制器的becomeFirstResponder方法。
    当视图不再显示时（在-(void)viewDidDisappear:(BOOL)animated;事件中）注销第一响应者身份。
 
    由于视图控制器默认就可以调用运动开始、运动结束事件在此不再举例。现在不妨假设我们现在在开发一个摇一摇找人的功能，这里我们就自定义一个图片展示控件，
    在这个图片控件中我们可以通过摇晃随机切换界面图片。
 */

#import "SportVC.h"
#import "Tools.h"
#import "ShakeImgView.h"

@interface SportVC ()

@property (nonatomic, strong) ShakeImgView       *imgView;

@end

@implementation SportVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSportUI];
    [Tools toast:@"摇晃手机试试" andCuView:self.view];
    
}

- (void)initSportUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"运动事件";
    
    
    
}

#pragma mark 视图显示时让控件变成第一响应者
-(void)viewDidAppear:(BOOL)animated
{
    CGFloat headSize = 120;
    _imgView = [[ShakeImgView alloc]initWithFrame:CGRectMake(0, 0, headSize, headSize)];
    _imgView.center = CGPointMake(screenWidth/2, 200);
    _imgView.userInteractionEnabled = true;
    [Tools setCornerRadiusWithView:_imgView andAngle:headSize/2];//设置圆角
    
    [self.view addSubview:_imgView];
    [_imgView becomeFirstResponder];//成为第一响应者
    
}

#pragma mark 视图不显示时注销控件第一响应者的身份
-(void)viewDidDisappear:(BOOL)animated
{
    [_imgView resignFirstResponder];

}

/*视图控制器的运动事件*/
//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"motion begin...");
//}
//
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"motion end.");
//}
- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
