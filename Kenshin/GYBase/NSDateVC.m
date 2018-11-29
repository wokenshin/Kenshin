//
//  NSDateVC.m
//  GYBase
//
//  Created by kenshin on 16/9/8.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NSDateVC.h"
#import "DateUtil.h"

@interface NSDateVC ()

@end

@implementation NSDateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"NSDate";
    [Tools toast:@"看代码 看控制台" andCuView:self.view andHeight:300];
    

//
//    //返回 年 月 日
//    cuDateStr = [DateUtil dateToStringYMD:cuDate];
//    NSLog(@"cuDateStr == %@", cuDateStr);
//    
//    
//    for (int y = 1990; y < 2017; y ++)
//    {
//        for (int m = 1; m <= 12; m++)
//        {
//            NSLog(@"今年是%zd年, 这一年的%zd月有  %zd天", y, m, [self howManyDaysInThisYear:y withMonth:m]);
//            
//            NSString *dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd", y, m, [self howManyDaysInThisYear:y withMonth:m]];
//            NSDate *date = [NSDate date];
//            date = [DateUtil stringToDate:dateStr dateFormat:@"yyyy-MM-dd"];
//            NSLog(@"%@", date);
//        }
//    }
    
}


#pragma mark - 获取某年某月的天数
- (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

//获取当前时间
- (IBAction)getCuDate:(id)sender
{
    //获取当前时间 创建date
    //[NSDate date]这个最常用的方法你可以得到系统当前的时间（UTC时间，零时区）
    NSDate *cuDate = [NSDate date];
    NSLog(@"cuDate == %@",cuDate);
    
    //输出内容： cuDate == 2016-09-12 06:49:37 +0000
    //这里的 +0000 指的是 零时区 中国是在东八区
    //也就是说 中国的时间和这里获取的零时区的时间相差8个小时  所以上输出的时间转换成中国时间是：2016-09-12 14:49:37
}

//获取当天凌晨的时间
- (IBAction)getToDayZeroTime:(id)sender
{
    //获取当天凌晨的时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSLog(@"今天凌晨  零时区时间 == %@", startDate);
    
    //添加时区时间间隔
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSInteger fromInterval = [timeZone secondsFromGMTForDate:startDate];
    NSDate *zeroDate = [startDate  dateByAddingTimeInterval: fromInterval];
    
    NSLog(@"今天凌晨  北京时间 == %@", zeroDate);
    
}

//获取昨天的此时时间
- (IBAction)getYesterdayCuTime:(id)sender
{
    //获取前一天此时的date
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSLog(@"昨天的现在的时间 【零时区】 == %@", yesterday);
    
}

//获取最近七天的时间 间隔为24小时 零时区
- (IBAction)getSevenDaysTime
{
    NSInteger day = 60*60*24;
    for (int i = 1; i <= 7; i++)
    {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(day*i)];
        NSLog(@"前%zd天的时间 【零时区】 == %@", i, date);
    }
    
    
}

//获取最近七天的凌晨时间
- (IBAction)getSevenDaysZeroTime:(id)sender
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];//当前的时间
    
    //凌晨的时间
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    
    NSLog(@"%@", [self dateToString:startDate]);
    
    //第二天凌晨的时间
    for (int i = 1; i <= 6; i++)
    {
        NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-i toDate:startDate options:0];
        NSLog(@"%@", [self dateToString:endDate]);
        
    }
    
}

//将date转成本地时区date
- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss"; // 设置时间和日期的格式
    
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置时区
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}

//下面代码来自小马哥视频
- (IBAction)baseOne
{
    //1.NSDate的创建 和 基本概念
    
    //通过 date方法创建的时间对象 对象中就保存了当前的时间
    NSDate *now = [NSDate date];
    NSLog(@"now == %@", now);
    
    //在 当前时间对象的基础上添加多少秒
    NSDate *date = [now dateByAddingTimeInterval:10];
    NSLog(@"date == %@", date);
    
    //1获取当前所处的时区
    NSTimeZone *zone = [NSTimeZone localTimeZone];//or [NSTimeZone systemTimeZone];
    //2获取当前时区和指定时间的时间差[秒]
    NSInteger seconds = [zone secondsFromGMTForDate:now];
    NSLog(@"时间差是 %lu 秒", seconds);
    
    //输出本地时区的当前时间
    NSDate *newDate = [now dateByAddingTimeInterval:seconds];
    NSLog(@"newDate == %@", newDate);
}

//时间格式化

//NSDate --> NSString
- (IBAction)TimeFormatter:(id)sender
{
    //创建一个当前时间的时间对象
    NSDate *now = [NSDate date];
    
    //创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //告诉时间格式化对象，按照什么样的格式来格式化时间
    /*
     yyyy 代表 年
     MM       月
     dd       日
     HH 24小时   hh 12小时
     mm 分钟
     ss 秒
     Z  时区
     */
    formatter.dateFormat = @"yyyy范MM希dd望 HH:mm:ss Z";
    
    //利用【时间格式化对象】对【时间对象】进行格式化
    NSString *DateStr = [formatter stringFromDate:now];
    NSLog(@"DateStr == %@", DateStr);
}

//NSString --> NSDate
- (IBAction)stringToDate:(id)sender
{
    NSString *str = @"2016-09-12 15:26:17 +0000";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //注意：字符串转date的时候 下面的格式一定要和字符串的格式一致， 如下 如果 不写Z的话 将无法转换【返回 null】 必须完全一致才能换换
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:str];
    NSLog(@"date == %@", date);
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    NSDate *date2 = [formatter dateFromString:str];
    NSLog(@"date == %@", date2);
    
}

@end
