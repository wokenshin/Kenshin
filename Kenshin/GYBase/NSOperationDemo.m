//
//  NSOperationDemo.m
//  GYBase
//
//  Created by doit on 16/6/3.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
     使用NSOperation和NSOperationQueue进行多线程开发类似于C#中的线程池，只要将一个NSOperation（实际开中需要使用其子类NSInvocationOperation、
     NSBlockOperation）放到NSOperationQueue这个队列中线程就会依次启动。NSOperationQueue负责管理、执行所有的NSOperation，
     在这个过程中可以更加容易的管理线程总数和控制线程之间的依赖关系。
 
     NSOperation有两个常用子类用于创建线程操作：NSInvocationOperation和NSBlockOperation，
     两种方式本质没有区别，但是是后者使用Block形式进行代码组织，使用相对方便。
 
 */

#import "NSOperationDemo.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "LoadManyImgsVC2.h"

@interface NSOperationDemo ()

@property (nonatomic, strong) UIImageView           *imageView;

@end

@implementation NSOperationDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNSOperationDemoUI];
    
}

- (void)initNSOperationDemoUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"NSOperation";
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 220)];
    _imageView.center = CGPointMake(screenWidth/2, screenHeight/2 + 100);
    _imageView.backgroundColor = RGB2Color(242, 242, 242);
    [self.view addSubview:_imageView];
    
    
    WS(ws);
    
    //[加载一张图片]NSInvocationOperationDemo
    UIButtonK *btn1 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 200, 44)];
    [btn1 setStyleGreen];
    [btn1 setTitle:@"加载图片" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    btn1.clickButtonBlock = ^(UIButtonK *b){
        [ws loadaImgs];
        
    };
    
    //[加载多张图片]NSBlockOperation
    UIButtonK *btn2 = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10*2 + 44, 200, 44)];
    [btn2 setStyleGreen];
    [btn2 setTitle:@"加载多张图片" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    btn2.clickButtonBlock = ^(UIButtonK *b){
        LoadManyImgsVC2 *vc = [LoadManyImgsVC2 new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
}

#pragma mark NSInvocationOperationDemo
- (void)loadaImgs
{
    /*
     首先使用NSInvocationOperation进行一张图片的加载演示，整个过程就是：创建一个操作，在这个操作中指定调用方法和参数，
     然后加入到操作队列。其他代码基本不用修改，直接修加载图片方法如下：
     */
    
    /*创建一个调用操作
     object:调用方法参数
     */
    
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                                     selector:@selector(loadImage)
                                                                                       object:nil];
    
    //创建完NSInvocationOperation对象并不会调用，它由一个start方法启动操作，但是注意如果直接调用start方法，则此操作会在主线程中调用，一般不会这么操作,而是添加到NSOperationQueue中
    //    [invocationOperation start];
    
    //创建操作队列
    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
    //注意添加到操作队后，队列会开启一个线程执行此操作
    [operationQueue addOperation:invocationOperation];
    
}

- (void)loadImage
{
    //请求数据
    NSData *data = [self requestData];
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
    
}

- (NSData *)requestData
{
    NSURL *url = [NSURL URLWithString:@"https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/117.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
    
}

- (void)updateImage:(NSData *)imageData
{
    UIImage *image = [UIImage imageWithData:imageData];
    _imageView.image = image;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _imageView = nil;
    
}

@end
