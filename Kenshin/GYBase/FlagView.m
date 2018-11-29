//
//  FlagView.m
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "FlagView.h"
#import "Flag.h"//导入模型

@interface FlagView()

@property (weak, nonatomic) IBOutlet UILabel        *nameView;//国家
@property (weak, nonatomic) IBOutlet UIImageView    *flagView;//国旗


@end;

@implementation FlagView

+ (instancetype)flagView
{
    return [[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil][0];
    
}

//重写 set方法 外界通过此方法 给当前的自定义view赋值
- (void)setFlag:(Flag *)flag
{
    _flag = flag;
    
    //给控件赋值
    _nameView.text  = flag.name;
    _flagView.image = flag.icon;
    
}
@end
