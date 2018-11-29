//
//  NSCalendarVC.m
//  GYBase
//
//  Created by kenshin on 16/9/12.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NSCalendarVC.h"

@interface NSCalendarVC ()

@end

@implementation NSCalendarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"NSCalendar";
    [Tools toast:@"控制台" andCuView:self.view andHeight:300];
    
    //完全可以通过下面的方法自己封装一个类 或者是添加分类来实现自己想要的需求
    
}


//获取当前时间的 年 月 日 时 分 秒
- (IBAction)function_01:(id)sender
{
    //结合NSCalendar 和 NSDate 能做更多的 日期/时间 处理
    
    //获取当前时间
    NSDate *now = [NSDate date];
    NSLog(@"now %@", now);
    
    //利用日历类 从当前时间对象中获取 年月日时分秒【单独获取】
    //获得NSCalendar对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //一般情况下 如果以个方法接收的参数是枚举类型，那么可以用过 或 "|" 符号链接多个枚举值
    NSCalendarUnit type = NSCalendarUnitYear |
                          NSCalendarUnitMonth |
                          NSCalendarUnitDay |
                          NSCalendarUnitHour |
                          NSCalendarUnitMinute |
                          NSCalendarUnitSecond;
    
    //component:参数的含义是，问你需要获取什么
    NSDateComponents *cmps = [calendar components:type fromDate:now];
    NSLog(@"year == %ld", cmps.year);
    NSLog(@"month == %ld", cmps.month);
    NSLog(@"day == %ld", cmps.day);
    NSLog(@"hour == %ld", cmps.hour);
    NSLog(@"minute == %ld", cmps.minute);
    NSLog(@"second == %ld", cmps.second);
    
}

//比较两个时间的差值
- (IBAction)compareTwoTimes:(id)sender
{
    //比较两个时间的差值 比较相差 多少年 多少月 多少日 多少小时 多少分钟 多少秒
    
    //时间1
    NSString *str = @"2016-09-12 15:26:17 +0000";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    NSDate *date = [formatter dateFromString:str];
    
    //时间2
    NSDate *now = [NSDate date];
    
    //比较两个时间
    NSCalendarUnit type = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:type fromDate:date toDate:now options:0];
    
    NSLog(@"date == %@", date);
    NSLog(@"now  == %@", now);
    NSLog(@"两个时间相差：%ld年%ld月%ld日%ld时%ld分%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
