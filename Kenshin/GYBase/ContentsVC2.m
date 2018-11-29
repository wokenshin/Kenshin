//
//  ContentsVC2.m
//  GYBase
//
//  Created by doit on 16/4/23.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ContentsVC2.h"
#import "Tools.h"
#import "BlockButton.h"
#import "UIApplicationVC.h"
#import "SetHeaderVC.h"
#import "WebViewVC.h"
#import "MBProgressVC.h"
#import "UIButtonK.h"
#import "LifeVC.h"
#import "AudioVC.h"
#import "AutoConstantVC.h"
#import "ContactsVC.h"
#import "WeiBoVC.h"
#import "DataVC.h"
#import "NSString+Trim.h"
#import "ContentsVC3.h"
#import "TableVC.h"
#import "SearchVC.h"
#import "MultiThreadVC.h"
#import "CollectionVC.h"
#import "ScanVC.h"
#import "DesignModeVC.h"

@interface ContentsVC2 ()



@end

@implementation ContentsVC2

- (NSString *)testPro
{
    return _testPro; // 这里不能用 self.testPro  因为self.testPro 就会调用本方法 造成死循环
                     // _testPro 赋值和取值的时候并不会调用本方法
    
}

// 当使用 _testPro 的时候，下面的方法实现了就会报错
//- (void)setTestPro:(NSString *)testPro
//{
//    _testPro = testPro;
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"目录2";
    self.view.backgroundColor = [UIColor whiteColor];

    [self testProFunc];
    [self applicationBtn];  
    [self setHeaderImg];    //上传头像到本地
    [self UIWebView];
    [self MBProgressHUDBtn];//菊花 进度
    [self UIButtonKDemo]; //纯色按钮
    [self VCLifeCicyleUI];//控制器的生命周期
    [self audioUI];       //音频
    [self autoXibYueShu];//动态修改xib约束
    [self contactsUI];//联系人
    [self weiBoDetaillVC];//微博个人页面
    [self DataVC];
    [self CategoryDemo];//分类
    [self kvcAndKvo];
    [self nextPage];
    [self UITableView];
    [self UISearchController];
    [self moreThreads];
    [self UICollectionView];
    [self swift];
    [self designMode];//设计模式
    [self scanning];//扫描二维码
    
}

//扫描二维码
- (void)scanning
{
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10*2 + 170, 64 + margin_5+(margin_5+ 44)*7, 120, 44)];
    [btn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [btn setStyleGreen];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        ScanVC *vc = [ScanVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)designMode
{
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10, 64 + margin_5+(margin_5+ 44)*7, 170, 44)];
    [btn setTitle:@"设计模式" forState:UIControlStateNormal];
    [btn setStyleGreen];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        DesignModeVC *vc = [DesignModeVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)swift
{
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10*2 + 170, 64 + margin_5+(margin_5+ 44)*6, 120, 44)];
    [btn setTitle:@"Swift" forState:UIControlStateNormal];
    [btn setStyleGreen];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        [Tools toast:@"还没做" andCuView:ws.view];
        
    };
    
}


- (void)UICollectionView
{
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10, 64 + margin_5+(margin_5+ 44)*6, 170, 44)];
    [btn setTitle:@"UICollectionView" forState:UIControlStateNormal];
    [btn setStyleGreen];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        CollectionVC *vc = [CollectionVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

//多线程
- (void)moreThreads
{
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10*2 + 170, 64 + margin_5+(margin_5+ 44)*5, 120, 44)];
    [btn setTitle:@"多线程" forState:UIControlStateNormal];
    [btn setStyleGreen];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        MultiThreadVC *vc = [MultiThreadVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    
}

