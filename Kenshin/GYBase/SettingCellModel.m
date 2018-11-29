//
//  SettingCellModel.m
//  GYBase
//
//  Created by doit on 16/5/12.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SettingCellModel.h"

@implementation SettingCellModel


+(instancetype)settingCellModelWith:(NSDictionary *)dic
{
    SettingCellModel *model = [SettingCellModel new];
    
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}
@end
