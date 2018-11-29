//
//  ContentsVC3.m
//  GYBase
//
//  Created by doit on 16/5/26.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    目录设计：
    看看是用滚动视图来设置目录 还是用表格来设置目录[都用！本页面用滚动视图 下个页面用表格]
 
 */

#import "ContentsVC3.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "NoDelayScroll.h"
#import "ClearCachesVC.h"
#import "EvaluateStarsVC.h"
#import "MaoBoLiVC.h"
#import "XibLoginVC.h"
#import "NavBarCustomVC.h"
#import "GifContentVC.h"
#import "TestVCViewController.h"
#import "ContentFourVC.h"
#import "JiBuQiVC.h"
#import "CGQVC.h"
#import "ADVC.h"
#import "JSContentVC.h"
#import "NetContentVC.h"
#import "SaveArrToShaHeVC.h"
#import "MasonryIng.h"
#import "DuoXuanVC.h"
#import "BLEVC.h"
#import "screenAdaptationVC.h"
#import "FuckingBlockVC.h"
#import "NSUserDefaultVC.h"
#import "SortVC.h"
#import "ArrTurnStrVC.h"

@interface ContentsVC3 ()

@property (nonatomic, strong) NoDelayScroll                  *contentScroll;//目录[自定义的UIScrollView 解决按钮高亮响应延时]
@property (nonatomic, assign) CGFloat                        btnWidth;
@property (nonatomic, assign) CGFloat                        xBtnCenter;
@property (nonatomic, assign) CGFloat                        xBtnRight;

@end

@implementation ContentsVC3

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initContentsVC3UI];
    [self initBtnSizeAndLocation];
    
    [self clearCaches];
    [self starEvaluate];
    [self label];
    [self maoBoLi];//毛玻璃
    [self mc];//母亲电商接口测试
    [self baseVC];
    [self tableLeftMoveMenu];//table左滑菜单
    [self xibDemo];
    [self customNav];
    [self nextPage];
    [self uiimageView];
    [self ad];
    [self js];
    [self net];
    [self MasonryIng];
    [self duoxuan];
    [self BLE];
    [self FuckingBlockVC];
    [self NSUserDefaultVC];
    [self SortVC];
    [self ArrTurnStrVC];
    
}

