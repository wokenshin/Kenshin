//
//  ContentsVC.m
//  BaseGY
//
//  Created by doit on 16/4/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Tools.h"
#import "ContentsVC.h"
#import "ContentsVC2.h"
#import "BlockButton.h"
#import "NextViewController.h"
#import "MasonryLayoutVC.h"
#import "NSUserDefaultTools.h"
#import "LoginVC.h"
#import "HttpVC.h"
#import "JpushVC.h"
#import "TabBarVC.h"
#import "Constants.h"
#import "UIControlK.h"
#import "XibVC.h"
#import "FmdbVC.h"
#import "PlayMusicVC.h"
#import "AnimationVC.h"
#import "TextVC.h"
#import "AlertVC.h"
#import "HandPoseVC.h"
#import "OCContent.h"
#import "DelegateVC.h"
#import "PickerVC.h"
#import "RecodeVoiceVC.h"
#import "ScrollVC.h"

@interface ContentsVC ()

@end

@implementation ContentsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initContentVCUI];
    [self chufa];//oc 整型除法的计算 结果取小数点左边的有效位
    [self learn_const];
    [self learnDelegateUI];
    [self learnBlock];
    [self masonryLayout];
    [self netRequestUI];
    [self jPushUI];
    [self tabBarVC];
    [self checkNetStatusUI];
    [self myUIControl];
    [self xibUI];
    [self fmdbUI];
    [self baiduLocate];
    [self recodeSoundUI];
    [self playMusicUI];
    [self animationUI];
    [self pickerUI];
    [self scrollUI];
    [self textUI];
    [self handPoseUI];
    [self alertViewUI];
    [self ocBaseVCUI];
    
}

