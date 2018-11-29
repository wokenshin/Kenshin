//
//  CellTest.m
//  MSelectedTable
//
//  Created by 刘万兵 on 17/1/9.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "CellTest.h"

@implementation CellTest

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NSString *)model
{
    _model = model;
    if ([model isEqualToString:@"YES"])
    {
        [_btn setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
    }
    else
    {
        [_btn setImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
    }
    
}

- (void)setLineNum:(NSString *)lineNum
{
    _lineNum = lineNum;
    if (lineNum != nil)
    {
        _lab.text = lineNum;
    }
    
}

- (IBAction)selecteAction:(UIButton *)sender
{
    if (_clickButtonBlock)
    {
        _clickButtonBlock(sender);
    }
    
    if ([_model isEqualToString:@"NO"])
    {
        [_btn setImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
    }
    else
    {
        [_btn setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
    }
}


@end
