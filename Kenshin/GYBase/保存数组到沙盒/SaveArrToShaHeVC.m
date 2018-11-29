//
//  SaveArrToShaHeVC.m
//  GYBase
//
//  Created by 刘万兵 on 16/12/5.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SaveArrToShaHeVC.h"

@interface SaveArrToShaHeVC ()

@end

@implementation SaveArrToShaHeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//注意 在使用真机的时候 下面的路径 换成 cachesPath 的路径才有效 不知道为什么 亲测
- (IBAction)saveArrToShaHeAction:(id)sender {
    
    [self saveUserMkeyToArrayWithUserId:@"userId" andBlueeToothAddress:@"address2"];
    [self removeMkeyWithUserId:@"userId" andBlAddress:@"address2"];
}

- (IBAction)readArrFromShaHeAction:(id)sender {
    
    NSString *homeDictionary = NSHomeDirectory();//获取根目录
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"remoteKeys.archiver"];
    NSMutableArray *test = [NSKeyedUnarchiver unarchiveObjectWithFile:homePath];
    NSLog(@"asd");
}

- (void)saveUserMkeyToArrayWithUserId:(NSString *)userId andBlueeToothAddress:(NSString *)blAddress
{
    if (userId == nil || blAddress == nil) {
        return;
    }
    
    NSMutableDictionary *dicMkey = [[NSMutableDictionary alloc] init];
    [dicMkey setValue:blAddress forKey:userId];
    
    //先解档查看是否有数据
    NSString *homeDictionary = NSHomeDirectory();//获取根目录
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"remoteKeys.archiver"];
    NSMutableArray *remoteKeys = [NSKeyedUnarchiver unarchiveObjectWithFile:homePath];
    if (remoteKeys == nil) {
        remoteKeys = [NSMutableArray array];
        if (remoteKeys != nil && [remoteKeys count] == 0)//第一次归档时调用
        {
            [remoteKeys addObject:dicMkey];
        }
    }
    
    if (remoteKeys != nil && [remoteKeys count] > 0)
    {
        //1.判断userId是否已经存在 不存在就保存
        //2.如果userId存在 判断blAdress 是否和保存的不相等 不相等就保存[一个管理员分配给同一个用户多把钥匙时的情况userId有一个 蓝牙地址有多个]
        NSInteger len = [remoteKeys count];
        for (int i = 0; i < len; i++)
        {
            NSDictionary *ditMkeyTmp = [remoteKeys objectAtIndex:i];
            if (ditMkeyTmp != nil)
            {
                NSString *blAddressTmp = [ditMkeyTmp objectForKey:userId];
                if (blAddressTmp == nil)//1.判断userId是否已经存在 不存在就保存
                {
                    [remoteKeys addObject:dicMkey];
                }
                if (blAddressTmp != nil)//2.如果userId存在 判断blAdress 是否和保存的不相等 不相等就保存
                {
                    if (![blAddressTmp isEqualToString:blAddress])
                    {
                        [remoteKeys addObject:dicMkey];
                    }
                    else
                    {
                        return;//其他情况都不需要归档
                    }
                }
            }
        }
    }
    
    if ([NSKeyedArchiver archiveRootObject:remoteKeys toFile:homePath])
    {
        NSLog(@"归档成功!");
    }
}

- (void)removeMkeyWithUserId:(NSString *)userId andBlAddress:(NSString *)blAddress
{
    if (userId == nil || blAddress == nil) {
        return;
    }
    
    //遍历数组 找出对应数据删除后在归档
    NSString *homeDictionary = NSHomeDirectory();//获取根目录
    NSString *homePath  = [homeDictionary stringByAppendingPathComponent:@"remoteKeys.archiver"];
    NSMutableArray *remoteKeys = [NSKeyedUnarchiver unarchiveObjectWithFile:homePath];
    
    if (remoteKeys != nil)
    {
        NSInteger len = [remoteKeys count];
        for (int i = 0; i < len; i++)
        {
            NSDictionary *dicMkey = [remoteKeys objectAtIndex:i];
            NSString *blAddressTmp = [dicMkey objectForKey:userId];
            if (blAddressTmp != nil && [blAddress isEqualToString:blAddressTmp])//蓝牙地址 和userId都相等
            {
                [remoteKeys removeObjectAtIndex:i];
            }
        }
    }
    if ([NSKeyedArchiver archiveRootObject:remoteKeys toFile:homePath])
    {
        NSLog(@"归档成功!");
    }
    
}

@end
