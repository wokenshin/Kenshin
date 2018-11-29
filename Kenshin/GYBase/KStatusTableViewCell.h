//
//  KStatusTableViewCell.h
//  GYBase
//
//  Created by doit on 16/6/1.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KStatus;

@interface KStatusTableViewCell : UITableViewCell//自定义的 UITableViewCell


#pragma mark 微博对象
@property (nonatomic, strong) KStatus *status;

#pragma mark 单元格高度
@property (nonatomic, assign) CGFloat height;

@end
