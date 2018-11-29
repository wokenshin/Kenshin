//
//  CellTest.h
//  MSelectedTable
//
//  Created by 刘万兵 on 17/1/9.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellTest;
//定义了一个 代码块 类型 叫 CellTest
typedef void (^ClickButtonBlock)(UIButton *);

@interface CellTest : UITableViewCell

//定义 代码块 属性
@property (nonatomic, copy)ClickButtonBlock clickButtonBlock;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *lineNum;

@end
