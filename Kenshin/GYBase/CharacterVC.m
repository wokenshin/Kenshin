//
//  CharacterVC.m
//  GYBase
//
//  Created by doit on 16/4/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CharacterVC.h"
#import "Tools.h"

@interface CharacterVC ()

@end

@implementation CharacterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCharacterVCUI];
    [self loadCharacterData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)initCharacterVCUI
{
    self.navigationItem.title = @"详细介绍";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat baseHeight  = 64;
    CGFloat widthHead   = 150;
    CGFloat heighthead  = 210;
    CGFloat widthLab    = 200;
    CGFloat xLab        = margin_10 * 2 + widthHead;
    CGFloat heightLab   = heighthead/5;
    CGFloat yDetailLab  = baseHeight + heighthead + margin_10*4;
    CGFloat widthDetail = screenWidth - margin_10*2;
    
    //头像
    self.headV = [[UIImageView alloc] initWithFrame:CGRectMake(margin_10, baseHeight + margin_5*3, widthHead, heighthead)];
    self.headV.image = [UIImage imageNamed:@"charater_caizi"];
    [Tools setCornerRadiusWithView:self.headV andAngle:8];
    [Tools setBorder:self.headV andColor:[UIColor lightGrayColor] andWidth:1.0f];
    
    //姓名
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(xLab, baseHeight + margin_5, widthLab, heightLab)];
    self.nameLab.text = @"name: 彩子";
    self.nameLab.textColor = [UIColor blackColor];
    
    //身高
    self.heightLab = [[UILabel alloc] initWithFrame:CGRectMake(xLab, baseHeight + margin_5*2 + heightLab, widthLab, heightLab)];
    self.heightLab.text = @"height: 170cm";
    self.heightLab.textColor = [UIColor blackColor];
    
    //号码
    self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(xLab, baseHeight + margin_5*3 + heightLab*2, widthLab, heightLab)];
    self.numLab.text = @"num: 无";
    self.numLab.textColor = [UIColor blackColor];
    
    //体重
    self.weightLab = [[UILabel alloc] initWithFrame:CGRectMake(xLab, baseHeight + margin_5*4 +heightLab*3, widthLab, heightLab)];
    self.weightLab.text = @"weight: 40kg";
    self.weightLab.textColor = [UIColor blackColor];
    
    //位置
    self.locationLab = [[UILabel alloc] initWithFrame:CGRectMake(xLab, baseHeight + margin_5*5 +heightLab*4, widthLab, heightLab)];
    self.locationLab.text = @"位置: 篮球部经理";
    self.locationLab.textColor = [UIColor blackColor];
    
    //详细
    NSString *contents = @"        彩子是湘北高中二年级的学生，因为本人非常喜欢篮球，于是在一年级的时候加入了湘北高中篮球对并担任了经理一职。也是宫城深深爱的女子，在樱木等人进入湘北篮球队之后，彩子常常帮助樱木进行篮球的基础训练。";
    self.detailLab = [UILabel new];
    self.detailLab.font = [UIFont systemFontOfSize:14];
    self.detailLab.numberOfLines = 0;
    self.detailLab.text = contents;
    self.detailLab.textColor = [UIColor blackColor];
    
    //获取详细文本高度
    CGSize detailLabSize = [Tools sizeOfTheText:contents font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(widthDetail, MAXFLOAT)];
    self.detailLab.frame = CGRectMake(margin_10, yDetailLab, detailLabSize.width, detailLabSize.height);
    
    
    //添加视图
    [self.view addSubview:self.headV];
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.heightLab];
    [self.view addSubview:self.numLab];
    [self.view addSubview:self.weightLab];
    [self.view addSubview:self.locationLab];
    [self.view addSubview:self.detailLab];
    
}

- (void)loadCharacterData
{
    //根据name 从数据库中取出数据，赋给控制器UI
    NSLog(@"当前角色：%@", self.name);
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
    self.headV       = nil;
    self.nameLab     = nil;
    self.heightLab   = nil;
    self.numLab      = nil;
    self.weightLab   = nil;
    self.locationLab = nil;
    self.detailLab   = nil;
    
}

@end
