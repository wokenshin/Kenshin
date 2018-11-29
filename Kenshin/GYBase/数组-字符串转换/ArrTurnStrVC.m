//
//  ArrTurnStrVC.m
//  GYBase
//
//  Created by kenshin on 17/2/8.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "ArrTurnStrVC.h"

@interface ArrTurnStrVC ()

@end

@implementation ArrTurnStrVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"数组-字符串 转换";
    
    //数组转字符串
    NSArray *arr = @[@"kenshin", @"kenshin", @"kenshin", @"kenshin", @"kenshin", @"kenshin",];
    NSString *string = [arr componentsJoinedByString:@","];
    
    //数组转json 字符串数组
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"%@", string);
    NSLog(@"%@", jsonStr);
    
    NSArray *arrBack = [self toArrayOrNSDictionary:[jsonStr dataUsingEncoding:NSASCIIStringEncoding]];

    
    //字符串转数组
    NSString *strArr = @"[lock, lock, lock, lock, lock, lock, lock, lock]";
    
    
}

// 将JSON串转化为字典或者数组
- (id)toArrayOrNSDictionary:(NSData *)jsonData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil)
    {
        return jsonObject;
    }
    else
    {
        // 解析错误
        return nil;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
