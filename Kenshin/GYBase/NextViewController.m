//
//  NextViewController.m
//  GYBase
//
//  Created by doit on 16/4/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Tools.h"
#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Block send msg";
    
    self.inputTF = [[UITextField alloc] initWithFrame:CGRectMake(margin_5, 150, screenWidth - 2 * margin_5, height_normal)];
    self.inputTF.textColor = [UIColor blackColor];
    self.inputTF.backgroundColor = [UIColor yellowColor];
    self.inputTF.textAlignment = NSTextAlignmentCenter;
    self.inputTF.placeholder = @"回传值 在这里输入！！！";
    [self.view addSubview:self.inputTF];
    
    
    UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [popBtn setTitle:@"click back send a msg" forState:UIControlStateNormal];
    popBtn.center = CGPointMake(screenWidth/2, 100);
    [popBtn addTarget:self action:@selector(popBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    popBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:popBtn];
    
}

- (void)popBtnClicked
{
    /*调用block之前最好先判断block是否为空，不为空才调用，否则程序崩溃*/
    if (self.NextViewControllerBlock)
    {
        self.NextViewControllerBlock(self.inputTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
