//
//  TextVC.m
//  GYBase
//
//  Created by doit on 16/4/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "TextVC.h"
#import "Tools.h"
#import "TextSuoJin.h"

@interface TextVC ()<UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray     *textAll;
@property (nonatomic, strong)UITextField        *textClear;
@property (nonatomic, strong)UITextField        *textNum;
@property (nonatomic, strong)UITextField        *textEnglish;
@property (nonatomic, strong)TextSuoJin         *textSuoJin;
@property (nonatomic, strong)UITextField        *textAction;
@property (nonatomic, strong)UITextField        *textReturn;

@end

@implementation TextVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextVCUI];
    
    
}

- (void)initTextVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"TextField 常用功能";
    
    //关闭软键盘 点击背景时
    UIControl *closeKeyBoard = [[UIControl alloc] initWithFrame:self.view.frame];
    [closeKeyBoard addTarget:self
                      action:@selector(pressBackgroundCloseKeyBoard)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeKeyBoard];

    //一键清空
    
    //1文本只能输入数字
    
    //2文本只能输入英语
    
    //首行缩进［需要重写父类两个方法］
    
    //左边图片 右边文本[参考 博文智控]
    
    CGFloat yBase      = 64 + margin_10;
    CGFloat xBase      = margin_10;
    CGFloat textWidth  = screenWidth - margin_10*2;
    CGFloat textHeight = height_normal;
    CGFloat marginY    = margin_10 + textHeight;
    
    self.textClear   = [[UITextField alloc] initWithFrame:CGRectMake(xBase, yBase, textWidth, textHeight)];
    self.textNum     = [[UITextField alloc] initWithFrame:CGRectMake(xBase, yBase + marginY, textWidth, textHeight)];
    self.textEnglish = [[UITextField alloc] initWithFrame:CGRectMake(xBase, yBase + marginY*2, textWidth, textHeight)];
    self.textSuoJin  = [[TextSuoJin  alloc] initWithFrame:CGRectMake(xBase, yBase + marginY*3, textWidth, textHeight)];
    self.textAction  = [[UITextField alloc] initWithFrame:CGRectMake(xBase, yBase + marginY*4, textWidth, textHeight)];
    self.textReturn  = [[UITextField alloc] initWithFrame:CGRectMake(xBase, yBase + marginY*5, textWidth, textHeight)];
    
    self.textAll = [NSMutableArray array];
    [self.textAll addObject:self.textClear];
    [self.textAll addObject:self.textNum];
    [self.textAll addObject:self.textEnglish];
    [self.textAll addObject:self.textSuoJin];
    [self.textAll addObject:self.textAction];
    [self.textAll addObject:self.textReturn];
    
    //添加事件
    [self.textAction addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    self.textAction.tag = 1;
    
    //实现代理
    self.textReturn.delegate = self;
    
    self.textClear.clearButtonMode = UITextFieldViewModeAlways;//清空按钮
    self.textNum.keyboardType = UIKeyboardTypeNumberPad;//键盘类型
    self.textEnglish.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    self.textClear.placeholder   = @"清空按钮";
    self.textNum.placeholder     = @"数字键盘";
    self.textEnglish.placeholder = @"英语键盘";
    self.textSuoJin.placeholder  = @"首行缩进";
    self.textAction.placeholder  = @"监听输入内容";
    self.textReturn.placeholder  = @"点击Return 关闭软键盘";

    
    for (int i = 0; i < [self.textAll count]; i ++)
    {
        [self.textAll[i] setBackgroundColor:colorGray];
        [self.view addSubview:self.textAll[i]];
    }
//    self.textClear.backgroundColor   = colorGray;
//    self.textNum.backgroundColor     = colorGray;
//    self.textEnglish.backgroundColor = colorGray;
//    self.textSuoJin.backgroundColor  = colorGray;
//    self.textAction.backgroundColor  = colorGray;
//    self.textReturn.backgroundColor  = colorGray;
    
//    [self.view addSubview:self.textClear];
//    [self.view addSubview:self.textNum];
//    [self.view addSubview:self.textEnglish];
//    [self.view addSubview:self.textSuoJin];
//    [self.view addSubview:self.textAction];
//    [self.view addSubview:self.textReturn];
    
}

#pragma mark 关闭软键盘 点击背景时
- (void)pressBackgroundCloseKeyBoard
{
    for (int i = 0; i <[self.textAll count]; i++)
    {
        [self.textAll[i] resignFirstResponder];
        
    }
//    [self.textClear   resignFirstResponder];
//    [self.textNum     resignFirstResponder];
//    [self.textEnglish resignFirstResponder];
//    [self.textSuoJin  resignFirstResponder];
//    [self.textAction  resignFirstResponder];
//    [self.textReturn  resignFirstResponder];
}

#pragma mark TextField代理
//点击 软键盘Return 关闭软键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}

//下面这个不是代理
//监听输入内容 [及时是点击清空按钮的时候 也会监听]
- (void)textfieldChanged:(UITextField*)textField
{
    if (textField.tag == 1)//textAction
    {
        if (textField.text.length <= 255)
        {
            //获取 0 到 255（256-1） 的随机数
            int value  = arc4random() % 256;
            int value2 = arc4random() % 256;
            int value3 = arc4random() % 256;
            
            self.view.backgroundColor = RGB2Color(value, value2, value3);
        }
        if (textField.text.length == 0)
        {
            self.view.backgroundColor = [UIColor whiteColor];
        }
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.textClear   = nil;
    self.textNum     = nil;
    self.textEnglish = nil;
    self.textSuoJin  = nil;
    self.textAction  = nil;
    self.textReturn  = nil;
    self.textAll     = nil;
    
}

@end
