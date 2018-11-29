//
//  NSString+Trim.h
//  GYBase
//
//  Created by doit on 16/5/25.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    创建分类的时候 选择的是 Objective-C File 
    
    分类的定义是通过在原有类名后加上”(分类名)”来定义的（注意声明文件.h和实现文件.m都是如此）
 
       当我们不改变原有代码为一个类扩展其他功能时我们可以考虑继承这个类进行实现，但是这样一来使用时就必须定义成新实现的子类才能拥有扩展的新功能。
    如何在不改变原有类的情况下扩展新功能又可以在使用时不必定义新类型呢？我们知道如果在C#中可以使用扩展方法，其实在ObjC中也有类似的实现，
    就是分类Category。利用分类，我们就可以在ObjC中动态的为已有类添加新的行为（特别是系统或框架中的类）。
    在C#中字符串有一个Trim()方法用于去掉字符串前后的空格，使用起来特别方便，但是在ObjC中却没有这个方法，
    这里我们不妨通过Category给NSString添加一个stringByTrim()方法：
 
 */

#import <Foundation/Foundation.h>

@interface NSString (Trim)

-(NSString *)stringByTrim;//修剪字符串， 将字符串中 前后的空格剪掉

@end
