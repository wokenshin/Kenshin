//
//  DataVC.m
//  GYBase
//
//  Created by doit on 16/5/23.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    复习的时候 可以打开模拟器的路径进行观察文件的变化
 
    数据的持久话存储方式：
 
    xml属性列表plist 归档［保存字典，数组，字典和数组中只能保存原生对象 不能保存自定义对象］
    Preference(偏好设置)
    NSKeyedArchiver 归档/解档［保存任何对象］ (被保存的对象的类 需要实现 NSCoding 协议中的两个方法)
 
    SQLite3    ［用于项目］
    Core Data  [用于即时通讯]
 
     Documents:中从存储文件时，有可能被IOS 拒绝发布。但不一定，所以现在很少在里面存储东西了。
     主要存储在Caches中。
 */

#import "DataVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "View+MASAdditions.h"
#import "PersonData.h"

@interface DataVC ()

@end

@implementation DataVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataVCUI];
    [Tools toast:@"看控制台" andCuView:self.view andHeight:330];
    
}

- (void)initDataVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"数据存储";
    
    WS(ws);
    
    //plist 今后开发 数据主要保存在 Caches文件夹中
    UIButtonK *btnSavePlist = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 100, 44)];
    [btnSavePlist setTitle:@"plist存" forState:UIControlStateNormal];
    [btnSavePlist setBackgroundNormalColor:RGB2Color(124, 124, 124)];
    [btnSavePlist setBackgroundHeightlightColor:RGB2Color(206, 206, 206)];
    btnSavePlist.clickButtonBlock = ^(UIButtonK *btn){
        [ws savePlistToCaches];
        
    };
    
    UIButtonK *btnReadPlist = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*2 + 100, 64 + margin_10, 100, 44)];
    [btnReadPlist setTitle:@"plist取" forState:UIControlStateNormal];
    [btnReadPlist setBackgroundNormalColor:RGB2Color(124, 124, 124)];
    [btnReadPlist setBackgroundHeightlightColor:RGB2Color(206, 206, 206)];
    btnReadPlist.clickButtonBlock = ^(UIButtonK *btn){
        [ws readPlistFromCaches];
        
    };
    
    //偏好设置 其实就是保存的一个字典，这个字典保存在了Preference文件夹下限
    UIButtonK *btnSavePre = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + 44 + margin_10*2, 100, 44)];
    [btnSavePre setTitle:@"偏好设置存" forState:UIControlStateNormal];
    [btnSavePre setBackgroundNormalColor:RGB2Color(124, 124, 124)];
    [btnSavePre setBackgroundHeightlightColor:RGB2Color(206, 206, 206)];
    btnSavePre.clickButtonBlock = ^(UIButtonK *btn){
        [ws savePreference];
        
    };
    
    UIButtonK *btnReadPre = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*2 + 100, 64 + 44 + margin_10*2, 100, 44)];
    [btnReadPre setTitle:@"偏好设置取" forState:UIControlStateNormal];
    [btnReadPre setBackgroundNormalColor:RGB2Color(124, 124, 124)];
    [btnReadPre setBackgroundHeightlightColor:RGB2Color(206, 206, 206)];
    btnReadPre.clickButtonBlock = ^(UIButtonK *btn){
        [ws readPreference];
        
    };
    
    //归档
    UIButtonK *btnArchiver = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + 44*2 + margin_10*3, 100, 44)];
    [btnArchiver setTitle:@"归档存" forState:UIControlStateNormal];
    [btnArchiver setBackgroundNormalColor:RGB2Color(124, 124, 124)];
    [btnArchiver setBackgroundHeightlightColor:RGB2Color(206, 206, 206)];
    btnArchiver.clickButtonBlock = ^(UIButtonK *btn){
        [ws archiver];
        
    };
    
    UIButtonK *btnUnArchiver = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10*2 + 100, 64 + 44*2 + margin_10*3, 100, 44)];
    [btnUnArchiver setTitle:@"解档存" forState:UIControlStateNormal];
    [btnUnArchiver setBackgroundNormalColor:RGB2Color(124, 124, 124)];
    [btnUnArchiver setBackgroundHeightlightColor:RGB2Color(206, 206, 206)];
    btnUnArchiver.clickButtonBlock = ^(UIButtonK *btn){
        [ws unArchiver];
        
    };
    
    
    //图片说明
    /*
     Layer 是一个压缩包
     Documents 不建议保存数据在里面 ［审核可能被拒绝］
     Caches 建议将 持久化数据保存在 缓存中
     Preferences 偏好设置  保存 NSUserDefaults 存储的键值对 会在这个文件夹下生成一个 字典
     */
    UIImageView *shuomingView = [UIImageView new];
    UIImage *logoImg = [UIImage imageNamed:@"appSandbox"];
    shuomingView.image = logoImg;
    [self.view addSubview:shuomingView];
    [shuomingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@300);
        
        
    }];
    logoImg = nil;
    
    [self.view addSubview:btnSavePlist];
    [self.view addSubview:btnReadPlist];
    [self.view addSubview:btnSavePre];
    [self.view addSubview:btnReadPre];
    [self.view addSubview:btnArchiver];
    [self.view addSubview:btnUnArchiver];
    
}