//ios8 之后 使用搜索的功能推荐使用这货
- (void)UISearchController
{
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10, 64 + margin_5+(margin_5+ 44)*5, 170, 44)];
    [btn setTitle:@"UISearchController" forState:UIControlStateNormal];
    [btn setStyleGreen];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        SearchVC *vc = [SearchVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)UITableView
{
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10*2 + 144, 64 + margin_5+(margin_5+ 44)*4, 120, 44)];
    [btn setTitle:@"UITableView" forState:UIControlStateNormal];
    [btn setStyleGray];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        TableVC *vc = [TableVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark - 下一页
- (void)nextPage
{
    UIButtonK *nextbtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth - 90, screenHeight - 50, 80, 44)];
    [nextbtn setBackgroundNormalColor:RGB2Color(148, 199, 11)];
    [nextbtn setBackgroundHeightlightColor:RGB2Color(79, 190, 91)];
    [nextbtn setYuanJiao:8];
    [nextbtn setTitle:@"下一页" forState:UIControlStateNormal];
    [self.view addSubview:nextbtn];
    WS(ws);
    nextbtn.clickButtonBlock = ^(UIButtonK *b){
        ContentsVC3 *vc = [ContentsVC3 new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    
}

//ObjC中的键值编码（KVC）、键值监听（KVO）特性
#pragma mark - KVC----KVO
- (void)kvcAndKvo
{
    //java的 反射
    UIButtonK *btn = [[UIButtonK alloc]
                      initWithFrame:CGRectMake(margin_10 + 44, 64 + margin_5+(margin_5+ 44)*4, 100, 44)];
    [btn setTitle:@"KVC-KVO" forState:UIControlStateNormal];
    [btn setStyleGray];
    [self.view addSubview:btn];
    WS(ws);
    btn.clickButtonBlock = ^(UIButtonK *b){
        [Tools toast:@"还没搞" andCuView:ws.view];
        
    };
    
}

#pragma mark - 分类
- (void)CategoryDemo
{
    BlockButton *categoryBtn = [[BlockButton alloc]
                            initWithFrame:CGRectMake(margin_5, 64 + margin_5+(margin_5+ 44)*4, 44, 44)];
    [categoryBtn setTitle:@"分类" forState:UIControlStateNormal];
    categoryBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:categoryBtn];
    
    WS(ws);
    categoryBtn.block = ^(BlockButton *btn){
        NSString *str = @"    kenshin     ";
        
        NSLog(@"给NSString 创建了一个分类 扩展一个方法 清空字符串两端的空格");
        NSLog(@"%@", str);
        str = [str stringByTrim];//剪切字符串 两端的空格
        NSLog(@"%@", str);
        
        [Tools toast:@"看控制台" andCuView:ws.view];
        
    };

    
}

