//
//  BirthdayField.m
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "BirthdayField.h"
#import "Tools.h"

@interface BirthdayField()
@property (nonatomic, strong)UIDatePicker *picker;

@end

@implementation BirthdayField

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
        
    }
    return self;
}

//初始化
- (void)setUp
{
    //创建日期选择控件
    self.picker = [UIDatePicker new];
    
    //设置日起模式为：年 月 日
    self.picker.datePickerMode = UIDatePickerModeDate;
    
    //设置地区 zh:中国标识
    self.picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //自定义文本框的键盘
    self.inputView = self.picker;
    
    //UIDatePicker 没有定义代理 但是它是继承自UIControl 所以可以给它绑定监听器 来监听其行为
    [self.picker addTarget:self action:@selector(selectedData:) forControlEvents:UIControlEventValueChanged];
    
    //实现代理 禁止编辑
    self.delegate = self;
    
}

//初始化文本框的默认值［在第一次获取到焦点的时候调用］
- (void)initTextValue
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        [self selectedData:self.picker];
        
    });
    
}

- (void)selectedData:(UIDatePicker *)picker
{
    //创建一个日期格式字符串对象 用于将data转换成字符串
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.text = [fmt stringFromDate:picker.date];
    
}

#pragma mark 覆盖父类方法［缩进的效果］
//控制文本所在的的位置，左右缩 10[初始化 set上值的时候]
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
    
}

//控制编辑文本时所在的位置，左右缩 10[编辑的时候]
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
    
}

#pragma mark 代理 拦截用用户编辑文本框
//禁止编辑文本款［即 只允许通过选择器来对内容进行修改］
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSLog(@"我顶你个肺啊！");
    return NO;
}

//每次获取到焦点时调用
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self initTextValue];//初始化文本框 本方法内部只会执行一次
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
