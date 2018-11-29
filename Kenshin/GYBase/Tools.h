//
//  Tools.h
//  BaseGY
//
//  Created by doit on 16/4/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//  有些功能很简单 单容易忘记 统一放在这里


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>//md5
#import "UIImage+ImageEffects.h"

#define AppDel    ((AppDelegate *)[UIApplication sharedApplication].delegate)

//获取手机屏幕的宽、高
#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height


//各个手机型号的尺寸
#define screenWith4    320
#define screenHeight4  480

#define screenWith5    320
#define screenHeight5  568

#define screenWith6    375
#define screenHeight6  667

#define screenWith6p   414
#define screenHeight6p 736

// View 坐标(x,y)和宽高(width,height)
#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define WIDTH(v)           (v).frame.size.width
#define HEIGHT(v)          (v).frame.size.height

#define MinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define MinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标

#define MidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define MidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度

//获取状态栏高度 貌似都是20
#define statusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define navBarHeight self.navigationController.navigationBar.frame.size.height

//字体颜色 为蓝色==帮助页面的背景色
#define colorBlue       [UIColor colorWithRed:84.0/255  green:173.0/255 blue:235.0/255 alpha:1.0]
#define colorMyButton   [UIColor colorWithRed:0.0/255   green:122.0/255 blue:255.0/255 alpha:1.0]//参照IOS默认的Alert按钮颜色
#define colorPageIn     [UIColor colorWithRed:27.0/255  green:73.0/255  blue:97.0/255  alpha:1.0]//深
#define colorPageCu     [UIColor colorWithRed:120.0/255 green:180.0/255 blue:215.0/255 alpha:1.0]//浅
#define colorTextBack   [UIColor colorWithRed:214.0/255 green:214.0/255 blue:214.0/255 alpha:1.0]//浅灰色
#define colorGray       [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1.0]//灰色
#define colorNavBar     [UIColor colorWithRed:64.0/255  green:51.0/255  blue:64.0/255  alpha:1.0]//紫色
#define colorGreenLogin [UIColor colorWithRed:66.0/255  green:210.0/255 blue:83.0/255  alpha:1.0]//绿色

//全部按钮的背景
#define imgBtnHighlighted [UIImage imageNamed:@"buddy_header_bg_highlighted"]

//UI的圆角
#define YUANJIAO  8

//margin
#define margin_5  5
#define margin_10 10

//normalHeight
#define height_normal 44

//normalSize
#define size_normal 44

//开关 字体大小
#define switchFontSize [UIFont systemFontOfSize:14]

#define FontK(i) ([UIFont systemFontOfSize:i])

//母亲电商 字体大小


#define Font4      [UIFont fontWithName:@"Helvetica" size:11]
#define Font5      [UIFont fontWithName:@"Helvetica" size:12]
#define Font5h     [UIFont fontWithName:@"Helvetica" size:13]
#define Font6      [UIFont fontWithName:@"Helvetica" size:15]
#define Font6i     [UIFont fontWithName:@"Helvetica" size:14]
#define Font7      [UIFont fontWithName:@"Helvetica" size:16]

#define Font8      [UIFont fontWithName:@"Helvetica" size:17]

#define FontSearch [UIFont fontWithName:@"Helvetica" size:14]

#define Font6Bold  [UIFont fontWithName:@"Helvetica-Bold" size:16]

//支付页面的字体大小
#define FontPay [UIFont systemFontOfSize:14]

//weakSelf 定义一个self的弱引用  等同于 __weak LoginVC *weakSelf = self;
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//RBG转化为UIColor
#define RGB2Color(r,g,b) ([UIColor colorWithRed:(r * 1.0 /255) green:g * 1.0/255 blue:b * 1.0/255 alpha:1.0])
#define RGBA2Color(r,g,b,a) ([UIColor colorWithRed:(r * 1.0 /255) green:g * 1.0/255 blue:b * 1.0/255 alpha:a])

#define backgroundColor_VC RGB2Color(246, 246, 246)

//母亲电商 主色 红
#define colorRedHome RGB2Color(254, 92, 91)//2016-06-20 from zl
#define colorBlueHome RGB2Color(87, 174, 228)
#define colorGrayHome RGB2Color(164, 164, 164)
#define colorBlackHome RGB2Color(0, 0, 0) // 70 70 70
#define colorHeadBorder RGB2Color(219, 219, 219)
#define colorGraySearch RGB2Color(250, 250, 250)
#define colorCellLine       RGB2Color(240, 240, 240)
#define colorCeeLineB           RGB2Color(230, 230, 230)

//收入界面 饼图颜色
#define colorRedSCPie RGB2Color(254, 92, 91)//红
#define colorYellowSCPie RGB2Color(251, 176,59)//黄
#define colorBlueSCPie RGB2Color(67, 159, 230)//蓝



//设备名称
#define DeviceName ([UIDevice currentDevice].name)
//系统版本
#define SystemVersion ([UIDevice currentDevice].systemVersion)
//系统名称
#define SystemName ([UIDevice currentDevice].systemName)

@interface Tools : UIView


/**
 单例 demoCodes

 @return 返回单例对象
 */
+ (Tools *)shareTools;

//输出提示
+ (void)NSLogMyFunction:(NSString *)content;

//输出当前释放类 类名
+ (void)NSLogClassDestroy:(id)cuSelf;

//设置UI圆角
+ (void)setCornerRadiusWithView:(UIView *)view andAngle:(CGFloat)angle;

//设置边框
+ (void)setBorder:(UIView *)view andColor:(UIColor *)backColor andWidth:(CGFloat)width;

//显示吐司
+ (void)toast:(NSString *)content andCuView:(UIView *)cuView;

