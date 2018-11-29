//
//  SettingCellModel.h
//  GYBase
//
//  Created by doit on 16/5/12.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingCellModel : NSObject

@property (nonatomic, strong)NSString       *title;
@property (nonatomic, strong)NSString       *tellPhone;

//定义类方法用于快速创建对象
+(instancetype)settingCellModelWith:(NSDictionary *)dic;

@end
