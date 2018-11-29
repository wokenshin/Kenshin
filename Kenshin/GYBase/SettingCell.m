//
//  SettingCell.m
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SettingCell.h"
#import "Tools.h"
#import "SettingCellModel.h"

@interface SettingCell()

@property (nonatomic, strong)UILabel        *title;
@property (nonatomic, strong)UIImageView    *arrowRight;
@property (nonatomic, strong)UILabel        *tellPhone;//当有电话号码的时候不显示 arrowRight

@end

@implementation SettingCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
        
    }
    return self;
}

//初始化设置
- (void)setUp
{
    CGFloat heightCell = 45;
    CGFloat sizeArrow  = heightCell/3;
    
    //标题
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(margin_10, 0, 150, heightCell)];
    self.title.textColor = RGB2Color(80, 88, 92);
    self.title.font = [UIFont systemFontOfSize:15];
    
    //箭头图片 或者 电话号码
    self.arrowRight = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth - sizeArrow - 10, sizeArrow, sizeArrow, sizeArrow)];
    self.arrowRight.image = [UIImage imageNamed:@"arrowRight"];
    
    self.tellPhone = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, screenWidth-200, heightCell)];
    self.tellPhone.textColor = RGB2Color(80, 88, 92);
    self.tellPhone.font = [UIFont systemFontOfSize:15];
    
    //分割线
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(margin_10, 44.5, screenWidth - margin_10, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self.title];
    [self addSubview:self.tellPhone];
    [self addSubview:self.arrowRight];
    [self addSubview:line];
    
}

//在绘制cell的时候 cell.model = dataArr[row];的时候就会调用下面的方法
- (void)setModel:(SettingCellModel *)model
{
    _model = model;
//    self.title.hidden     = YES;
//    self.tellPhone.hidden = YES;
    
    if (![model.title isEqualToString:@""])
    {
        self.title.text   = model.title;
//        self.title.hidden = NO;
    }
    if (![model.tellPhone isEqualToString:@""])
    {
        self.tellPhone.text   = model.tellPhone;
//        self.tellPhone.hidden = NO;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.title      = nil;
    self.arrowRight = nil;
    self.tellPhone  = nil;
    
}
@end