//存储 文件到 缓存
- (void)savePlistToCaches
{
    //plist中只能存储 字典和数组， 需要注意的是， 数组中不能存储自定义的类的对象， 不然将无法保存属性列表到应用沙盒中,但是程序并不会报错
    NSArray *arr = @[@"123123", @1];
    
    //File 文件的全路径
    //获取应用沙盒路径
//    NSString *homePath = NSHomeDirectory();
//    NSLog(@"%@", homePath);
    
    //获取Caches文件夹路径
    //<#NSSearchPathDirectory directory#>:搜索文件夹
    //<#NSSearchPathDirectory directory#>:在那个范围内搜索
    //<#BOOL expandTilde#>:是否显示全路径
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //拼接文件名
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"arr.plist"];
    [arr writeToFile:filePath atomically:YES];
    
}

//读取 文件 从 缓存
- (void)readPlistFromCaches
{
    //获取应用沙盒中 Caches文件夹的全路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //拼接文件名
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"arr.plist"];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@", arr);
    
}

- (void)savePreference
{
    //偏好设置存储 NSUserDefault
    //什么时候使用 偏好设置存储，优点：快速进行键值对的存储
    
    //获取NSUserDefault的单例对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存键值对
    [defaults setObject:@"kenshin" forKey:@"name"];
    [defaults setBool:YES forKey:@"isBoy"];
    
}

- (void)readPreference
{
    //获取NSUserDefault的单例对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name"];
    BOOL isBoy = [defaults boolForKey:@"isBoy"];
    
    NSLog(@"读取 偏好设置：%@, %d", name, isBoy);
}

//归档
- (void)archiver
{
    NSMutableArray *testArr = [[NSMutableArray alloc] init];
    [testArr addObject:@"123"];
    [testArr addObject:@"321"];
    [testArr addObject:@"132"];
    
    PersonData *per = [PersonData new];
    per.name = @"kenshin";
    per.age  = 26;
    per.mArray = testArr;
    //获取保存文件的路径
    NSString *savePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //拼接全路径文件名
    NSString *filePath = [savePath stringByAppendingPathComponent:@"PersonData"];
    
    [NSKeyedArchiver archiveRootObject:per toFile:filePath];
    
}

//解档
- (void)unArchiver
{
    //获取保存文件的路径
    NSString *savePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //拼接全路径文件名
    NSString *filePath = [savePath stringByAppendingPathComponent:@"PersonData"];
    
    PersonData *per = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (per != nil)
    {
        NSLog(@"%@, %ld", per.name, per.age);
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
