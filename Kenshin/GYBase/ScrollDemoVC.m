//
//  ScrollDemoVC.m
//  GYBase
//
//  Created by doit on 16/5/30.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ScrollDemoVC.h"
#import "Tools.h"

@interface ScrollDemoVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView          *scrollView;
@property (nonatomic, strong) UIImageView           *imageView;

@end

@implementation ScrollDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initScrollDemoUI];
    
}

- (void)initScrollDemoUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"缩放";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加scrollView控件
    //注意UIScreen代表当前屏幕对象，其applicationFrame是当前屏幕内容区域
    _scrollView =[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    //_scrollView.backgroundColor=[UIColor redColor];
    _scrollView.contentMode=UIViewContentModeScaleToFill;
    [self.view addSubview:_scrollView];
    
    
    //添加图片控件
    UIImage *image=[UIImage imageNamed:@"haizeiwang"];
    _imageView=[[UIImageView alloc]initWithImage:image];
    [_scrollView addSubview:_imageView];
    
    
    
    //contentSize必须设置,否则无法滚动，当前设置为图片大小
    _scrollView.contentSize=_imageView.frame.size;
    
    //实现缩放：maxinumZoomScale必须大于minimumZoomScale同时实现viewForZoomingInScrollView方法
    _scrollView.minimumZoomScale=0.6;
    _scrollView.maximumZoomScale=3.0;
    //设置代理
    _scrollView.delegate=self;
    
    
    //边距，不属于内容部分，内容坐标（0，0）指的是内容的左上角不包括边界
    //_scrollView.contentInset=UIEdgeInsetsMake(10, 20, 10, 20);
    
    //显示滚动内容的指定位置
    //_scrollView.contentOffset=CGPointMake(10, 0);
    
    //隐藏滚动条
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
    //禁用弹簧效果
    //_scrollView.bounces=NO;
    
}

#pragma mark 实现缩放视图代理方法，不实现此方法无法缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
    
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"scrollViewWillBeginZooming");
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"scrollViewDidEndZooming");
    
}

#pragma mark 当图片小于屏幕宽高时缩放后让图片显示到屏幕中间
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize originalSize=_scrollView.bounds.size;
    CGSize contentSize=_scrollView.contentSize;
    CGFloat offsetX=originalSize.width>contentSize.width?(originalSize.width-contentSize.width)/2:0;
    CGFloat offsetY=originalSize.height>contentSize.height?(originalSize.height-contentSize.height)/2:0;
    
    _imageView.center=CGPointMake(contentSize.width/2+offsetX, contentSize.height/2+offsetY);
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _scrollView = nil;
    _imageView  = nil;
    
}
@end
