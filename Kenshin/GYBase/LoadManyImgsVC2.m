//
//  LoadManyImgsVC2.m
//  GYBase
//
//  Created by doit on 16/6/3.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
     NSOperation
 
     对比之前NSThread加载张图片会发现核心代码简化了不少，这里着重强调两点：
     
     使用NSBlockOperation方法，所有的操作不必单独定义方法，同时解决了只能传递一个参数的问题。
     调用主线程队列的addOperationWithBlock:方法进行UI更新，不用再定义一个参数实体（之前必须定义一个KCImageData解决只能传递一个参数的问题）。
     使用NSOperation进行多线程开发可以设置最大并发线程，有效的对线程进行了控制（上面的代码运行起来你会发现打印当前进程时只有有限的线程被创建，
     如下面的代码设置最大线程数为5，则图片基本上是五个一次加载的）。
 */

#import "LoadManyImgsVC2.h"

#import "Tools.h"
#import "UIButtonK.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface LoadManyImgsVC2 ()

@property (nonatomic, strong) NSMutableArray            *imageViews;
@property (nonatomic, strong) NSMutableArray            *imageNames;

@end

@implementation LoadManyImgsVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLoadManyImgsVC2UI];
    
}

- (void)initLoadManyImgsVC2UI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"加载多张图片";
    
    //创建多个图片控件用于显示图片
    _imageViews = [NSMutableArray array];
    for (int r = 0; r < ROW_COUNT; r++)
    {
        for (int c = 0; c < COLUMN_COUNT; c++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING) + 30,
                                                                                  r*ROW_HEIGHT+(r*CELL_SPACING) + 64,
                                                                                  ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = RGB2Color(242, 242, 242);
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    //加载图片
    WS(ws);
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 100/2, screenHeight - 54, 100, 44)];
    [btn setStyleGreen];
    [btn setTitle:@"加载图片" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.clickButtonBlock = ^(UIButtonK *b){
        [ws loadImageWithMultiThread];
        
    };
    
    //创建图片链接
    _imageNames = [NSMutableArray array];
    for (int i = 0; i < ROW_COUNT*COLUMN_COUNT; i++)
    {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
        
    }
    
}

#pragma mark 多线程下载图片
- (void)loadImageWithMultiThread
{
    int count = ROW_COUNT*COLUMN_COUNT;
    //创建操作队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount = 5;//设置最大并发线程数
    //创建多个线程用于填充图片
    for (int i = 0; i < count; ++i)
    {
        //方法1：创建操作块添加到队列
        //        //创建多线程操作
        //        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^{
        //            [self loadImage:[NSNumber numberWithInt:i]];
        //        }];
        //        //创建操作队列
        //
        //        [operationQueue addOperation:blockOperation];
        
        //方法2：直接使用操队列添加操作
        [operationQueue addOperationWithBlock:^{
            [self loadImage:[NSNumber numberWithInt:i]];
        }];
    }
    
}

#pragma mark 加载图片
- (void)loadImage:(NSNumber *)index
{
    int i = (int)[index integerValue];
    
    //请求数据
    NSData *data = [self requestData:i];
    NSLog(@"%@",[NSThread currentThread]);
    //更新UI界面,此处调用了主线程队列的方法（mainQueue是UI主线程）
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updateImageWithData:data andIndex:i];
        
    }];
    
}

#pragma mark 请求图片数据
- (NSData *)requestData:(int )index
{
    NSURL *url = [NSURL URLWithString:_imageNames[index]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
    
}

#pragma mark 将图片显示到界面
- (void)updateImageWithData:(NSData *)data andIndex:(int )index
{
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = _imageViews[index];
    imageView.image = image;
    
}




@end
