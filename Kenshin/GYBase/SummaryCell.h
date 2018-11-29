//
//  SummaryCell.h
//  GYBase
//
//  Created by doit on 16/4/21.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SummaryFrame;

@interface SummaryCell : UITableViewCell

@property (nonatomic, strong)SummaryFrame *modelFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
