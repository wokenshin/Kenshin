//
//  MasonryLayoutVC.m
//  GYBase
//
//  Created by doit on 16/4/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Tools.h"
#import "MasonryLayoutVC.h"
#import "View+MASAdditions.h"
#import "BlockButton.h"
#import "MasonryLayoutTwoVC.h"

@interface MasonryLayoutVC ()

@end

@implementation MasonryLayoutVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    [Tools toast:@"横竖屏 测试！" andCuView:self.view];

}

- (void)initUI
{
    self.view.backgroundColor = colorPageIn;
    self.navigationItem.title = @"布局约束";
    
    
    BlockButton *red = [BlockButton new];
    red.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    [red setTitle:@"进入下一个vc" forState:UIControlStateNormal];
    
    __weak MasonryLayoutVC *weakSelf = self;
    red.block = ^(BlockButton *b){
        MasonryLayoutTwoVC *vc = [MasonryLayoutTwoVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:red];
    [red mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo (@49);
        make.left.equalTo(@10);
        make.width.equalTo(@130);
        make.height.equalTo(@200);
        
    }];
    
    for (int i = 1; i < 4; i++)
    {
        UIView *green = [UIView new];
        green.backgroundColor =[UIColor colorWithRed:0.400 green:1.000 blue:0.400 alpha:1.000];
        [self.view addSubview:green];
        [green mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(63 * i);
            make.height.equalTo(@49);
            make.right.equalTo(@-10);
            make.left.equalTo(red.mas_right).offset(20);//相对于红色 右边 边距为 20
            
        }];
        
    }
    
    UIView *blue = [UIView new];
    blue.backgroundColor = [UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000];
    [self.view addSubview:blue];
    [blue mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(red.mas_bottom).offset(10);
        make.bottom.equalTo(@-5);
        make.right.equalTo(@-10);
        make.left.equalTo(@10);
        
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