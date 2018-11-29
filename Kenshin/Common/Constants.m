//
//  Constants.m
//  GYBase
//
//  Created by doit on 16/4/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Constants.h"


//在.m文件中，为每个常量赋值
//当需要使用const修饰的常量时，引入本类即可类即可

@implementation Constants

int const kenshinHeight = 172;

NSString * const kenshinName = @"kenshin";

NSString * const defaultPic = @"defaultPic";

NSString * const headerPath_SetHeaderVC = @"/kenshin_header.png";
NSString * const headerPath_SLAMDUNK = @"/headerPath_SLAMDUNK.png";

//测试数据

/**
*APP中文名称
*/
NSString* const APP_NAME = @"母亲电商";//
/**
 *系统分配平台的值
 */
int const SYSTEM_PLATFORM_VALUE = 64;
/**
 * 接口版本
 */
int const SERVICE_VERSION = 2;

//系统名
NSString *const SYSTEMNAME = @"ios";

//从业人员请求模块
NSString *const HTTP_MODULE_STAFF = @"staff";
NSString *const HTTP_MODULE_APP = @"app";
NSString *const HTTP_MODULE_TASK = @"task";

//是否首次运行KEY
NSString* const  DATA_KEY_ISFIRSTRUN = @"isFirstRun";
NSString* const  DATA_KEY_TOKEN = @"token";
NSString* const  DATA_KEY_STAFF_PHONENO = @"staffPhoneNo";
NSString* const  DATA_KEY_STAFF_STATUS = @"staffStatus";

//位置经度
NSString* const  DATA_KEY_LOCATION_LON = @"lon";
//位置纬度
NSString* const  DATA_KEY_LOCATION_LAT = @"lat";
NSString* const  DATA_KEY_STAFF_STAR = @"staffStar";
NSString* const  DATA_KEY_STAFF_SERVICES = @"staffServices";
NSString* const  DATA_KEY_STAFF_REMARK = @"staffRemark";
NSString* const  DATA_KEY_STAFF_PICTURE = @"staffPicture";
NSString* const  DATA_KEY_LAST_ONLINE_TIME = @"lastOnlineTime";
NSString* const  DATA_KEY_ONLINE_DURATION = @"onlineDuration";


@end

/*
 对于const的使用，只要掌握一条原则即可，即：const用来修饰离其最近的变量。
 
 如下面的代码所示：
 
 当const修饰的是*x时，即指向字符串@”www.hcios.com”的指针指向是不能改变的，但是字符串的内容是可以改变的；
 当const修饰的是y时，即指向的字符串内容@”宏创学院”是不能改变的，但是指向的地址是可以改变的。
 void constString () {
 //const修饰的是指针变量*x
 NSString const *x = @"www.hcios.com";
 x = @"宏创学院";
 
 //const修饰的是字符串
 NSString * const y = @"宏创学院";
 不能修改
 y = @"www.hcios.com";
 

NSLog(@"x = %@",x);
NSLog(@"y = %@",y);

}
 */