#pragma mark oc基础
- (void)ocBaseVCUI
{
    UIControlK *ocCtrl = [[UIControlK alloc] initWithFrame:CGRectMake(240, 450, 60, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, height_normal)];
    title.text = @"oc基础";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    ocCtrl.backgroundColor = RGB2Color(120, 70, 110);
    [ocCtrl addSubview:title];
    [self.view addSubview:ocCtrl];
    WS(ws);
    ocCtrl.clickBlock = ^(UIControlK *ctrl){
        OCContent *vc = [OCContent new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    
}

#pragma mark 弹出框
- (void)alertViewUI
{
    
    UIControlK *alertC = [[UIControlK alloc] initWithFrame:CGRectMake(170, 450, 60, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, height_normal)];
    title.text = @"弹出框";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    alertC.backgroundColor = RGB2Color(10, 70, 110);
    [alertC addSubview:title];
    [self.view addSubview:alertC];
    WS(ws);
    alertC.clickBlock = ^(UIControlK *ctrl){
        AlertVC *vc = [AlertVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark 手势 点击 长按 滑动 放大等。。。
- (void)handPoseUI
{
    UIControlK *handPose = [[UIControlK alloc] initWithFrame:CGRectMake(margin_10 + 100, 450, size_normal, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size_normal, height_normal)];
    title.text = @"事件";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    handPose.backgroundColor = RGB2Color(130, 70, 110);
    [handPose addSubview:title];
    [self.view addSubview:handPose];
    WS(ws);
    handPose.clickBlock = ^(UIControlK *ctrl){
        HandPoseVC *vc = [HandPoseVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark 文本框
- (void)textUI
{
    BlockButton *textBtn = [[BlockButton alloc] initWithFrame:CGRectMake(260, 350, size_normal, height_normal)];
    [textBtn setTitle:@"Text" forState:UIControlStateNormal];
    [textBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    textBtn.backgroundColor = RGB2Color(238, 230, 133);
    [self.view addSubview:textBtn];
    WS(ws);
    textBtn.block = ^ (BlockButton *btn){
        TextVC *vc = [TextVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
}

#pragma mark 滚动视图
- (void)scrollUI
{
    UIControlK *pickerCtrl = [[UIControlK alloc] initWithFrame:CGRectMake(margin_10*2 + 200, 400, 100, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, height_normal)];
    title.text = @"滚动视图";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    pickerCtrl.backgroundColor = RGB2Color(143, 100, 10);
    [pickerCtrl addSubview:title];
    [self.view addSubview:pickerCtrl];
    WS(ws);
    pickerCtrl.clickBlock = ^(UIControlK *ctrl){
        ScrollVC *vc = [ScrollVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark 选择器
- (void)pickerUI
{
    
    UIControlK *pickerCtrl = [[UIControlK alloc] initWithFrame:CGRectMake(margin_10 + 100, 400, 100, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, height_normal)];
    title.text = @"选择器";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    pickerCtrl.backgroundColor = RGB2Color(143, 212, 10);
    [pickerCtrl addSubview:title];
    [self.view addSubview:pickerCtrl];
    WS(ws);
    pickerCtrl.clickBlock = ^(UIControlK *ctrl){
        PickerVC *vc = [PickerVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark 动画
- (void)animationUI
{
    BlockButton *animationBtn = [[BlockButton alloc] initWithFrame:CGRectMake(100 + 50, 350, 100, height_normal)];
    [animationBtn setTitle:@"动画" forState:UIControlStateNormal];
    animationBtn.backgroundColor = RGB2Color(90, 0, 10);
    [self.view addSubview:animationBtn];
    WS(ws);
    animationBtn.block = ^ (BlockButton *btn){
        AnimationVC *vc = [AnimationVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
}

#pragma mark 音乐
- (void)playMusicUI
{
    //循环播放［写在一个工具类中］
    BlockButton *playBtn = [[BlockButton alloc] initWithFrame:CGRectMake(120, 64 + margin_10*2 + height_normal, height_normal, height_normal)];
    WS(ws);
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    playBtn.backgroundColor = RGB2Color(0, 100, 0);
    [self.view addSubview:playBtn];
    playBtn.block = ^(BlockButton *btn){
        PlayMusicVC *vc = [PlayMusicVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
}

#pragma mark 录音
- (void)recodeSoundUI
{
    WS(ws);
    BlockButton *recodeBtn = [[BlockButton alloc] initWithFrame:CGRectMake(120, 64 + margin_10, height_normal, height_normal)];
    [recodeBtn setTitle:@"录音" forState:UIControlStateNormal];
    recodeBtn.backgroundColor = RGB2Color(207, 106, 10);
    [self.view addSubview:recodeBtn];
    recodeBtn.block = ^(BlockButton *btn){
        RecodeVoiceVC *vc = [RecodeVoiceVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark 百度地图
- (void)baiduLocate
{
    UIControlK *locate = [[UIControlK alloc] initWithFrame:CGRectMake(margin_5, 400, 100, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, height_normal)];
    title.text = @"百度地图";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    locate.backgroundColor = RGB2Color(234, 212, 10);
    [locate addSubview:title];
    [self.view addSubview:locate];
    WS(ws);
    locate.clickBlock = ^(UIControlK *ctrl){
        NSLog(@"功能太老已经删除了");
    };
    
}

#pragma mark fmdb
- (void)fmdbUI
{
    UIControlK *fmdb = [[UIControlK alloc] initWithFrame:CGRectMake(100, 350, height_normal, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, height_normal, height_normal)];
    title.text = @"fmdb";
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    fmdb.backgroundColor = [UIColor brownColor];
    [fmdb addSubview:title];
    [self.view addSubview:fmdb];
    WS(ws);
    fmdb.clickBlock = ^(UIControlK *ctrl){
        //xib 控制器的初始化方法
        FmdbVC *vc = [FmdbVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };

}

#pragma mark xib
- (void)xibUI
{
    //这里用到了xib文件，ui是在xib中创建的，用到了xib中的约束
    UIControlK *intoXibVC = [[UIControlK alloc] initWithFrame:CGRectMake(margin_10 + height_normal, 350, height_normal, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, height_normal, height_normal)];
    title.text = @"xib";
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    intoXibVC.backgroundColor = [UIColor greenColor];
    [intoXibVC addSubview:title];
    [self.view addSubview:intoXibVC];
    WS(ws);
    intoXibVC.clickBlock = ^(UIControlK *ctrl){
        //xib 控制器的初始化方法
        XibVC *vc = [[XibVC alloc] initWithNibName:@"XibVC" bundle:nil];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
}

#pragma mark myUIControl
- (void)myUIControl
{
    UIControlK *ctrl = [[UIControlK alloc] initWithFrame:CGRectMake(margin_5, 350, height_normal, height_normal)];
    [ctrl setBackgroundImgNormal:@"yingmu_ok"];
    [ctrl setBackgroundImgHighLight:@"yingmu_guilian"];
    [ctrl setYuanJiao:8];
    [self.view addSubview:ctrl];
    WS(ws);
    ctrl.clickBlock = ^(UIControlK *ctrl){
        [Tools toast:@"自定义的按钮 很厉害吧！" andCuView:ws.view];
        if ([ws.navigationController.navigationBar isHidden])
        {
            [ws.navigationController setNavigationBarHidden:NO];
        }
        else
        {
            [ws.navigationController setNavigationBarHidden:YES];
        }
    };
    
}

#pragma mark 监测网络状态
- (void)checkNetStatusUI
{
    BlockButton *checkNetStatusBtn = [[BlockButton alloc] initWithFrame:CGRectMake(150 + margin_10, 300, 150, height_normal)];
    [checkNetStatusBtn setTitle:@"netStatus" forState:UIControlStateNormal];
    checkNetStatusBtn.backgroundColor = RGB2Color(123, 231, 200);
    [self.view addSubview:checkNetStatusBtn];
    WS(ws);
    checkNetStatusBtn.block = ^(BlockButton *btn)
    {
        [Tools checkNetStatus];
        [Tools toast:@"请看控制台" andCuView:ws.view];
    };

}

#pragma mark const
- (void)learn_const
{
    //可以直接查看 Constants.h文件
    //    kenshinName = @"kenshin"; //const 修饰的变量是不允许被修改的，包括修饰 指针地址时
    NSLog(@"%@", kenshinName);
    
}

#pragma mark 代理
- (void)learnDelegateUI
{
    
    UIControlK *delegateCtrl = [[UIControlK alloc] initWithFrame:CGRectMake(margin_5, 450, 100, height_normal)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, height_normal)];
    title.text = @"代理";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    delegateCtrl.backgroundColor = RGB2Color(0, 100, 10);
    [delegateCtrl addSubview:title];
    [self.view addSubview:delegateCtrl];
    WS(ws);
    delegateCtrl.clickBlock = ^(UIControlK *ctrl){
        DelegateVC *vc = [DelegateVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };

}

#pragma mark tabBar
- (void)tabBarVC
{
    BlockButton *intoTabVC = [[BlockButton alloc] initWithFrame:CGRectMake(margin_5, 300, 150, height_normal)];
    [intoTabVC setTitle:@"intoTabVC" forState:UIControlStateNormal];
    intoTabVC.backgroundColor = colorNavBar;
    [self.view addSubview:intoTabVC];

    intoTabVC.block = ^(BlockButton *btn)
    {
        TabBarVC *tabVC = [TabBarVC new];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:tabVC];
        [[UIApplication sharedApplication].delegate window].rootViewController = navController;
        
        
    };
    
}

#pragma mark 极光推送
- (void)jPushUI
{
    BlockButton *jPushBtn = [[BlockButton alloc] initWithFrame:CGRectMake(200, 64 + margin_10 * 2 + height_normal, 100, height_normal)];
    jPushBtn.backgroundColor = colorPageCu;
    [jPushBtn setTitle:@"极光推送" forState:UIControlStateNormal];
    [self.view addSubview:jPushBtn];
    WS(ws);
    jPushBtn.block = ^(BlockButton *btn)
    {
        JpushVC *vc = [JpushVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
}

#pragma mark 初始化UI
- (void)initContentVCUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"目录";
    
    //loginOut
    BlockButton *loginOutBtn = [[BlockButton alloc] initWithFrame:CGRectMake(200, 64 + margin_10, 100, height_normal)];
    loginOutBtn.backgroundColor = [UIColor blackColor];
    [loginOutBtn setTitle:@"loginOut" forState:UIControlStateNormal];
    [self.view addSubview:loginOutBtn];
#pragma mark 注销登录
    loginOutBtn.block = ^(BlockButton *btn){
        
        //注销登录
        //1.清空保存的 用户名 和 密码
        [NSUserDefaultTools clearUserInfo];
        
        //2.切换到登录vc 并将 登录vc 设置成根控制器
        LoginVC *loginVC = [LoginVC new];
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        AppDel.window.rootViewController = navVC;
    };
    
    WS(ws);
    BlockButton *nextPage = [[BlockButton alloc] initWithFrame:CGRectMake(screenWidth - 150, screenHeight - height_normal - 10, 140, height_normal)];
    [nextPage setTitle:@"nextPage" forState:UIControlStateNormal];
    [self.view addSubview:nextPage];
    nextPage.block = ^(BlockButton *btn)
    {
        ContentsVC2 *vc = [ContentsVC2 new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
}

#pragma mark 网络请求
- (void)netRequestUI
{
    BlockButton *postBtn = [[BlockButton alloc] initWithFrame:CGRectMake(160, 250, 180, height_normal)];
    postBtn.backgroundColor = colorNavBar;
    [postBtn setTitle:@"进入网络请求vc" forState:UIControlStateNormal];
    [self.view addSubview:postBtn];
    WS(ws);
    //click into HttpVC
    postBtn.block = ^(BlockButton *btn){
        HttpVC *vc = [HttpVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark 学习block
- (void)learnBlock
{
    [self blockBase];
    [self blockBtnAction];//用block代替UIButton点击事件
    [self blockSendMsgToNextVC];//页面之间传值

}

- (void)blockBase
{
    //from MJ
    void (^blockVoid)() = ^(){
        NSLog(@"void block");
        
    };
    blockVoid();
    
    
    int (^sumBlock)(int, int) = ^(int a, int b){
        return a+b;
        
    };
    int a = sumBlock(100, 200);
    NSLog(@"带有返回值的block 100 ＋ 200 ＝＝ %d", a);
    
}

#pragma mark 用block改写UIButton点击事件
- (void)blockBtnAction
{
    //  大致就是自定义一个BlockButton继承UIButton，
    //然后在里面用addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents这个方法触发block
    BlockButton *button = [[BlockButton alloc]initWithFrame:CGRectMake(margin_5, height_normal + statusHeight + margin_10, 100, height_normal)];
    [button setTitle:@"blockBtn" forState:UIControlStateNormal];
    __weak ContentsVC *weakSelf = self;//避免循环引用
    [button setBlock:^(BlockButton *button)
     {
         [Tools toast:@"按钮的触发函数 由block代替！" andCuView:weakSelf.view];
         
     }];
    [self.view addSubview:button];
    
}

#pragma mark 用block实现页面间传值
- (void)blockSendMsgToNextVC
{
    //从本控制器 切换到 NextViewController 控制器，输入文本inputTxt，点击按钮，将返回到本控制器 并给label赋值为inputTxt
    UIButton *blockBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin_5, statusHeight + height_normal * 2 + margin_10 * 2, 100, height_normal)];
    blockBtn.backgroundColor = [UIColor blackColor];
    [blockBtn setTitle:@"blockBtn" forState:UIControlStateNormal];
    [blockBtn addTarget:self action:@selector(blockBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextVCInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin_5, 200, screenWidth - 2 * margin_5, height_normal)];
    self.nextVCInfoLabel.textColor = RGB2Color(0, 100, 100);
    self.nextVCInfoLabel.backgroundColor = [UIColor lightGrayColor];
    self.nextVCInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.nextVCInfoLabel.text = @"接收NextVC的返回值";
    
    [self.view addSubview:blockBtn];
    [self.view addSubview:self.nextVCInfoLabel];
    
}

- (void)blockBtn
{
    WS(ws);
    NextViewController *nextVC = [NextViewController new];
    //下面的block 是在NextViewController 中的按钮被点击时才调用
    nextVC.NextViewControllerBlock = ^(NSString *tfText)
    {
        [ws resetLabel:tfText];
    };
    
    [ws.navigationController pushViewController:nextVC animated:YES];
    
}

- (void)resetLabel:(NSString *)textStr
{
    self.nextVCInfoLabel.text = textStr;
    NSLog(@"block 传值ing");
    
}

#pragma mark masonry约束
- (void)masonryLayout
{
    //切换到新的vc 以后的vc都要结合xib快速开发
    BlockButton *intoMasonryVC = [[BlockButton alloc] initWithFrame:CGRectMake(margin_5, 250, 100, height_normal)];
    [intoMasonryVC setTitle:@"适配vc" forState:UIControlStateNormal];
    intoMasonryVC.backgroundColor = colorPageCu;
    WS(ws);
    //下面的代码块 当touchUpInside事件触发时 被调用
    intoMasonryVC.block = ^(BlockButton *button)
    {
        NSLog(@"进入布局控制器！");
        //因为即将进入的控制器是用xib创建的，所以初始化方式如下
        MasonryLayoutVC *vc = [MasonryLayoutVC new];
        [ws.navigationController pushViewController:vc animated:YES];
    };
    
    [ws.view addSubview:intoMasonryVC];
    
    
}

//oc里面整数的除法规则 不是四舍五入，而是取小数点左边的有效位当做计算的结果
- (void)chufa
{
    int fenzi = 119;
    int fenmu = 60;
    
    NSLog(@"—————————————整型除法 除不尽的取小数点左边的有效位 并非四舍五入");
    
    NSLog(@"%d分钟 == %d小时", fenzi, fenzi/fenmu);//1小时
    NSLog(@"%d分钟 == %d小时%d分钟", fenzi, fenzi/fenmu, fenzi%fenmu);//1小时59分钟

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    //之前这个控制器在弹栈的时候并没有被释放，原因时 因为block中使用的self造成了循环引用
    self.nextVCInfoLabel = nil;
    
}
@end
