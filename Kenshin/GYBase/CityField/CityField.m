//
//  CityField.m
//  GYBase
//
//  Created by doit on 16/5/14.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CityField.h"
#import "Tools.h"
#import "Provinces.h"

@interface CityField ()<UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate>

@property (nonatomic, strong)NSMutableArray        *provinces;//省
@property (nonatomic, assign)NSInteger             cuSelectProvincesIndex;
@property (nonatomic, strong)UIPickerView          *cityPicker;
@end

@implementation CityField

- (void)awakeFromNib
{
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
    //自定义城市键盘
    self.cityPicker = [[UIPickerView alloc] init];
    self.cityPicker.delegate   = self;
    self.cityPicker.dataSource = self;
    
    //设置Field的弹出键盘为 cityPicker
    self.inputView = self.cityPicker;
    
    self.delegate  = self;///实现代理 禁止编辑
    
}

//初始化文本框的默认值［在第一次获取到焦点的时候调用］
- (void)initTextValue
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        [self pickerView:self.cityPicker didSelectRow:0 inComponent:0];
        
    });

}

- (NSMutableArray *)provinces
{
    if (_provinces == nil)
    {
        _provinces = [NSMutableArray array];//初始化
        NSArray *arr = [Tools plistArrayTypeWithName:@"provinces.plist"];
        
        //将数组中的内容转换成模型
        for (int i = 0; i <[arr count]; i++)
        {
            NSDictionary *dic = arr[i];
            Provinces *proModel =[Provinces provincesWithDic:dic];
            [_provinces addObject:proModel];
            
        }
        
    }
    return _provinces;
    
}
#pragma mark - 数据源代理
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
    
}

//返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)//第一列返回的行数 就是总的省数
    {
        return [self.provinces count];
        
    }
    else//第二列返回的行数由当前选中的第一列的行数来决定[通过代理 获取当前选中的第一列的那一行]
    {
        Provinces *model = self.provinces[_cuSelectProvincesIndex];
        return [model.cities count];
        
    }
    
}

//定义每一列每一行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //第一列 返回全国的省
    if (component == 0)
    {
        Provinces *model = self.provinces[row];
        return model.name;
        
    }
    //第二列 返回对应省下的城市
    else
    {
        Provinces *model = self.provinces[_cuSelectProvincesIndex];
        return model.cities[row];
        
    }
    
}

#pragma mark 代理 选中时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)//操作第0列时
    {
        _cuSelectProvincesIndex = row;//记录第0列选中的行
        [pickerView reloadComponent:1];//刷新低1列
        [pickerView selectRow:0 inComponent:1 animated:YES];  //让第1列显示第0行，上一行代码只会刷新数据，不回初始化到第0行
        
    }
    
    //将选中的值赋值到文本框上
    //获取当前选中的省
    Provinces *model = self.provinces[_cuSelectProvincesIndex];
    NSString *ProName = model.name;
    
    //获取当前选中的城市[两种情况：1，当前滑动的第0列，2，当前滑动的第1列]
    //获取第1列选中的行
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    NSArray   *cities = model.cities;
    NSString  *cityName = cities[cityIndex];
    
    NSString *proCity = [NSString stringWithFormat:@"%@ %@", ProName, cityName];
    self.text = proCity;
    
}

#pragma mark 代理
//禁止用户输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSLog(@"我顶你个肺啊！");
    return NO;
    
}

//开始编辑时调用[第一次获取焦点时调用]
- (void)textFieldDidBeginEditing:(CityField *)textField
{
    [self initTextValue];
    
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

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.provinces  = nil;
    self.cityPicker = nil;
    
}
@end
