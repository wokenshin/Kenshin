//
//  FlagField.h
//  GYBase
//
//  Created by doit on 16/5/10.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlagField : UITextField<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>//封装一个 国旗文本狂

//当数据源的类型时一个 数组字典时通常存储的是一类模型数据 此时需要用可变数组来存储数据[因为在添加模型道数据源的时候 需要一个一个的添加]
@property (nonatomic, strong)NSMutableArray     *flags;//数据源
@property (nonatomic, strong)UIPickerView       *flagPicker;
@end
