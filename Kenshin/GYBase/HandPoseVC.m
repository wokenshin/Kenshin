//
//  HandPoseVC.m
//  GYBase
//
//  Created by doit on 16/4/29.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    
    学习 链接 http://www.cnblogs.com/kenshincui/p/3950646.html
    
     在iOS中事件分为三类：
     
     触摸事件：通过触摸、手势进行触发（例如手指点击、缩放）
     运动事件：通过加速器进行触发（例如手机晃动）
     远程控制事件：通过其他远程设备触发（例如耳机控制按钮）

     
 
 */

#import "HandPoseVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "GestureDemoVC.h"
#import "SportVC.h"
#import "RemoteCtrlVC.h"

@interface HandPoseVC ()

@property (nonatomic, strong) UIImageView           *moveImgView;
@end

@implementation HandPoseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initHandPoseUI];
    [Tools toast:@"图片可以滑动" andCuView:self.view];
    
}

- (void)initHandPoseUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"三类事件!!!";
    
    self.moveImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.moveImgView.center = CGPointMake(screenWidth/2, screenHeight/2);
    self.moveImgView.image = [UIImage imageNamed:@"yingmu_ok"];
    
    
    [self.view addSubview:self.moveImgView];
    
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 100, 44)];
    [btn setTitle:@"触摸事件" forState:UIControlStateNormal];
    [btn setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [btn setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    [btn setYuanJiao:8];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        GestureDemoVC *vc = [GestureDemoVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
    UIButtonK *btn2 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*2 + 100, 64 + margin_10, 100, 44)];
    [btn2 setTitle:@"运动事件" forState:UIControlStateNormal];
    [btn2 setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [btn2 setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    [btn2 setYuanJiao:8];
    [self.view addSubview:btn2];
    btn2.clickButtonBlock = ^(UIButtonK *b){
        SportVC *vc = [SportVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
    UIButtonK *btn3 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*3 + 200, 64 + margin_10, 120, 44)];
    [btn3 setTitle:@"远程控制事件" forState:UIControlStateNormal];
    [btn3 setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [btn3 setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    [btn3 setYuanJiao:8];
    [self.view addSubview:btn3];
    btn3.clickButtonBlock = ^(UIButtonK *b){
        RemoteCtrlVC *vc = [RemoteCtrlVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };

}

#pragma mark 手势代理
//开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"UIViewController start touch...");
    
}

//触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //取得一个触摸对象（对于多点触摸可能有多个对象）
    UITouch *touch = [touches anyObject];
    //NSLog(@"%@",touch);
    
    //取得当前位置
    CGPoint current = [touch locationInView:self.view];
    //取得前一个位置
    CGPoint previous = [touch previousLocationInView:self.view];
    
    //移动前的中点位置
    CGPoint center = self.moveImgView.center;
    
    //移动偏移量
    CGPoint offset = CGPointMake(current.x-previous.x, current.y-previous.y);
    
    //重新设置新位置
    self.moveImgView.center = CGPointMake(center.x+offset.x, center.y+offset.y);
    
    NSLog(@"UIViewController moving...");
    
}

//结束触摸
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"UIViewController touch end.");
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
