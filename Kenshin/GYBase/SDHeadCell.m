//
//  SDHeadCell.m
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SDHeadCell.h"
#import "Tools.h"
#import "Constants.h"
#import "NSUserDefaultTools.h"

@interface SDHeadCell()

@property (nonatomic, strong)UIControl      *headerCtrl;
@property (nonatomic, strong)UIImageView    *headerImg;
@property (nonatomic, strong)UIImageView    *backView;
@property (nonatomic, strong)UILabel        *nameLab;

@end

@implementation SDHeadCell

//只要从xib或者sb加载 就会调用这个方法，只会调用一次
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
    
}

//通过代码 初始化时 回调用这个方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
    }
    return self;
    
}

- (void)setUp
{
    //设置头像
    CGFloat headerSize = 120;
    CGFloat headerBorderSize = headerSize + 4;
    self.headerCtrl = [[UIControl alloc]
                       initWithFrame:CGRectMake(screenWidth/2 - headerSize/2, margin_5*4, headerSize, headerSize)];
    //头像外边框
    UILabel *headerBorder = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - headerBorderSize/2, margin_5*4-2, headerBorderSize, headerBorderSize)];
    headerBorder.backgroundColor = RGB2Color(233, 206, 189);
    headerBorder.alpha = 0.6;
    //点击事件
    [self.headerCtrl addTarget:self action:@selector(pressHeaderAction) forControlEvents:UIControlEventTouchUpInside];
    
    //圆角
    [Tools setCornerRadiusWithView:self.headerCtrl andAngle:headerSize/2];
    [Tools setCornerRadiusWithView:headerBorder andAngle:headerBorderSize/2];
    self.headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerSize, headerSize)];
    [self.headerCtrl addSubview:self.headerImg];
    
    //设置背景
    self.backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 210)];
//    [Tools setMaoBoliStyleWithImageView:self.backView];//毛玻璃效果
    
    //姓名
    CGFloat nameWidth  = 120;
    CGFloat nameHeight = 30;
    CGFloat yName      = CGRectGetMaxY(self.headerCtrl.frame);
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - nameWidth/2, yName + margin_10, nameWidth, nameHeight)];
    self.nameLab.backgroundColor = colorGray;
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.alpha = 0.6;
    self.nameLab.text = [NSUserDefaultTools getSettingName];
    [Tools setCornerRadiusWithView:self.nameLab andAngle:nameHeight/2];
    
    
    //分割线
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 209.5, screenWidth, 0.5)];
    lineLab.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:self.backView];
    [self addSubview:headerBorder];
    [self addSubview:self.headerCtrl];
    [self addSubview:self.nameLab];
    [self addSubview:lineLab];
    
    [self loadData];
    
}

#pragma mark 点击头像
- (void)pressHeaderAction
{
    //通过代理来处理
    if (self.delegate != nil)
    {
        //修改头像
        [self.delegate pressHeadImgChangeHeader:self];
    }
    
    NSLog(@"头被点了");
    
}

- (void)loadData
{
    //从Documents中获取图片
    NSString *filePath      = [Tools filePathWithDocuments:headerPath_SLAMDUNK];
    UIImage* img = [[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:filePath,NSHomeDirectory()]];
    
    if (img != nil)
    {
        self.headerImg.image = img;
        self.backView.image  = img;
    }
    else
    {
        self.headerImg.image = [UIImage imageNamed:@"defaultPic"];//默认头像
        self.backView.image  = [UIImage imageNamed:@"defaultPic"];
        
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
