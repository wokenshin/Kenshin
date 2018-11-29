//
//  MaoBoLiVC.m
//  GYBase
//
//  Created by kenshin on 16/6/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "MaoBoLiVC.h"
#import "Tools.h"

@interface MaoBoLiVC ()
@property (nonatomic, strong) UIImageView       *backimage;


@end

@implementation MaoBoLiVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMaoBoLiUI];
    
    
}

- (void)initMaoBoLiUI
{
    self.navigationItem.title = @"毛玻璃效果";
    
    self.backimage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backimage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.backimage.image = [Tools maoBoLiBackWithImage:[UIImage imageNamed:@"2"]];//毛玻璃效果
    [self.view addSubview:self.backimage];
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
