//
//  CharacterCell.m
//  GYBase
//
//  Created by doit on 16/4/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#define fontKenshin [UIFont systemFontOfSize:14]

#import "CharacterCell.h"
#import "CharacterModel.h"
#import "Tools.h"

@interface CharacterCell()

@property (nonatomic, weak) UIImageView *headerImgV;
@property (nonatomic, weak) UILabel     *nameLab;
@property (nonatomic, weak) UILabel     *titleLab;

@end

@implementation CharacterCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CharacterCell";
    CharacterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[CharacterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;

}

/**
*  构造方法(在初始化对象的时候会调用)
*  一般在这个方法中添加需要显示的子控件
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat sizeHeader = 80;
        CGFloat margin = 10;
        CGFloat heightLab = sizeHeader/2;
        //头像
        UIImageView *headV = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, sizeHeader, sizeHeader)];
        [Tools setCornerRadiusWithView:headV andAngle:10];
        [self.contentView addSubview:headV];
        self.headerImgV = headV;
        
        //姓名
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(margin*2 + sizeHeader, margin, screenWidth - sizeHeader - margin*2, heightLab)];
        name.font = fontKenshin;
        name.textColor = [UIColor blackColor];
        [self.contentView addSubview:name];
        self.nameLab = name;
        
        //标题
        UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(margin*2 + sizeHeader, margin + heightLab, screenWidth - sizeHeader - margin*2, heightLab)];
        titLab.font = fontKenshin;
        titLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:titLab];
        self.titleLab = titLab;
        
        //尖头
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth - 10 - 20, 40, 20, 20)];
        arrow.image = [UIImage imageNamed:@"arrowRight"];
        [self.contentView addSubview:arrow];
        
    }
    return self;
    
}

- (void)setModelCharacter:(CharacterModel *)model
{
    _modelCharacter = model;
    
    [self settingData];
    [self settingFrame];
}

- (void)settingData
{
    CharacterModel *model = self.modelCharacter;
    //头像
    self.headerImgV.image = [UIImage imageNamed:model.headerImg];
    
    //姓名
    self.nameLab.text = model.name;
    
    //标题
    self.titleLab.text = model.title;
    
}

- (void)settingFrame
{
    //在初始化函数中处理 因为是固定的
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
