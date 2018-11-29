//
//  CellCollectionFour.m
//  GYBase
//
//  Created by kenshin on 16/9/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CellCollectionFour.h"
#import "Tools.h"

@interface CellCollectionFour()

@property (nonatomic, strong) UILabel       *labTitle;

@end

@implementation CellCollectionFour


- (UILabel *)labTitle
{
    if (_labTitle == nil)
    {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor whiteColor];
        lab.backgroundColor = RGB2Color(148, 199, 111);
        lab.textAlignment = NSTextAlignmentCenter;//文本居中
        
        
        _labTitle = lab;
        
        [self.contentView addSubview:lab];
    }
    
    return _labTitle;
    
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.labTitle.text = title;
    self.labTitle.frame = self.bounds;
    
}

@end
