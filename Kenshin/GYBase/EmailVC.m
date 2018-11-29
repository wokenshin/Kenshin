//
//  EmailVC.m
//  GYBase
//
//  Created by doit on 16/5/12.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "EmailVC.h"
#import "Tools.h"
#import "BlockButton.h"
#import "NSUserDefaultTools.h"
#import "RegexUtil.h"

@interface EmailVC ()
@property (nonatomic, strong)UITextView         *textSetEmail;
@property (nonatomic, strong)BlockButton        *btnOk;
@end

@implementation EmailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNameVCUI];
    [self loadData];
    
}

- (void)initNameVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"邮箱";
    
    //签名文本框
    self.textSetEmail = [[UITextView alloc] initWithFrame:CGRectMake(margin_10, margin_10, screenWidth - margin_10*2, 44)];
    self.textSetEmail.backgroundColor = colorGray;
    self.textSetEmail.delegate = self;
    self.textSetEmail.font = [UIFont systemFontOfSize:18];
    [Tools setCornerRadiusWithView:self.textSetEmail andAngle:6];
    
    //确认按钮
    CGFloat btnWidth = screenWidth * 0.75;
    CGFloat btnHeight = 36;
    
    self.btnOk = [[BlockButton alloc] initWithFrame:CGRectMake(screenWidth/2 - btnWidth/2, screenHeight - 270, btnWidth, btnHeight)];
    [self.btnOk setTitle:@"确认" forState:UIControlStateNormal];
    self.btnOk.backgroundColor = RGB2Color(66, 210, 83);
    [Tools setCornerRadiusWithView:self.btnOk andAngle:btnHeight/2];
    
    WS(ws);
    self.btnOk.block = ^(BlockButton *btn){
        if (![RegexUtil isValidEmail:ws.textSetEmail.text])
        {
            [Tools toast:@"请输入和法地址！" andCuView:ws.view andHeight:300];
            return ;
            
        }
        
        [NSUserDefaultTools saveEmail:ws.textSetEmail.text];
        [ws.navigationController popViewControllerAnimated:YES];
        
    };
    
    [self.view addSubview:self.textSetEmail];
    [self.view addSubview:self.btnOk];
    
}

- (void)loadData
{
    self.textSetEmail.text = [NSUserDefaultTools emailAddress];
    
}

- (void)closeKeyBoardWhenTouchBackView
{
    [self.textSetEmail resignFirstResponder];
    
}

//软键盘 return 关闭软键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])//textview 弹出软键盘时的retuan键 是换行键＝\n
    {
        [textView resignFirstResponder];
        return FALSE;
    }
    
    return TRUE;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.textSetEmail = nil;
    self.btnOk        = nil;
    
}

@end
