//
//  OCContent.m
//  GYBase
//
//  Created by kenshin on 16/8/31.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "OCContent.h"
#import "Tools.h"
#import "Enums.h"//枚举
#import "NSDateVC.h"
#import "NSCalendarVC.h"

@interface OCContent ()

@end

@implementation OCContent

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

#pragma mark 枚举
- (IBAction)btnUseMeiJu:(id)sender
{
    [Tools toast:@"在项目中使用枚举是很有必要的" andCuView:self.view];
    
    
    //下面的枚举来之 Enums.h
    NSLog(@"———————————————————————输出枚举结果：TestType———————————————————————————————");
    NSLog(@"TestTypeOne             == %zd", TestTypeOne);
    NSLog(@"TestTypeTwo             == %zd", TestTypeTwo);
    NSLog(@"TestTypeThree           == %zd", TestTypeThree);
    
    NSLog(@"———————————————————————输出枚举结果：UserStatus———————————————————————————————");
    NSLog(@"UserStatusSleeping      == %zd", UserStatusSleeping);
    NSLog(@"UserStatusWorking       == %zd", UserStatusWorking);
    NSLog(@"UserStatusTalking       == %zd", UserStatusTalking);
    NSLog(@"UserStatusSmiling       == %zd", UserStatusSmiling);
    NSLog(@"UserStatusCrying        == %zd", UserStatusCrying);
    NSLog(@"UserStatusDreaming      == %zd", UserStatusDreaming);
    
    NSLog(@"———————————————————————输出枚举结果：KenshinStatus———————————————————————————————");
    NSLog(@"KenshinStatusSleeping   == %zd", KenshinStatusSleeping);
    NSLog(@"KenshinWorking          == %zd", KenshinWorking);
    NSLog(@"KenshinTalking          == %zd", KenshinTalking);
    NSLog(@"KenshinSmiling          == %zd", KenshinSmiling);
    NSLog(@"KenshinCrying           == %zd", KenshinCrying);
    NSLog(@"KenshinDreaming         == %zd", KenshinDreaming);
    
    NSLog(@"———————————————————————输出枚举结果：TomaStatus———————————————————————————————");
    NSLog(@"TomaStatusSleeping      == %zd", TomaStatusSleeping);
    NSLog(@"TomaStatusWorking       == %zd", TomaStatusWorking);
    NSLog(@"TomaStatusTalking       == %zd", TomaStatusTalking);
    
}

#pragma mark NSDate
- (IBAction)btnNSDate:(id)sender
{
    NSDateVC *vc = [NSDateVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark NSCalendar
- (IBAction)nsCalendar:(id)sender
{
    NSCalendarVC *vc = [[NSCalendarVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
