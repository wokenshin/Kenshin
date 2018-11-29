//
//  ParallelVC.m
//  GYBase
//
//  Created by doit on 16/6/6.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    并发队列同样是使用dispatch_queue_create()方法创建，只是最后一个参数指定为DISPATCH_QUEUE_CONCURRENT进行创建，
    但是在实际开发中我们通常不会重新创建一个并发队列而是使用dispatch_get_global_queue()方法取得一个全局的并发队列
   （当然如果有多个并发队列可以使用前者创建）。下面通过并行队列演示一下多个图片的加载。代码与上面串行队列加载类似，只需要修改照片加载方法
 
     结论：
     
     在GDC中一个操作是多线程执行还是单线程执行取决于当前队列类型和执行方法，只有队列类型为并行队列并且使用异步方法执行时才能在多个线程中执行。
     串行队列可以按顺序执行，并行队列的异步方法无法确定执行顺序。
     UI界面的更新最好采用同步方法，其他操作采用异步方法。
 
 */

#import "ParallelVC.h"
#import "Tools.h"
#import "UIButtonK.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface ParallelVC ()

@property (nonatomic, strong) NSMutableArray                *imageViews;
@property (nonatomic, strong) NSMutableArray                *imageNames;

@end

@implementation ParallelVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initParalleUI];
    [Tools toast:@"并发执行" andCuView:self.view];
    
}

- (void)initParalleUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"并行队列";
    
    //创建多个图片控件用于显示图片
    _imageViews = [NSMutableArray array];
    
    for (int r = 0; r < ROW_COUNT; r++)
    {
        for (int c = 0; c < COLUMN_COUNT; c++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING)  + 30,
                                                                                  r*ROW_HEIGHT+(r*CELL_SPACING) + 64 + 10,
                                                                                  ROW_WIDTH, ROW_HEIGHT)];
            imageView.backgroundColor = RGB2Color(242, 242, 242);
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++)
    {
        [_imageNames addObject:[NSString stringWithFormat:@"https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/117.jpg"]];
        
    }
    
    WS(ws);
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 100/2, screenHeight - 49, 100, 44)];
    [btn setStyleGreen];
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    btn.clickButtonBlock = ^(UIButtonK *b){
        [ws loadImageWithMultiThread];
        
    };
    
    [self.view addSubview:btn];

    
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread
{
    int count=ROW_COUNT*COLUMN_COUNT;
    
    /*取得全局队列
     第一个参数：线程优先级
     第二个参数：标记参数，目前没有用，一般传入0
     */
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建多个线程用于填充图片
    for (int i = 0; i < count; ++i) {
        //异步执行队列任务
        dispatch_async(globalQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
    }
    
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index
{
    //如果在串行队列中会发现当前线程打印变化完全一样，因为他们在一个线程中
    NSLog(@"thread is :%@",[NSThread currentThread]);
    
    int i = (int)[index integerValue];
    //请求数据
    NSData *data= [self requestData:i];
    //更新UI界面,此处调用了GCD主线程队列的方法
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        [self updateImageWithData:data andIndex:i];
        
    });
    
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index
{
    NSURL  *url  = [NSURL URLWithString:_imageNames[index]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
    
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(int )index
{
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = _imageViews[index];
    imageView.image = image;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _imageViews = nil;
    _imageNames = nil;
    
}

@end
