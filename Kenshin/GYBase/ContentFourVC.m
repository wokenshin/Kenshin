//
//  ContentFourVC.m
//  GYBase
//
//  Created by kenshin on 16/8/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ContentFourVC.h"
#import "CellCollectionFour.h"

@interface ContentFourVC ()//原本打算该页面用 collectionViewCell来实现

@end

@implementation ContentFourVC

- (instancetype)init
{
    // 创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    //    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.itemSize = CGSizeMake(screenWidth/3.0 - 30, 36);
    
    // 设置最小行间距 10
    layout.minimumLineSpacing = 10;
    // 设置每个cell之间间距
    layout.minimumInteritemSpacing = 10;
    // 设置每一组的间距
    //    layout.sectionInset = UIEdgeInsetsMake(100, 0, 0, 0);
    // 设置滚动方向
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return  [self initWithCollectionViewLayout:layout];
}

static NSString *ID = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"目录4";
    // 注册cell
    [self.collectionView registerClass:[CellCollectionFour class] forCellWithReuseIdentifier:ID];
    // self.view != self.collectionView
    // self.collectionView 添加到 self.view
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 开启分页
//    self.collectionView.pagingEnabled = YES;
    
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //弹簧效果
    self.collectionView.bounces = YES;
    
}

// Item:cell
// 返回collectionView中有多少个cell
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 119;
    
}

// 返回cell外观
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    CellCollectionFour *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSLog(@"%@",cell);
    // 设置cell ImageView
    NSString *imageName = [NSString stringWithFormat:@"学习内容-%ld",indexPath.row];
    cell.title = imageName;
    
    return cell;
    
    
    //问题来了：这个地方我改怎么判断跳转到响应的VC呢？ 感觉判断字符串内容的方式 太low了 回头搜下 or 问问大神
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zd",indexPath.row);
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
    
}



@end
