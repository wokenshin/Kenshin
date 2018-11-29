//
//  SingleInstancek.m
//  GYBase
//
//  Created by kenshin on 16/8/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SingleInstancek.h"

@implementation SingleInstancek

static SingleInstancek *_instance;

//[保证永远只分配一次内存 永远只有同一个实例]

//当初始化对象的时候 也就是调用 init的时候 底层会调用下面的方法，所以我们这里通过重写这个方法来实现单例
+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
//    @synchronized (self) {
//        if (_instance == nil) {
//            _instance = [super allocWithZone:zone];
//        }
//    }
    
    //上面注释掉的代码  完全等同于下面 下面的GCD的代码也是线程安全的 不需要加锁
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
    
}

+ (instancetype)shareSingleInstancek
{
    return [[self alloc] init];
    
}

//下面的两个对象方法是在使用拷贝的时候获取实例， 为了更加严谨 我们也重写了下面的方法
- (instancetype)copyWithZone:(NSZone *)zone
{
    //因为本方法是对象方法，所以在被调用的时候 说明已经被初始化过了，即_instance！= nil
    return _instance;
    
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
    
}
@end