#pragma mark - 数据持久化
- (void)DataVC
{
    BlockButton *dataBtn = [[BlockButton alloc]
                                    initWithFrame:CGRectMake(margin_5*3 + 200, 64 + margin_5+(margin_5+ 44)*3, 100, 44)];
    [dataBtn setTitle:@"数据存储" forState:UIControlStateNormal];
    dataBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:dataBtn];
    
    WS(ws);
    dataBtn.block = ^(BlockButton *btn){
        DataVC *vc = [DataVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
}

#pragma mark - 微博个人页面
- (void)weiBoDetaillVC
{
    BlockButton *weiBoDetaillBtn = [[BlockButton alloc]
                                initWithFrame:CGRectMake(margin_10 + 100, 64 + margin_5+(margin_5+ 44)*3, 100, 44)];
    [weiBoDetaillBtn setTitle:@"微博详细" forState:UIControlStateNormal];
    weiBoDetaillBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:weiBoDetaillBtn];
    
    WS(ws);
    weiBoDetaillBtn.block = ^(BlockButton *btn){
        WeiBoVC *vc = [WeiBoVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
}

#pragma mark - 通讯录
- (void)contactsUI
{
    BlockButton *contactsBtn = [[BlockButton alloc]
                                   initWithFrame:CGRectMake(margin_5, 64 + margin_5+(margin_5+ 44)*3, 100, 44)];
    [contactsBtn setTitle:@"通讯录" forState:UIControlStateNormal];
    contactsBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:contactsBtn];
    
    WS(ws);
    contactsBtn.block = ^(BlockButton *btn){
        ContactsVC *vc = [ContactsVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark - xib 动态约束
- (void)autoXibYueShu
{
    
    BlockButton *audioYueShuBtn = [[BlockButton alloc]
                                   initWithFrame:CGRectMake(margin_10 + 100, 64 + margin_5*3+44*2, 150, 44)];
    [audioYueShuBtn setTitle:@"动态xib约束" forState:UIControlStateNormal];
    audioYueShuBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:audioYueShuBtn];
    
    WS(ws);
    audioYueShuBtn.block = ^(BlockButton *btn){
        AutoConstantVC *vc = [AutoConstantVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark - 音频
- (void)audioUI
{
    BlockButton *audioBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_5, 64 + margin_5*3+44*2, 100, 44)];
    [audioBtn setTitle:@"音频" forState:UIControlStateNormal];
    audioBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:audioBtn];
    
    WS(ws);
    audioBtn.block = ^(BlockButton *btn){
        AudioVC *vc = [AudioVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark - 生命周期
- (void)VCLifeCicyleUI
{
    //自定义 升级版 自定义BlockButton
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*2 + 200, 64 + margin_10+44, 100, 44)];
    [btn setTitle:@"VC生命周期" forState:UIControlStateNormal];
    [btn setBackgroundNormalColor:RGB2Color(112, 112, 190)];
    [btn setYuanJiao:8];
    WS(ws);
    //点击
    btn.clickButtonBlock = ^(UIButtonK *b){
        LifeVC *vc = [LifeVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:btn];
    
}

#pragma mark - UIButtonK
- (void)UIButtonKDemo
{
    //自定义 升级版 自定义BlockButton
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10 + 100, 64 + margin_10+44, 100, 44)];
    [btn setTitle:@"UIButtonK" forState:UIControlStateNormal];
    [btn setBackgroundNormalColor:RGB2Color(162, 192, 190)];
    [btn setBackgroundHeightlightColor:RGB2Color(117, 134, 184)];
    [btn setYuanJiao:8];
    WS(ws);
    //点击
    btn.clickButtonBlock = ^(UIButtonK *b){
        [Tools toast:@"屌吧！" andCuView:ws.view];
    };
    
    //按下
    btn.pressButtonBlock = ^(UIButtonK *b){
        [Tools toast:@"屌不屌！" andCuView:ws.view];
    };
    [self.view addSubview:btn];
    
}

#pragma mark - 三方进度
- (void)MBProgressHUDBtn
{
    BlockButton *mbProBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_5, 64 + margin_10+44, 100, 44)];
    [mbProBtn setTitle:@"麻痹进度" forState:UIControlStateNormal];
    mbProBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:mbProBtn];
    
    WS(ws);
    mbProBtn.block = ^(BlockButton *btn){
        MBProgressVC *vc = [MBProgressVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)UIWebView
{
    BlockButton *WebViewVCBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_5*3 + 210, 64 + margin_5, 100, 44)];
    [WebViewVCBtn setTitle:@"UIWebView" forState:UIControlStateNormal];
    WebViewVCBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:WebViewVCBtn];
    
    WS(ws);
    WebViewVCBtn.block = ^(BlockButton *btn){
        WebViewVC *vc = [WebViewVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    
}

#pragma mark - 设置头像
- (void)setHeaderImg
{
    BlockButton *setHeaderBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_5*2 + 110, 64 + margin_5, 100, 44)];
    [setHeaderBtn setTitle:@"设置头像" forState:UIControlStateNormal];
    setHeaderBtn.backgroundColor = RGB2Color(30, 30, 30);
    [self.view addSubview:setHeaderBtn];
    
    WS(ws);
    setHeaderBtn.block = ^(BlockButton *btn){
        SetHeaderVC *vc = [SetHeaderVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark - UIApplication
- (void)applicationBtn
{
    BlockButton *btn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_5, 64 + margin_5, 110, 44)];
    [btn setTitle:@"UIApplication" forState:UIControlStateNormal];
    btn.backgroundColor = RGB2Color(100, 222, 222);
    [self.view addSubview:btn];
    
    WS(ws);
    btn.block = ^(BlockButton *btn){
        UIApplicationVC *vc = [UIApplicationVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)testProFunc
{
    self.testPro = @"kenshin";
    _testPro = @"toma";
    NSString *a = self.testPro;//会调用get方法
    NSString *b = _testPro;    //不会调用get方法
    
    NSLog(@"测试 self.property 和 _property  %@  %@", a, b);
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.testPro = nil;
    
}

@end
