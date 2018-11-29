//
//  MasonryIng.m
//  GYBase
//
//  Created by 刘万兵 on 16/12/27.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "MasonryIng.h"
#import "Masonry.h"

@interface MasonryIng ()

@property (nonatomic, strong) UIButton      *btnTop;
@property (nonatomic, strong) UIButton      *btnBottom;
@property (nonatomic, assign) BOOL          flag;

@end

@implementation MasonryIng

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"asd";
    
    _btnTop = [[UIButton alloc] init];
    _btnTop.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_btnTop];
    [_btnTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.centerX.offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    _btnBottom = [[UIButton alloc] init];
    _btnBottom.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_btnBottom];
    [_btnBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnTop.mas_bottom).offset(10);
        make.centerX.offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [_btnTop addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
}

- (void)test
{
    if (_flag)
    {
        _flag = NO;
        
        //注意 修改约束的时候 使用的代码块 是mas_updateConstraints 而不是 mas_makeConstraints
        //不然是不会产生预期效果的
        //只需要设置要变化的约束即可
        [_btnTop mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(140);
//            make.centerX.offset(0);
//            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
    }
    else
    {
        _flag = YES;
        //只需要设置要变化的约束即可
        [_btnTop mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(140);
//            make.centerX.offset(0);
//            make.width.mas_equalTo(100);
            make.height.mas_equalTo(200);
        }];
    }
    
}




@end
