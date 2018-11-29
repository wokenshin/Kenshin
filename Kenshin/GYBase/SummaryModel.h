//
//  SummaryModel.h
//  GYBase
//
//  Created by doit on 16/4/21.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummaryModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *contents;

- (instancetype)initSummaryModel:(NSDictionary *)dic;
+ (instancetype)summaryModel:(NSDictionary *)dic;
@end
