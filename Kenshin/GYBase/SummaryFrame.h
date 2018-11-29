//
//  SummaryFrame.h
//  GYBase
//
//  Created by doit on 16/4/21.
//  Copyright © 2016年 kenshin. All rights reserved.
//
#define titleFont [UIFont systemFontOfSize:16]
#define contentsFont [UIFont systemFontOfSize:14]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SummaryModel;

@interface SummaryFrame : NSObject


/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**
 *  title的frame
 */
@property (nonatomic, assign, readonly) CGRect titleF;
/**
 *  img的frame
 */
@property (nonatomic, assign, readonly) CGRect imgF;
/**
 *  contents的frame
 */
@property (nonatomic, assign, readonly) CGRect contentsF;
/**
 * SummaryModel
 */
@property (nonatomic, strong) SummaryModel *summaryModel;

@end
