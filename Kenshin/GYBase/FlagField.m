//
//  FlagField.m
//  GYBase
//
//  Created by doit on 16/5/10.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "FlagField.h"
#import "Tools.h"
#import "Flag.h"//导入模型
#import "FlagView.h"

@implementation FlagField

//只要从xib或者sb加载 就会调用这个方法，只会调用一次
- (void)awakeFromNib
{
    [self setUp];
    
}

//通过代码 初始化时 回调用这个方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
    }
    return self;
    
}

//初始化文本框的默认值［在第一次获取到焦点的时候调用］
- (void)initTextValue
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        [self pickerView:nil didSelectRow:0 inComponent:0];
        
    });
    
}

//自定义初始化
- (void)setUp
{
    //创建国旗键盘［UIPickerView]
    self.flagPicker = [UIPickerView new];//不用设置尺寸 因为它有默认尺寸［xib中已经设置好了］
    //设置数据源和代理
    self.flagPicker.delegate   = self;
    self.flagPicker.dataSource = self;
    
    //自定义键盘［弹出view］
    self.inputView = self.flagPicker;
    self.delegate  = self;///实现代理 禁止编辑
    
}

//懒加载 get方法
- (NSMutableArray *)flags
{
    if (_flags == nil)
    {
        _flags = [NSMutableArray array];//初始化
        
        NSArray *dicArr = [Tools plistArrayTypeWithName:@"flags.plist"];
        
        //字典转模型
        for (NSDictionary *dict in dicArr)
        {
            id obj = [Flag flagWithDict:dict];
            [_flags addObject:obj];
        }
        
    }
    return _flags;
}

#pragma mark UIPickerViewDataSource
//返回picker 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

//返回 第几列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.flags count];
    
}

#pragma mark UIPickerViewDelegate
//返回第component列的第row行的控件
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    //创建自定义view
    FlagView *flagView = [FlagView flagView];
    
    //获取到对应的模型
    Flag *flag = self.flags[row];
    
    //将模型中的数据赋值到自定义的view上
    flagView.flag = flag;
    
    return flagView;
}

//返回行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 100;//FlagView 的高度
    
}

//选中某行时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Flag *flag = self.flags[row];
    self.text  = flag.name;
    
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
    self.flags = nil;
    self.flagPicker = nil;
    
}
@end
