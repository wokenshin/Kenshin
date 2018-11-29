//
//  PickerVC.m
//  GYBase
//
//  Created by doit on 16/5/10.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "PickerVC.h"
#import "Tools.h"
#import "BlockButton.h"
#import "RegisterVC.h"

@interface PickerVC ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong)NSArray *dataArr;
@end

@implementation PickerVC

//懒加载
- (NSArray *)dataArr//get方法
{
    //下划线 描述的成员变量 并不会调用对应的get方法 只有 self.成员变量 的时候 才回调用到它的get方法
    if (_dataArr == nil) {
        _dataArr = [Tools plistArrayTypeWithName:@"pickerViewDemoData.plist"];
    }
    return _dataArr;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPickerVCUI];
    
    //选择器下边界y坐标
    CGFloat y = CGRectGetMaxY(self.picker.frame);
    BlockButton *nextBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, y + margin_10, 120, height_normal)];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    nextBtn.backgroundColor = RGB2Color(4, 175, 200);
    [self.view addSubview:nextBtn];
    WS(ws);//用弱引用的self 防止block 循环引用
    nextBtn.block = ^(BlockButton *b){
        RegisterVC *vc = [RegisterVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

- (void)initPickerVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Picker";
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, screenWidth - margin_10*2, 200)];
    self.picker.backgroundColor = RGB2Color(51, 122, 183);
    [self.view addSubview:self.picker];
    self.picker.delegate = self;
    
}

#pragma mark - 选择器 代理
//返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.dataArr count];//调用 get方法
    
}

//返回每列多少行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *arr = self.dataArr[component];
    return [arr count];
    
}

//返回 内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    NSArray *arr = self.dataArr[component];
    return arr[row];
    
}

//滚动停止后触发
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    NSString *cuPickerName = self.dataArr[component][row];
    NSLog(@"当前选中的是：%@", cuPickerName);
    
}
- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.picker  = nil;
    _dataArr     = nil;
    
}



@end
