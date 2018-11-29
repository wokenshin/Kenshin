//
//  CollectionVC.m
//  GYBase
//
//  Created by doit on 16/6/18.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CollectionVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "CollectionOneVC.h"

@interface CollectionVC ()

@end

@implementation CollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCollectionUI];
}

- (void)initCollectionUI
{
    self.view.backgroundColor = RGB2Color(20, 40, 50);//深湛蓝
    self.navigationItem.title = @"UICollectionView";
    
    CGFloat widthBtn = 300;
    WS(ws);
    //UICollectionView(一)
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake((screenWidth - widthBtn)/2, 64 + margin_10, widthBtn, 44)];
    [btn setTitle:@"UICollectionView(一)" forState:UIControlStateNormal];
    [btn setStyleGreen];
    btn.clickButtonBlock = ^(UIButtonK *b){
        CollectionOneVC *vc = [CollectionOneVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:btn];
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}











@end
