//
//  FlagView.h
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Flag;
@interface FlagView : UIView//自定义 一个 国旗 view 

@property (nonatomic, strong)Flag *flag;//模型
+ (instancetype)flagView;
@end
