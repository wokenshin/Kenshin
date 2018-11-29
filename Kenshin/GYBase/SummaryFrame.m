//
//  SummaryFrame.m
//  GYBase
//
//  Created by doit on 16/4/21.
//  Copyright © 2016年 kenshin. All rights reserved.
//


#import "SummaryFrame.h"
#import "SummaryModel.h"
#import "Tools.h"

@implementation SummaryFrame


//根据传入的模型 设置frame
- (void)setSummaryModel:(SummaryModel *)model
{
    _summaryModel = model;
    
    //title
    _titleF = CGRectMake(0, 0, screenWidth, height_normal);
    
    //img
    CGFloat imgY = CGRectGetMaxY(_titleF) + margin_10;
    _imgF = CGRectMake(margin_10, imgY, screenWidth - margin_10 *2, 230);
    
    //contents
    CGFloat contentsY = CGRectGetMaxY(_imgF) + margin_10;
    CGSize contentsSize = [Tools sizeOfTheText:self.summaryModel.contents font:contentsFont maxSize:CGSizeMake(300, MAXFLOAT)];
    _contentsF = CGRectMake(margin_10, contentsY, screenWidth - margin_10 * 2, contentsSize.height);
    
    //cellHeight
    _cellHeight = CGRectGetMaxY(_contentsF) + margin_10;
    
}

@end
