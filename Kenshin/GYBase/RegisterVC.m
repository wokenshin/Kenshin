//
//  RegisterVC.m
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "RegisterVC.h"
#import "Tools.h"
#import "FlagField.h"
#import "BirthdayField.h"
#import "CityField.h"

@interface RegisterVC ()

@property (nonatomic, strong)FlagField      *textFlag;
@property (nonatomic, strong)BirthdayField  *textBirth;
@property (nonatomic, strong)CityField      *textCity;
@end

@implementation RegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initRegisterVCUI];
    
}

- (void)initRegisterVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    
    //关闭选择器 点击背景时
    UIControl *closePickerView = [[UIControl alloc] initWithFrame:self.view.frame];
    [closePickerView addTarget:self
                        action:@selector(pressBackgroundClosePickerView)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closePickerView];
    
    CGFloat labWidth  = 60;
    CGFloat textWidth = screenWidth - margin_10*3 - labWidth;
    CGFloat yBase     = 64 + margin_10;
    
    //国家
    UILabel *labCountry = [[UILabel alloc] initWithFrame:CGRectMake(margin_10, yBase, labWidth, height_normal)];
    labCountry.text = @"国家：";
    labCountry.textColor = [UIColor blackColor];
    
    self.textFlag = [[FlagField alloc] initWithFrame:CGRectMake(margin_10*2 +44, yBase, textWidth, height_normal)];
    self.textFlag.backgroundColor = colorGray;
    
    //生日
    UILabel *labBirth = [[UILabel alloc] initWithFrame:CGRectMake(margin_10, yBase+margin_10+height_normal, labWidth, height_normal)];
    labBirth.text = @"生日：";
    labBirth.textColor = [UIColor blackColor];
    
    self.textBirth = [[BirthdayField alloc] initWithFrame:CGRectMake(margin_10*2 + 44, yBase+margin_10+height_normal, textWidth, height_normal)];
    self.textBirth.backgroundColor = colorGray;
    
    //城市
    UILabel *labCity = [[UILabel alloc] initWithFrame:CGRectMake(margin_10, yBase+(margin_10+height_normal)*2, labWidth, height_normal)];
    labCity.text = @"城市：";
    labCity.textColor = [UIColor blackColor];
    
    self.textCity = [[CityField alloc] initWithFrame:CGRectMake(margin_10*2 + 44, yBase+(margin_10+height_normal)*2, textWidth, height_normal)];
    self.textCity.backgroundColor = colorGray;
    
    
    [self.view addSubview:labCountry];
    [self.view addSubview:self.textFlag];
    [self.view addSubview:labBirth];
    [self.view addSubview:self.textBirth];
    [self.view addSubview:labCity];
    [self.view addSubview:self.textCity];
    
}

#pragma mark 关闭选择器 点击背景时
- (void)pressBackgroundClosePickerView
{
    [self.textFlag  resignFirstResponder];
    [self.textBirth resignFirstResponder];
    [self.textCity  resignFirstResponder];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.textFlag  = nil;
    self.textBirth = nil;
    self.textCity  = nil;
    
}

@end
