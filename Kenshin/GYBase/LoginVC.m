//
//  LoginVC.m
//  GYBase
//
//  Created by doit on 16/4/8.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "LoginVC.h"
#import "Tools.h"
#import "View+MASAdditions.h"
#import "ContentsVC.h"
#import "NSUserDefaultTools.h"
#import "Enums.h"

@interface LoginVC ()<UITextFieldDelegate>//点击return 关闭软键盘
{
    int inputLoginInfoCount;
    
}
@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    
}


//参考母亲电商
- (void)initUI
{
    
    self.navigationItem.title = @"Login";
    self.view.backgroundColor = colorGray;
    
    //采用Masonry autolayout
    CGFloat logoSize = 60;
    
    //logo
    WS(ws);//定义一个弱类型的 self的引用
    self.logoView = [UIImageView new];
    UIImage *logoImg = [UIImage imageNamed:@"yingmu"];
    [Tools setCornerRadiusWithView:self.logoView andAngle:logoSize/2];
    self.logoView.image = logoImg;
    [self.view addSubview:self.logoView];
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(20 + 44 + 20));
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(logoSize, logoSize));
        
    }];
    logoImg = nil;
    
    //rect
    self.loginRect = [UIView new];
    self.loginRect.backgroundColor = [UIColor whiteColor];
    [Tools setCornerRadiusWithView:self.loginRect andAngle:4];
    [self.view addSubview:self.loginRect];
    [self.loginRect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(20 + 44 + 30 + logoSize + 30));
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@(44 * 2 + 10));
    }];
    
    //username
    self.userNameTxt = [UITextField new];
    self.userNameTxt.placeholder = @"username";
    [self.userNameTxt setKeyboardType:UIKeyboardTypeNumberPad];//键盘只显示数字
    self.userNameTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.loginRect addSubview:self.userNameTxt];
    [self.userNameTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@margin_5);
        make.left.equalTo(@5);
        make.right.equalTo(@-5);
        make.height.equalTo(@height_normal);
    }];
    
    //separateLine
    UILabel *separateLine = [UILabel new];
    separateLine.backgroundColor = [UIColor lightGrayColor];
    [self.loginRect addSubview:separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(margin_5 + height_normal + 2));
        make.left.equalTo(@margin_5);
        make.right.equalTo(@(-margin_5));
        make.height.equalTo(@1);
    }];
    
    //password
    self.passWordTxt = [UITextField new];
    self.passWordTxt.delegate = self;//点击return 关闭软键盘
    self.passWordTxt.placeholder = @"password";
    [self.passWordTxt setSecureTextEntry:YES];//暗文
    self.passWordTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.loginRect addSubview:self.passWordTxt];
    
    [self.passWordTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(margin_5 * 2 + height_normal + 2 * 2));
        make.left.equalTo(@margin_5);
        make.right.equalTo(@-margin_5);
        make.height.equalTo(@height_normal);
        
    }];
    
    //loginBtn
    self.loginBtn = [BlockButton new];
    self.loginBtn.backgroundColor = colorGreenLogin;
    [self.loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    [Tools setCornerRadiusWithView:self.loginBtn andAngle:4];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-120);
        make.left.equalTo(@margin_10);
        make.right.equalTo(@-margin_10);
        make.height.equalTo(@height_normal);
        
    }];
    
    //click loginBtn Action
    self.loginBtn.block = ^(BlockButton *btn){
        [ws closeKeyboard];
        NSString *user = ws.userNameTxt.text;
        NSString *pwd  = ws.passWordTxt.text;
        
        //友情提示
        [ws inputTimesAdd];
        if (inputLoginInfoCount == 3)
        {
            [ws inputTimesIsZero];
            if (![user isEqualToString:@"123456"] | ![pwd isEqualToString:@"123456"])
            {
                [Tools toast:@"你可以试试123456呀！！！" andCuView:ws.view];
                return;
            }
            
        }
        
        //验证 信息合法性
        if ([user isEqualToString:@""] || [pwd isEqualToString:@""])
        {
            [Tools toast:@"用户名和密码不能为空！" andCuView:ws.view];
            return;
            
        }
        
        //正确 登录
        if ([user isEqualToString:@"123456"] && [pwd isEqualToString:@"123456"])
        {
            //保存用户名，密码到沙盒
            [NSUserDefaultTools saveUserName:user];
            [NSUserDefaultTools savePassWord:pwd];
            
            ContentsVC *vc = [ContentsVC new];
            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:vc];
            AppDel.window.rootViewController = navVC;
            return;
            
        }
        
        ws.userNameTxt.text = @"";
        ws.passWordTxt.text = @"";
        [Tools toast:@"用户名或密码输入错误！" andCuView:ws.view];
        
    };
    
}

- (void)inputTimesAdd
{
    inputLoginInfoCount++;
}

- (void)inputTimesIsZero
{
    inputLoginInfoCount = 0;
}

- (void)closeKeyboard
{
    [self.userNameTxt resignFirstResponder];
    [self.passWordTxt resignFirstResponder];
    
}

#pragma mark 关闭软键盘 点击空白背景时
- (void)closeKeyBoardWhenTouchBackView
{
    [self closeKeyboard];
    
}

#pragma mark 文本框代理 关闭软键盘
//点击return 按钮 关闭软键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
