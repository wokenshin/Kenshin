//
//  FuckBlockVC.m
//  GYBase
//
//  Created by kenshin on 17/1/24.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "FuckBlockVC.h"

@interface FuckBlockVC ()

@end

@implementation FuckBlockVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)btnInBlockChangeLocalValue:(id)sender
{
    //将Block定义在方法内部
//    int x = 100;
    int __block x = 100;//block内部修改外部变量的值的时候 需要加 __block 修饰
    void (^sumXAndYBlock)(int) = ^(int y){
        x = x+y;
        printf("new x value is %d",x);
    };
    sumXAndYBlock(50);
    
}




@end
