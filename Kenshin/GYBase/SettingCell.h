//
//  SettingCell.h
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingCellModel;
@interface SettingCell : UITableViewCell

@property (nonatomic, strong)SettingCellModel *model;

- (instancetype)initWithFrame:(CGRect)frame;

@end
