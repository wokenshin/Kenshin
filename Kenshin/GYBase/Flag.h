//
//  Flag.h
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Flag : NSObject//国旗模型

//这里的模型的定义 是根据 flags.plist 来定义的


//以后字符串通常都用strong来修时 目的是 当外面对其修改的时候，自身也会被修改。这是当前普遍的需求
//以前是用        copy来修饰   目的是 当外面对其修改的时候，自身并不会被修改。现在这样的需求已经很少了
@property (nonatomic, strong)NSString  *name;

//@property (nonatomic, strong)NSString  *icon;
@property (nonatomic, strong)UIImage   *icon;

//定义类方法用于快速创建对象
+ (instancetype)flagWithDict:(NSDictionary *)dict;
@end
