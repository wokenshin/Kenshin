//
//  JiBuQiVC.m
//  GYBase
//
//  Created by kenshin on 16/9/8.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "JiBuQiVC.h"
#import <CoreMotion/CoreMotion.h>


@interface JiBuQiVC ()

@property (nonatomic, strong) CMPedometer           *meter;

//步数
@property (weak, nonatomic) IBOutlet UILabel        *stepsLab;

//距离
@property (weak, nonatomic) IBOutlet UILabel        *distanceLab;

@end

@implementation JiBuQiVC

#pragma mark - <懒加载>
- (CMPedometer *)meter
{
    
    if (!_meter)
    {
        _meter = [[CMPedometer alloc]init];
    }
    return _meter;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"CoreMotion框架";
    [self starSportServer];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //通过通知来获取运动数据
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(numberOfStepsChanged:)
                                                 name:@"numberOfSteps"
                                               object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"numberOfSteps" object:nil];
    
}

- (void)starSportServer
{
    //判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable])
    {
        NSLog(@"计步器不可用");
        return;
    }
    
    
    //在一段时间内的部步数与距离
    //获取当天凌晨的时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSLog(@"%@", startDate);
    //获取当天凌晨的时间 第二种方式
//    NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:now];
    NSLog(@"------->>>>>>%@",[NSDate dateWithTimeIntervalSinceNow:0]);
    //开始计步 从  今天凌晨   到  现在
    [self.meter queryPedometerDataFromDate:startDate
                                    toDate:[NSDate dateWithTimeIntervalSinceNow:0]//时间 = 从现在过 多少秒后 这里设置的0秒
                               withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"error===%@",error);
            
        }
        else
        {
            NSLog(@"步数===%@",pedometerData.numberOfSteps);
            NSLog(@"距离===%@",pedometerData.distance);
            
            NSMutableDictionary *dicM = [NSMutableDictionary new];
            [dicM setObject:[NSString stringWithFormat:@"%@",pedometerData.numberOfSteps] forKey:@"numberOfSteps"];
            [dicM setObject:[NSString stringWithFormat:@"%.0f",[pedometerData.distance doubleValue]] forKey:@"distance"];
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"numberOfSteps" object:nil userInfo:dicM];
            
        }
    }];

}

-(void)numberOfStepsChanged:(NSNotification *)notif
{
    NSString *numberOfSteps = [[notif userInfo] objectForKey:@"numberOfSteps"];
    NSString *distance      = [[notif userInfo] objectForKey:@"distance"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _stepsLab.text    = [NSString stringWithFormat:@"今天步行了%@步", numberOfSteps];
        _distanceLab.text = [NSString stringWithFormat:@"今天步行了%@米", distance];
    });
    
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
