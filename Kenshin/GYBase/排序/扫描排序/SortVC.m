//
//  SortVC.m
//  GYBase
//
//  Created by kenshin on 17/2/8.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "SortVC.h"

@interface SortVC ()

@property (nonatomic, strong) NSMutableArray                *mArr;

@end

@implementation SortVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"排序";
    
    
    _mArr = [NSMutableArray arrayWithArray:@[@3, @1, @100, @20, @5, @7, @9, @60, @8]];
    NSLog(@"%@", _mArr);
    
    [self buddleSort:_mArr];
    NSLog(@"%@", _mArr);
    
    NSLog(@"");
    
}

//冒泡排序
//参考：http://blog.csdn.net/u011619283/article/details/23934599
- (void)buddleSort:(NSMutableArray *)array
{
    if(array == nil || array.count == 0)
    {
        return;
    }
    
    for (int i = 1; i < array.count; i++)
    {
        for (int j = 0; j < array.count - i; j++)
        {
            if ([array[j] compare:array[j+1]] == NSOrderedDescending)
            {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
}


@end
