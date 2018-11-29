//
//  CollectionOneVC.m
//  GYBase
//
//  Created by kenshin on 16/6/18.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CollectionOneVC.h"
#import "Tools.h"
#import "CellCollectionK.h"

@interface CollectionOneVC ()

@end

@implementation CollectionOneVC

- (instancetype)init
{
    // 创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
//    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.itemSize = CGSizeMake(screenWidth/4.0, screenWidth/4.0);
    
    // 设置最小行间距 10
    layout.minimumLineSpacing = 0;
    // 设置每个cell之间间距
    layout.minimumInteritemSpacing = 0;
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
    
    // 注册cell
    [self.collectionView registerClass:[CellCollectionK class] forCellWithReuseIdentifier:ID];
    // self.view != self.collectionView
    // self.collectionView 添加到 self.view
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 开启分页
    self.collectionView.pagingEnabled = YES;
    
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 取消弹簧效果
    self.collectionView.bounces = NO;
    
}

// Item:cell
// 返回collectionView中有多少个cell
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
    
}

// 返回cell外观
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    CellCollectionK *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    NSLog(@"%@",cell);
    // 设置cell ImageView
    NSString *imageName = [NSString stringWithFormat:@"%ldscrollDemo",indexPath.row];
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
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