- (void)ArrTurnStrVC
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnCenter, margin_10*7 + height_normal*6, _btnWidth, height_normal)];
    testBtn1.titleLabel.font = FontK(14);
    [self setButtonKStyle:testBtn1 andWithTitle:@"数组-字符串"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        ArrTurnStrVC *vc = [[ArrTurnStrVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)SortVC
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(margin_10, margin_10*7 + height_normal*6, _btnWidth, height_normal)];
    testBtn1.titleLabel.font = FontK(14);
    [self setButtonKStyle:testBtn1 andWithTitle:@"排序"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        SortVC *vc = [[SortVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)NSUserDefaultVC
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnRight, margin_10*6 + height_normal*5, _btnWidth, height_normal)];
    testBtn1.titleLabel.font = FontK(14);
    [self setButtonKStyle:testBtn1 andWithTitle:@"NSUserDefault"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        NSUserDefaultVC *vc = [[NSUserDefaultVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)FuckingBlockVC
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnCenter, margin_10*6 + height_normal*5, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"Block"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        FuckingBlockVC *vc = [[FuckingBlockVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };

    
}

//需要在info.plist中添加蓝牙权限 不然IOS10会崩溃
- (void)BLE
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(margin_10, margin_10*6 + height_normal*5, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"蓝牙4.0"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        BLEVC *vc = [[BLEVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
}

- (void)duoxuan
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnRight, margin_10*5 + height_normal*4, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"表-多选"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        DuoXuanVC *vc = [[DuoXuanVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)MasonryIng
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnCenter, margin_10*5 + height_normal*4, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"MasonryIng"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        MasonryIng *vc = [[MasonryIng alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

//网络编程
- (void)net
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(margin_10, margin_10*5 + height_normal*4, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"网络编程"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        NetContentVC *vc = [[NetContentVC alloc] init];;
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
}

- (void)js
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnRight, margin_10*4 + height_normal*3, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"JS交互"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        JSContentVC *vc = [[JSContentVC alloc] init];;
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)ad
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnCenter, margin_10*4 + height_normal*3, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"弹框广告"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        ADVC *vc = [ADVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
}

- (void)uiimageView
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(margin_10, margin_10*4 + height_normal*3, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"UIImagevIew"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        TestVCViewController *vc = [TestVCViewController new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
}

- (void)nextPage
{

    CGFloat y = 1334 - height_normal - 10;
    
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnRight, y, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"下一页"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        ContentFourVC *vc = [ContentFourVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
}

- (void)customNav
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnRight, margin_10*3 + height_normal*2, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"导航条"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        NavBarCustomVC *vc = [NavBarCustomVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
        
    };
}

- (void)xibDemo
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnCenter, margin_10*3 + height_normal*2, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"Xib的运用"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        XibLoginVC *vc = [XibLoginVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    
}

- (void)tableLeftMoveMenu
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(margin_10, margin_10*3 + height_normal*2, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"计步器"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        JiBuQiVC *vc = [JiBuQiVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
        
    };
    
}

- (void)baseVC
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnRight, margin_10*2 + height_normal, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"传感器"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        CGQVC *vc = [CGQVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
        
    };
    
}

//母亲电商接口测试【已经移植】
- (void)mc
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(_xBtnCenter, margin_10*2 + height_normal, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"Gif"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        GifContentVC *vc = [GifContentVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
}

- (void)maoBoLi
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc]
                           initWithFrame:CGRectMake(margin_10, margin_10*2 + height_normal, _btnWidth, height_normal)];
    
    [self setButtonKStyle:testBtn1 andWithTitle:@"毛玻璃效果"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        MaoBoLiVC *vc = [MaoBoLiVC new];
        [ws.navigationController pushViewController:vc animated:YES];

        
    };
    
}


#pragma mark 富文本
- (void)label
{
    [Tools toast:@"毛都没有" andCuView:self.view];
    
}

#pragma mark 四舍五入
- (void)starEvaluate
{
    WS(ws);
    UIButtonK *testBtn1 = [[UIButtonK alloc] initWithFrame:CGRectMake(_xBtnCenter, margin_10, _btnWidth, height_normal)];
    [self setButtonKStyle:testBtn1 andWithTitle:@"星星评分"];
    [self.contentScroll addSubview:testBtn1];
    testBtn1.clickButtonBlock = ^(UIButtonK *b){
        EvaluateStarsVC *vc = [EvaluateStarsVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)initContentsVC3UI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"目录3";
    
    //创建一个滚动视图用来展现页面
    CGFloat scrollHeight = 1334;//即6的高度的两倍
    _contentScroll = [[NoDelayScroll alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _contentScroll.contentSize = CGSizeMake(0, scrollHeight);//设置滚动视图滚动区域
    
    
    [self.view addSubview:_contentScroll];
    
    
}

- (void)initBtnSizeAndLocation
{
    [Tools toast:@"上下拖动" andCuView:self.view];
    
    _btnWidth   = (screenWidth - margin_10*4)/3.0;//每一个按钮的 尺寸统一， 一行三个按钮 间距为10
    _xBtnCenter = margin_10*2 + _btnWidth;
    _xBtnRight  = margin_10*3 + _btnWidth*2;
    
}

- (void)clearCaches
{
    WS(ws);
    UIButtonK *clearCachesBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, margin_10, _btnWidth, height_normal)];
    [self setButtonKStyle:clearCachesBtn andWithTitle:@"清除缓存"];
    [self.contentScroll addSubview:clearCachesBtn];
    clearCachesBtn.clickButtonBlock = ^(UIButtonK *b){
        ClearCachesVC *vc = [ClearCachesVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

//设置 UIButtonK 通用样式及标题
- (void)setButtonKStyle:(UIButtonK *)btn andWithTitle:(NSString *)title
{
    if (btn == nil) {
        return;
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setYuanJiao:8];
    [btn setStyleGreen];

}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _contentScroll = nil;
    
}


@end
