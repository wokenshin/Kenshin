//
//  Enums.h
//  GYBase
//
//  Created by doit on 16/4/15.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>//枚举类


typedef NS_ENUM(NSInteger, TestType)
{
    
    TestTypeOne = 1,

    TestTypeTwo = 2,

    TestTypeThree = 3
    
};

/**
 *用户状态
 */
typedef NS_ENUM(NSInteger, UserStatus)//下面定义枚举的方式是用的位移运算 这种个人觉得不太直观 可以直接用 = 来赋值即可
{
    /**
     *用户：正在睡觉
     */
    UserStatusSleeping      = 0,
    
    /**
     *用户：正在工作
     */
    UserStatusWorking       = 1 << 0,//2的零次方    1
    
    /**
     *用户：正在谈话
     */
    UserStatusTalking       = 1 << 1,//2的1次方     2
    
    /**
     *用户：正在笑
     */
    UserStatusSmiling       = 1 << 2,//2的N次方     4
    
    /**
     *用户：正在哭
     */
    UserStatusCrying        = 1 << 3,
    
    /**
     *用户：正在做梦
     */
    UserStatusDreaming      = 1 << 4
    
};

/**
 *用户状态
 */
typedef NS_ENUM(NSInteger, KenshinStatus)//直接用 = 来赋值
{
    /**
     *用户：正在睡觉
     */
    KenshinStatusSleeping       = 0,
    
    /**
     *用户：正在工作
     */
    KenshinWorking              = 1 ,
    
    /**
     *用户：正在谈话
     */
    KenshinTalking              = 2,
    
    /**
     *用户：正在笑
     */
    KenshinSmiling              = 4,
    
    /**
     *用户：正在哭
     */
    KenshinCrying               = 8,
    
    /**
     *用户：正在做梦
     */
    KenshinDreaming             = 16
    
};

typedef NS_ENUM(NSInteger, TomaStatus)//默认从0开始，后面的枚举值默认一次+1
{
    TomaStatusSleeping,
    TomaStatusWorking,
    TomaStatusTalking

};


















