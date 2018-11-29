//
//  NameVC.m
//  GYBase
//
//  Created by doit on 16/5/12.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NameVC.h"
#import "Tools.h"
#import "BlockButton.h"
#import "NSUserDefaultTools.h"

@interface NameVC ()

@property (nonatomic, strong)UITextView         *textSetName;
@property (nonatomic, strong)BlockButton        *btnOk;

@end

@implementation NameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNameVCUI];
    [self loadData];
    
}

- (void)initNameVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"姓名";
    
    //签名文本框
    self.textSetName = [[UITextView alloc] initWithFrame:CGRectMake(margin_10, margin_10, screenWidth - margin_10*2, 44)];
    self.textSetName.backgroundColor = colorGray;
    self.textSetName.delegate = self;
    self.textSetName.font = [UIFont systemFontOfSize:18];
    [Tools setCornerRadiusWithView:self.textSetName andAngle:6];
    
    //确认按钮
    CGFloat btnWidth = screenWidth * 0.75;
    CGFloat btnHeight = 36;
    
    self.btnOk = [[BlockButton alloc] initWithFrame:CGRectMake(screenWidth/2 - btnWidth/2, screenHeight - 270, btnWidth, btnHeight)];
    [self.btnOk setTitle:@"确认" forState:UIControlStateNormal];
    self.btnOk.backgroundColor = RGB2Color(66, 210, 83);
    [Tools setCornerRadiusWithView:self.btnOk andAngle:btnHeight/2];
    
    WS(ws);
    self.btnOk.block = ^(BlockButton *btn){
        if ([ws.textSetName.text isEqualToString:@""])
        {
            [Tools toast:@"输入邮箱错误！" andCuView:ws.view andHeight:300];
            return ;
            
        }
        [NSUserDefaultTools saveSettingName:ws.textSetName.text];
        [ws.navigationController popViewControllerAnimated:YES];
        
    };
    
    [self.view addSubview:self.textSetName];
    [self.view addSubview:self.btnOk];
    
}

- (void)loadData
{
    self.textSetName.text = [NSUserDefaultTools getSettingName];
    
}

//触摸空白view时 关闭软键盘
- (void)closeKeyBoardWhenTouchBackView
{
    [self.textSetName resignFirstResponder];
    
}

#pragma mark 代理 UITextView
//限制输入字符长度
-(void)textViewDidChange:(UITextView *)textView
{
    NSUInteger len = textView.text.length;
    if (len >= 9)
    {
        len = 9;
        self.textSetName.text = [textView.text substringToIndex:8];
    }
    
}

//软键盘 return 关闭软键盘
//每次点击键盘时 都会先调用本方法 返回的BOOL值 决定当前textview 是否允许编辑
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
    self.textSetName = nil;
    self.btnOk       = nil;
    
}

@end
