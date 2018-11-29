//
//  ADVC.m
//  GYBase
//
//  Created by kenshin on 16/9/10.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ADVC.h"
#import "FDAlertView.h"

@interface ADVC ()


@property (nonatomic, strong) FDAlertView           *alertMine;
@property (nonatomic, strong) UIImageView           *imgViewAd;
@end

@implementation ADVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"广告";
    [self initShareBtn];
    
}

//自定义导航栏按钮[右边]
- (void)initShareBtn
{
    UIImage *image = [UIImage imageNamed:@"star_shi"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//IOS 7以上要设置图片渲染模式
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(shareItemAction)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

- (void)shareItemAction
{
    //adPNG
    _imgViewAd = nil;
    _imgViewAd = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, screenWidth - 60, 350)];
    _imgViewAd.image = [UIImage imageNamed:@"adPNG"];
    [Tools setCornerRadiusWithView:_imgViewAd andAngle:8];
    //添加图片手势
    UITapGestureRecognizer *imageClickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAd)];
    _imgViewAd.userInteractionEnabled = YES;
    [_imgViewAd addGestureRecognizer:imageClickTap];
    
    //下面这个类其实蛮牛逼的 可以做各种菜单蒙版【好好研究下 然后自己写一个自己的】
    FDAlertView *alert = [[FDAlertView alloc] init];
    alert.contentView = _imgViewAd;
    _alertMine = alert;
    
    alert = nil;
    [_alertMine show];

    
}

- (void)clickAd
{
    [Tools toast:@"进入广告..." andCuView:self.view andHeight:300];
    [_alertMine removeSelf];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
