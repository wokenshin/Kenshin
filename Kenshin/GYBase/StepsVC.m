//
//  StepsVC.m
//  GYBase
//
//  Created by kenshin on 16/9/9.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    
 
 
 
 
 */

#import "StepsVC.h"
#import "Tools.h"

#import <CoreMotion/CoreMotion.h>

@interface StepsVC ()

@property (weak, nonatomic) IBOutlet UILabel        *stepsLab;
@property (nonatomic, strong) CMPedometer           *pedometer;

@end

@implementation StepsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools setCornerRadiusWithView:_stepsLab andAngle:_stepsLab.frame.size.height/2.0];
    
    //1.判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable])
    {
        NSLog(@"计步器不可用");
        return;
    }
    
    //2.创建计步器对象
    self.pedometer = [[CMPedometer alloc] init];
    
    //3.开始计步
    //参数：时间：从某一个时间开始计步   [NSDate date]代表当前时间  【即：从现在起 走了多少步】
    WS(ws);
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        NSLog(@"走了%@", pedometerData.numberOfSteps);
        
        //之前下面的代码一直没有更新UI 是因为没有将它放到主线程中去执行造成的
        //ws.stepsLab.text = [NSString stringWithFormat:@"今天走了%@步", pedometerData.numberOfSteps];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            ws.stepsLab.text = [NSString stringWithFormat:@"现在您走了%@步", pedometerData.numberOfSteps];
        }];
        
    }];
    
}

#pragma mark 懒加载
- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
    
}

#pragma mark 查询前两天走了多少步
- (IBAction)querySumStepsTwoDay:(id)sender
{
    //查询前两天走了多少步  最多查询 七天的步数
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *framDate = [fmt dateFromString:@"2016-09-07"];
    NSDate *toDate   = [fmt dateFromString:@"2016-09-09"];
    WS(ws);
    [self.pedometer queryPedometerDataFromDate:framDate toDate:toDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
       
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (pedometerData == nil) {
                ws.stepsLab.text = [NSString stringWithFormat:@"没有计步数据"];
            }
            ws.stepsLab.text = [NSString stringWithFormat:@"共走了%@步", pedometerData.numberOfSteps];
        }];
    }];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
