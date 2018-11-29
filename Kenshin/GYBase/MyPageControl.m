//
//  MyPageControl.m
//  GYBase
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 kenshin. All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl

//重写setCurrentPage方法，可设置圆点大小
- (void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 10;
        size.width  = 10;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}
@end