//多行文本 demoCode
+ (UILabel *)manyLineLab:(NSString *)contents andTextFount:(UIFont *)font;

//错误提示[和吐司一样 只是多张图片]//暂时没实现 其实很简单
+ (void)toastImage:(NSString *)content andImgName:(NSString *)imgName andCuView:(UIView *)cuView;

//吐司 带高度
+ (void)toast:(NSString *)content andCuView:(UIView *)cuView andHeight:(CGFloat)height;

//弹出框
+ (void)alertDemoCode;

+ (void)TipsAlertWithTitle:(NSString *)title andContent:(NSString *)content andCu:(id)ws;

//注册远程推送
+ (void)registerRemoteNotification;

//本地通知 demo
+ (void)localNotice;

//监测网络状况 AFN
+ (void)checkNetStatus;//建议将监听网络的行为 在AppDelegate 中执行

//监测权限
/*
 是否开启定位
 是否开启远程通知
 是否开启相册访问
 是否开启相机
 是否开启运动与健康
 是否开启麦克风
 是否玛德太多了。。。。
 */

//是否开启远程通知
+ (BOOL)fxwIsOpenAPNS;

//是否开启相机
+ (BOOL)fxwIsOpenCamera;

//是否开启运动与健康[这个地方可能不需要单独判断]
+ (BOOL)fxwIsOpenHealthData;

//是否开启麦克风
+ (BOOL)fxwIsOpenMicrophone;


//简单动画[位移 渐变 旋转]
+ (void)animationDemoCode;

//旋转ui
+ (void)transformWithView:(UIView *)view andWithDegrees:(CGFloat)degrees;

//设备功能[禁止休眠, 靠近听筒休眠, 震动]
+ (void)deviceFunctionOfBalaBala;

//隐藏软键盘 demoCodes
+ (void)hiddenKeyboard;

//限制文本输入类型 demoCodes
+ (void)setTextFieldInputType;
/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸 注意此参数的用法 不然会影响返回值的大小
 */
//获取文本的size
+ (CGSize)sizeOfTheText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

//获取文本的宽度
+ (CGFloat) widthWithTheText:(NSString *)text andFont:(UIFont *)font;

//定时器
+ (void)nstimerDemoCode;

#pragma mark - table
//默认选中某行cell 并滚动到该行
+(void)selectedCellWith:(UITableView *) table andIndex:(NSInteger)index andSection:(NSInteger)section;

//隐藏／显示 table滚动条
+ (void)setTableViewScrollBarVisible:(UITableView *)table scrollBarVisible:(BOOL)visible;

//隐藏tableview 分割线
+ (void)hiddenTableViewCellSeparateLine:(UITableView *)table;

//局部刷新 cell  或 分区
+ (void)juBuRefreshCellOrSectionDemoCodes;

#pragma mark - 导航控制器
//设置导航条样式
+ (void)setNavigationBarBackgroundColor:(UIColor *)backColor andTextColor:(UIColor *)textColor;

//添加导航栏按钮 demoCodes
+ (void)addNavigationBarButton;

//是否隐藏导航条
//+ (void)setNavgationBarHiddenDemoCodes;


#pragma mark - UIImageView

//毛玻璃效果
//+ (UIImage *)maoBoLiBackImage:(NSString *)imageName;

//毛玻璃效果
+ (UIImage *)maoBoLiBackWithImage:(UIImage *)image;

//裁剪图片
+ (UIImage *)cutImageWithSize:(CGSize)size originalImage:(UIImage *)originalImage;

//获取属性列表中的数据
+ (NSArray *)plistArrayTypeWithName:(NSString *)plistName;
+ (NSDictionary *)plistDicTypeWithName:(NSString *)plistName;

+ (NSString *)filePathWithDocuments:(NSString *)fileName;

//为视图添加手势 demoCodes
+ (void)setTapAction:(UIView *)tapView;

//获取随机数的代码
+ (void)randomNumDomoCodes;

#pragma mark - UIApplocation
//打电话
+ (void)tellPhoneWith:(NSString *)phoneNun;

//发短信
+ (void)sendMessageWith:(NSString *)contents;

//发邮件
+ (void)sendEmailWith:(NSString *)emailAddress;

//打开网页
+ (void)openSafariWith:(NSString *)url;

//设置听筒模式
+ (void)setTingTongMode;

//设置扬声器模式
+ (void)setYangShengQiMode;

//设置 状态栏 是否可见
+ (void)setStaturBarHidden:(BOOL)hidden andIsAnimation:(BOOL)animation;

#pragma mark - 加密
//md5 加密
+ (NSString *)md5:(NSString *)content;

#pragma mark 获取缓存大小 demoCodes
+ (CGFloat)cachesSizeDemoCodes;

#pragma mark 清空缓存 demoCodes
+ (void)clearCachesDemoCodes;

#pragma mark 设置app通知数
+ (void)setAppNoticeNum:(NSInteger) noticesNum;

#pragma mark 清空app通知数
+ (void)clearAppNoticeNum;



#pragma mark - MC 项目中的方法
#pragma mark 加载头像 返回UIImage
+ (UIImage *)loadHeadImage;

//返回虚线view
/** 注意 view的高度就是虚线的高度
 
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	   虚线的宽度
 ** lineSpacing:   虚线的间距
 ** lineColor:	   虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 *讲json字符串转成字典
 */
+ (NSDictionary *)JsonStringToDictionaryWith:(NSString *)jsonString;

//自定义push
+ (void)pushCuVC:(UINavigationController *)cuNav toNextVC:(UIViewController *)nextVC andCuNetState:(BOOL)state;

//判断字符串是否为纯数字
//判断字符串是否是纯数字
+ (BOOL)isPureInt:(NSString *)string;
@end
