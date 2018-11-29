//
//  KImageData.h
//  GYBase
//
//  Created by doit on 16/6/2.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KImageData : NSObject

#pragma mark 索引
@property (nonatomic, assign) int index;

#pragma mark 图片数据
@property (nonatomic, strong) NSData *data;

@end
