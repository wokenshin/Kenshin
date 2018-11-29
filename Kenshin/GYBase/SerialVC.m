//
//  SerialVC.m
//  GYBase
//
//  Created by doit on 16/6/6.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
     使用串行队列时首先要创建一个串行队列，然后调用异步调用方法，在此方法中传入串行队列和线程操作即可自动执行。
     下面使用线程队列演示图片的加载过程，你会发现多张图片会按顺序加载，因为当前队列中只有一个线程。
 
     在下面的代码中更新UI还使用了GCD方法的主线程队列dispatch_get_main_queue()，其实这与前面两种主线程更新UI没有本质的区别。
 
 
 */

#import "SerialVC.h"
#import "Tools.h"
#import "UIButtonK.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface SerialVC ()

@property (nonatomic, strong) NSMutableArray                *imageViews;
@property (nonatomic, strong) NSMutableArray                *imageNames;

@end

@implementation SerialVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSerialUI];
    [Tools toast:@"顺序执行" andCuView:self.view];
    
}

- (void)initSerialUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"串行队列";
    
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
    int count = ROW_COUNT * COLUMN_COUNT;
    
    /*创建一个串行队列
     第一个参数：队列名称
     第二个参数：队列类型
     */
    dispatch_queue_t serialQueue = dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);//注意queue对象不是指针类型
    //创建多个线程用于填充图片
    for (int i = 0; i < count; ++i)
    {
        //异步执行队列任务
        dispatch_async(serialQueue, ^{
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
