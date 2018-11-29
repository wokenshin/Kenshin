//
//  XibTwoVC.m
//  GYBase
//
//  Created by kenshin on 16/8/26.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "XibTwoVC.h"
#import "CustomXIbView.h"
#import "AutoConstraintVC.h"
#import "UIButtonK.h"

@interface XibTwoVC ()<CustomXIbViewDelegate>


@end

@implementation XibTwoVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"xibView";
    
    CustomXIbView *xibView = [[CustomXIbView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 300)];
    //设置默认值
    [xibView.segment setSelectedSegmentIndex:1];
    xibView.alphaImageSlider.value = 1.0;
    xibView.switchRight.on = NO;
    xibView.switchLeft.on = NO;
    
    xibView.delegate = self;
    [self.view addSubview:xibView];
    
    /*
     本来这个页面是有个xib绑定vc的，但是在xcode8里面显示布局完全乱了，更新了frame还是乱。。。日了🐶 我就把他删了。。。
     */
    
    //按钮 动态修改约束
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(30, 420, screenWidth - 60, 36)];
    [btn setTitle:@"动态修改约束" forState:UIControlStateNormal];
    btn.backgroundColor = colorRedHome;
    [Tools setCornerRadiusWithView:btn andAngle:18];
    [self.view addSubview:btn];
    
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        AutoConstraintVC *vc = [AutoConstraintVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
    
}

#pragma mark CustomXIbViewDelegate

//切换图片
- (void)customXIbViewChangeImg:(CustomXIbView *)itemView
{
    
    NSString *imgNameStr = [itemView.segment selectedSegmentIndex] == 0 ? @"defaultPic":@"charater_qingzi";
    itemView.img.image = [UIImage imageNamed:imgNameStr];
    
}

//设置透明度
- (void)customXIbViewSetImgAlpha:(CustomXIbView *)itemView
{
    itemView.img.alpha = itemView.alphaImageSlider.value;
    
}

//设置圆角
- (void)customXIbViewLeftSwitch:(CustomXIbView *)itemView
{
    if (itemView.switchLeft.on)
    {
        [Tools setCornerRadiusWithView:itemView.img andAngle:8];
    }
    else
    {
        [Tools setCornerRadiusWithView:itemView.img andAngle:0];
    }
    
}

//设置边框
- (void)customXIbViewRightSwitch:(CustomXIbView *)itemView
{
    if (itemView.switchRight.on)
    {
        [Tools setBorder:itemView.img andColor:[UIColor redColor] andWidth:3];
    }
    else
    {
        [Tools setBorder:itemView.img andColor:[UIColor redColor] andWidth:0];
    }
    
}


- (void)dealloc
{
    [Tools  NSLogClassDestroy:self];
    
}
@end
