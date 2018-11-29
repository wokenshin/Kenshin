//
//  Constants.h
//  GYBase
//
//  Created by doit on 16/4/11.
//凡是涉及到常量的定义都建议用const，并且所有使用const修饰的常量都统一放在一个类中，其他的都可以使用宏来定义。
//
//  const 相当于java中的 final 通常用来定义字符串常量

#import <Foundation/Foundation.h>

@interface Constants : NSObject

//在.h文件中，声明所有的常量，需要注意一点：每个常量前面都加上extern关键字，否则在编译时会报声明重复错误。

/**高度*/
extern int const kenshinHeight;

/**启动成功通知*/
extern NSString * const kenshinName;

extern NSString * const defaultPic;

/**设置头像页面 头像路径名**/
extern NSString *const headerPath_SetHeaderVC;
extern NSString *const headerPath_SLAMDUNK;

//测试数据
/**
 *APP名称
 */
extern NSString* const APP_NAME;
/**
 *平台值
 */
extern int const SYSTEM_PLATFORM_VALUE;
/**
 * 接口版本
 */
extern int const SERVICE_VERSION;
//系统名称
extern NSString *const SYSTEMNAME;

//HTTP请求模块
/**
 * 从业人员模块
 */
extern NSString *const HTTP_MODULE_STAFF;
/**
 * 公告模块
 */
extern NSString *const HTTP_MODULE_APP;
/**
 * 任务模块
 */
extern NSString *const HTTP_MODULE_TASK;


//CONST_KEY
extern NSString* const  DATA_KEY_ISFIRSTRUN;
/**
 * token
 */
extern NSString* const DATA_KEY_TOKEN;
/*
 *从业人员手机号KEY
 */
extern NSString* const  DATA_KEY_STAFF_PHONENO;
/**
 *从业人员状态KEY
 */
extern NSString* const DATA_KEY_STAFF_STATUS;

/**
 *位置经度
 */
extern NSString* const  DATA_KEY_LOCATION_LON;
/**
 *位置纬度
 */
extern NSString* const  DATA_KEY_LOCATION_LAT;
/**
 *从业人员星级
 */
extern NSString* const  DATA_KEY_STAFF_STAR;
/**
 *从业人员服务属性
 */
extern NSString* const  DATA_KEY_STAFF_SERVICES;
/**
 *从业人员签名
 */
extern NSString* const  DATA_KEY_STAFF_REMARK;
/**
 *从业人员头像URL
 */
extern NSString* const  DATA_KEY_STAFF_PICTURE;
/**
 *从业人员最新在线时间KEY
 */
extern NSString* const  DATA_KEY_LAST_ONLINE_TIME;
/**
 * 从业人员在线时长KEY
 */
extern NSString* const  DATA_KEY_ONLINE_DURATION;


//使用到的Cell Identifier 常量定义
extern NSString* const TableViewCellIdentifier;

@end
