//
//  SummaryCell.m
//  GYBase
//
//  Created by doit on 16/4/21.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SummaryCell.h"
#import "SummaryFrame.h"
#import "SummaryModel.h"

@interface SummaryCell()
/**
 *  标题
 */
@property (nonatomic, weak) UILabel     *titleLab;
/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *imgV;
/**
 *  内容
 */
@property (nonatomic, weak) UILabel     *contentsLab;

@end

@implementation SummaryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SummaryCell";
    SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[SummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        //标题
        UILabel *titLab = [UILabel new];
        titLab.font = titleFont;
        titLab.textColor = [UIColor blackColor];
        titLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titLab];
        self.titleLab = titLab;
        
        //图片
        UIImageView *tmpImgV = [UIImageView new];
        [self.contentView addSubview:tmpImgV];
        self.imgV = tmpImgV;
        
        //内容
        UILabel *conLab = [UILabel new];
        conLab.numberOfLines = 0;
        conLab.font = contentsFont;
        conLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:conLab];
        self.contentsLab = conLab;
        
    }
    return self;
    
}

//在用到 .语法 set值的时候 就会调用该函数
- (void)setModelFrame:(SummaryFrame *)modelFrame
{
    _modelFrame = modelFrame;
    
    //1设置数据
    [self settingData];
    
    //2设置frame
    [self settingFrame];
    
}

/**
 *  设置数据
 */
- (void)settingData
{
    //SD 数据
    SummaryModel *model = self.modelFrame.summaryModel;
    
    //标题
    self.titleLab.text = model.title;
    
    //图片
    self.imgV.image = [UIImage imageNamed:model.img];
    
    //正文
    self.contentsLab.text = model.contents;
    
}

/**
 *  设置frame
 */
- (void)settingFrame
{
    self.titleLab.frame    = self.modelFrame.titleF;
    self.imgV.frame        = self.modelFrame.imgF;
    self.contentsLab.frame = self.modelFrame.contentsF;
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

#pragma mark 重写选择事件，取消可被选中
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];
    
}

@end
