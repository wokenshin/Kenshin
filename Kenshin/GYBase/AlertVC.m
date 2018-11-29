//
//  AlertVC.m
//  GYBase
//
//  Created by doit on 16/4/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "AlertVC.h"
#import "Tools.h"
#import "BlockButton.h"
#import "AlertVC2.h"

@interface AlertVC ()<UIActionSheetDelegate>//<UIAlertViewDelegate> 不搞代理 UIAlertView的函数 也触发 why?
{
    //不推荐使用
    UIAlertView       *alertNormal;
    UIActionSheet     *sheet;
    
    
}

//ios8之后 推荐使用
@property (nonatomic, strong)UIAlertController      *alertController;
@property (nonatomic, strong)UIAlertController      *alertController2;

@end

@implementation AlertVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"各种弹出框！！！";
    [self initAlertVCUI];
    
    /*
     原生的弹出框 [貌似不推荐使用了]
     
     ActionSheet [IOS8.3 之后 不推荐使用]
     
     UIAlertController //IOS8.3后 推荐使用
     
     其他优秀的三方
     
     */
    
}

- (void)initAlertVCUI
{
    
    
    WS(ws);
    
    //UIAlertView 不推荐使用了
    BlockButton *alertbtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 100, height_normal)];
    [alertbtn setTitle:@"UIAlertView" forState:UIControlStateNormal];
    alertbtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:alertbtn];
    
    alertbtn.block = ^(BlockButton *btn){
        [ws normalAlert];
    };
    
    
    //UIActionSheet 不推荐使用了 [UIAlertController 可以代替UIActionSheet 而且更好用]
    BlockButton *sheetBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*2 + 100, 64 + margin_10, 100, height_normal)];
    [sheetBtn setTitle:@"ActionSheet" forState:UIControlStateNormal];
    sheetBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sheetBtn];
    
    sheetBtn.block = ^(BlockButton *btn){
        [ws actionSheet];
    };

    
    
    //之前在iphone4上 alertController 初始化后 返回的是nil 然后就崩溃了，现在在模拟器上测试没有问题。
    //有点：相比UIAlertView 不需要指定代理,无需初始化过程中指定按钮.要注意样式是对话框样式还是上拉菜单样式.
    self.alertController = [UIAlertController alertControllerWithTitle:@"标题"
                                                          message:@"这个是UIAlertController的默认样式"
                                                   preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             [Tools toast:@"取消" andCuView:ws.view];
    }];
    
    UIAlertAction *okAction    = [UIAlertAction actionWithTitle:@"好的"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action){
                                                            [Tools toast:@"好的" andCuView:ws.view];
    }];
    
    //按钮的顺序由UIAlertAction 的style来决定的
    [self.alertController addAction:okAction];
    [self.alertController addAction:cancelAction];

    BlockButton *alertCtrl = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*3 + 200, 64 + margin_10, 100, height_normal)];
    [alertCtrl setTitle:@"alertCtrl" forState:UIControlStateNormal];
    alertCtrl.backgroundColor = [UIColor blackColor];
    [self.view addSubview:alertCtrl];
    
    alertCtrl.block = ^(BlockButton *btn){
        [ws presentViewController:ws.alertController animated:YES completion:nil];
    };
    
    
    
    
    
    
    
    
    
    self.alertController2 = [UIAlertController alertControllerWithTitle:@"标题"
                                                           message:@"这个是UIAlertController的默认样式"
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    //警告样式
    UIAlertAction *resetAction   = [UIAlertAction actionWithTitle:@"重置"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:nil];
    
    UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    
    [self.alertController2 addAction:resetAction];
    [self.alertController2 addAction:cancelAction2];
    
    BlockButton *alertCtrl2 = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10*2 + height_normal, 100, height_normal)];
    [alertCtrl2 setTitle:@"警告!" forState:UIControlStateNormal];
    alertCtrl2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:alertCtrl2];
    
    alertCtrl2.block = ^(BlockButton *btn){
        [ws presentViewController:ws.alertController2 animated:YES completion:nil];
//        可以看出，我们新增的那个“重置”按钮变成了红色。根据苹果官方的定义，
//        “警示”样式的按钮是用在可能会改变或删除数据的操作上。因此用了红色的醒目标识来警示用户。
        

    };
    
    BlockButton *btnNext = [[BlockButton alloc] initWithFrame:CGRectMake(200, 200, 100, height_normal)];
    [btnNext setTitle:@"NEXT" forState:UIControlStateNormal];
    btnNext.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btnNext];
    
    btnNext.block = ^(BlockButton *btn){
        AlertVC2 *vc = [[AlertVC2 alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
    };

}

- (void)normalAlert
{
    if (alertNormal == nil)
    {
        alertNormal = [[UIAlertView alloc]initWithTitle:@"提示"
                                                message:@"点我搞毛！！！"
                                               delegate:self
                                      cancelButtonTitle:@"否"
                                      otherButtonTitles:@"是", nil];
    }
    
    [alertNormal show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [Tools toast:@"否你妹。。。" andCuView:self.view];
            break;
            
        case 1:
            [Tools toast:@"是你妹。。。" andCuView:self.view];
            break;
            
        default:
            break;
    }
    
}

- (void)actionSheet
{
    if (sheet == nil)
    {
        sheet = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"相册", @"拍照", nil];
    }
    
    [sheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            [Tools toast:@"相册" andCuView:self.view];
            break;
            
        case 1:
            [Tools toast:@"拍照" andCuView:self.view];
            break;
            
        default:
            break;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    alertNormal           = nil;
    sheet                 = nil;
    self.alertController  = nil;
    self.alertController2 = nil;
    
}

@end
