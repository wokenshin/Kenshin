//
//  ScrollDemoVC1.m
//  GYBase
//
//  Created by doit on 16/5/30.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
 无限循环实现了，但是我们知道如果图片过多这些图片势必全部加载到内存，其实3个已经足够（事实上也可以用两个实现，大家不妨自己思考一下），只要一直保持显示中间的UIImageView，滚动时动态更
 改三个UIImageView的图片即可。例如三个UIImageView默认放图片5、图片1、图片2，当前显示中间的UIImageView，也就是图片1,。如果向后滚动那么就会显示图片2
 ，当图片2显示完整后迅速重新设置三个UIImageView的内容为图片1、图片2、图片3，然后通过contentOffset设置显示中间的UIImageView，也就是图片2。继续向后看
 到图片3，当图片3滚动完成迅速重新设置3个UIImageView的内容为图片2、图片3、图片4，然后设置contentOffset显示中间的UIImageView，也就是图片3。当然，向前
 滚动原理完全一样，如此就给用户一种循环错觉，而且不占用过多内存。
 
 下面给出具体的实现，在这个程序中除了UIscrollView我们还可以看到UIPageControl的使用，实现并不复杂。首先我们需要将图片信息存储到plist文件中（日后方便扩展），并且设置plist的key表示图片的名称，value代表对应的图片描述，这个描述我们需要展示在界面上方。
 
 */

#import "ScrollDemoVC1.h"
#import "MyPageControl.h"
#import "Tools.h"

@interface ScrollDemoVC1 ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView              *scrollView;

@property (nonatomic, strong) UIImageView               *leftImgView;
@property (nonatomic, strong) UIImageView               *centerImgView;
@property (nonatomic, strong) UIImageView               *rightImgView;

@property (nonatomic, strong) MyPageControl             *pageControl;
@property (nonatomic, strong) UILabel                   *titleLab;
@property (nonatomic, strong) NSDictionary              *imgs;//图片数据

@property (nonatomic, assign) int                       currentImgIndex;//当前图片索引
@property (nonatomic, assign) int                       sumImgs;//图片总数
@property (nonatomic, assign) CGFloat                   heightScroll;//滚动视图的高度


@end

@implementation ScrollDemoVC1

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImageData];
    [self initScrollDemo1UI];
    
}

#pragma mark 加载图片数据
-(void)loadImageData
{
    //读取程序包路径中的资源文件
    _imgs = [Tools plistDicTypeWithName:@"scrollDemo.plist"];//图片数据源 字典
    _sumImgs = (int)[_imgs count];//图片数
    
}

- (void)initScrollDemo1UI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"无限轮播";
    self.automaticallyAdjustsScrollViewInsets = NO;//禁止滚动视图自动下移
    
    _heightScroll = screenHeight - 64;//滚动视图高度
    
    [self addScrollView];
    [self addImageViews];
    [self setDefaultImage];
    [self addPageControl];
    [self addLabel];
    
}

#pragma mark 添加控件
-(void)addScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, _heightScroll)];
    [self.view addSubview:_scrollView];
    
    _scrollView.delegate = self;//设置代理
    _scrollView.contentSize = CGSizeMake(_sumImgs*screenWidth, _heightScroll);//设置内容区域[可以很长]
    [_scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];//设置可视化区域[现实出来的区域]
    _scrollView.pagingEnabled = YES;//设置分页
    _scrollView.showsHorizontalScrollIndicator = NO;//去掉滚动条
    
}

#pragma mark 添加图片三个控件
-(void)addImageViews
{
    //init
    _leftImgView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, _heightScroll)];
    _centerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth, 0, screenWidth, _heightScroll)];
    _rightImgView  = [[UIImageView alloc]initWithFrame:CGRectMake(2*screenWidth, 0, screenWidth, _heightScroll)];
    
    //mode 默认就是这种样式[平铺]
//    _leftImgView.contentMode   = UIViewContentModeScaleToFill;
//    _centerImgView.contentMode = UIViewContentModeScaleToFill;
//    _rightImgView.contentMode  = UIViewContentModeScaleToFill;
    
    //addView
    [_scrollView addSubview:_leftImgView];
    [_scrollView addSubview:_centerImgView];
    [_scrollView addSubview:_rightImgView];
    
}

#pragma mark 设置默认显示图片
-(void)setDefaultImage
{
    //加载默认图片
    _leftImgView.image   = [UIImage imageNamed:[NSString stringWithFormat:@"%iscrollDemo", _sumImgs-1]];
    _centerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%iscrollDemo", 0]];
    _rightImgView.image  = [UIImage imageNamed:[NSString stringWithFormat:@"%iscrollDemo", 1]];
    _currentImgIndex = 0;
    
    //设置当前页
    _pageControl.currentPage = _currentImgIndex;
    NSString *imageName = [NSString stringWithFormat:@"%iscrollDemo", _currentImgIndex];
    _titleLab.text = _imgs[imageName];
    
}

#pragma mark 添加信息描述控件
-(void)addLabel
{
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 74, screenWidth, 30)];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = [UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    _titleLab.text = _imgs[@"0scrollDemo"];
    [self.view addSubview:_titleLab];
    
}

#pragma mark 添加分页控件
-(void)addPageControl
{
    _pageControl = [[MyPageControl alloc]init];
    //注意此方法可以根据页数返回UIPageControl合适的大小
    CGSize size = [_pageControl sizeForNumberOfPages:_sumImgs];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    
    _pageControl.center = CGPointMake(screenWidth/2, screenHeight - 100);
    //设置颜色
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    //设置总页数
    _pageControl.numberOfPages = _sumImgs;
    
    //kvc 设置图片
    [_pageControl setValue:[UIImage imageNamed:@"pageCotrol_unselected"] forKeyPath:@"_pageImage"];
    [_pageControl setValue:[UIImage imageNamed:@"pageCotrol_selected"] forKeyPath:@"_currentPageImage"];

    //直接缩放
    _pageControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    //功能同上 [_pageControl setCurrentPage:0];//通过重写该方法 来设置 小点的 大小
    
    [self.view addSubview:_pageControl];
    
}

#pragma mark 滚动停止事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [_scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    //设置分页
    _pageControl.currentPage = _currentImgIndex;
    //设置描述
    NSString *imageName = [NSString stringWithFormat:@"%iscrollDemo", _currentImgIndex];
    _titleLab.text = _imgs[imageName];
    
}

#pragma mark 重新加载图片
-(void)reloadImage
{
    int leftImageIndex,rightImageIndex;
    CGPoint offset = [_scrollView contentOffset];
    if (offset.x > screenWidth)//向右滑动
    {
        _currentImgIndex = (_currentImgIndex+1) % _sumImgs;
    }
    else if(offset.x < screenWidth)//向左滑动
    {
        _currentImgIndex = (_currentImgIndex + _sumImgs - 1) % _sumImgs;
    }
    
    _centerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%iscrollDemo", _currentImgIndex]];
    
    //重新设置左右图片
    leftImageIndex  = (_currentImgIndex + _sumImgs - 1) % _sumImgs;
    rightImageIndex = (_currentImgIndex + 1) % _sumImgs;
    _leftImgView.image  = [UIImage imageNamed:[NSString stringWithFormat:@"%iscrollDemo", leftImageIndex]];
    _rightImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%iscrollDemo", rightImageIndex]];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _scrollView     = nil;
    _leftImgView    = nil;
    _centerImgView  = nil;
    _rightImgView   = nil;
    _pageControl    = nil;
    _titleLab       = nil;
    _imgs           = nil;
    
}

@end
