//
//  MasonryLayoutTwoVC.m
//  GYBase
//
//  Created by doit on 16/4/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "MasonryLayoutTwoVC.h"
#import "Tools.h"
#import "View+MASAdditions.h"

@interface MasonryLayoutTwoVC ()

@end

@implementation MasonryLayoutTwoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI
{
    self.navigationItem.title = @"MasonryLayout";
    self.view.backgroundColor = [UIColor whiteColor];
    
    WS(weakSelf);
    
    //在做autoLayout之前 一定要先将view添加到superview上 否则会报错
    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    
    //mas_makeConstraints就是Masonry的autolayout添加函数 将所需的约束添加到block中
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    //让一个view略小于其superView(边距为10)
    UIView *sv1 = [UIView new];
    sv1.backgroundColor = [UIColor redColor];
    [sv addSubview:sv1];
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}

@end
