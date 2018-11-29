//
//  MoreThreadVC.m
//  GYBase
//
//  Created by doit on 16/6/2.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    http://www.cnblogs.com/kenshincui/p/3983982.html
 
    在iOS中每个进程启动后都会建立一个主线程（UI线程），这个线程是其他线程的父线程。由于在iOS中除了主线程，其他子线程是独立于Cocoa Touch的，
    所以只有主线程可以更新UI界面（新版iOS中，使用其他线程更新UI可能也能成功，但是不推荐）。iOS中多线程使用并不复杂，关键是如何控制好各个线程的执行顺序、
    处理好资源竞争问题。常用的多线程开发有三种方式：
 
     1.NSThread
     
     2.NSOperation
     
     3.GCD
 
 */

#import "MultiThreadVC.h"
#import "Tools.h"
#import "UIButtonK.h"
#import "NSOperationDemo.h"
#import "GCDVC.h"
#import "XMGMThreadVC.h"

//用于加载多张图片
#import "LoadManyImgsVC.h"



@interface MultiThreadVC()
@property (nonatomic, strong)UIImageView            *imageView;//单张图片

@end

@implementation MultiThreadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMoreThreadsUI];
    [Tools toast:@"NSThread需要自己管理线程生命周期" andCuView:self.view];
    
}

- (void)initMoreThreadsUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"多线程目录";
    
    //NSThread 下载图片的UI布局
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 220)];
    _imageView.center = CGPointMake(screenWidth/2, screenHeight/2 + 100);
    _imageView.backgroundColor = RGB2Color(242, 242, 242);
    [self.view addSubview:_imageView];
    
    
    WS(ws);
    //加载一张图片[NSThread]
    UIButtonK *threadBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 200, 44)];
    [threadBtn setStyleGreen];
    [threadBtn setTitle:@"NSThread加载图片" forState:UIControlStateNormal];
    threadBtn.clickButtonBlock = ^(UIButtonK *btn){
        [ws threadLoadImage];
        
    };
    
    //加载多张图片(新界面)[NSThread]
    UIButtonK *threadsBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10*2 + 44, 200, 44)];
    [threadsBtn setStyleGreen];
    [threadsBtn setTitle:@"NSThread加载多张图" forState:UIControlStateNormal];
    threadsBtn.clickButtonBlock = ^(UIButtonK *btn){
        [ws loadManyImgs];
        
    };
    
    //NSOperation(新界面)
    UIButtonK *operationBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10*3 + 44*2, 200, 44)];
    [operationBtn setStyleGreen];
    [operationBtn setTitle:@"NSOperation" forState:UIControlStateNormal];
    operationBtn.clickButtonBlock = ^(UIButtonK *btn){
        NSOperationDemo *vc = [NSOperationDemo new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //GCD
    UIButtonK *gcdBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10*4 + 44*3, 200, 44)];
    [gcdBtn setStyleGreen];
    [gcdBtn setTitle:@"GCD" forState:UIControlStateNormal];
    gcdBtn.clickButtonBlock = ^(UIButtonK *btn){
        GCDVC *vc = [GCDVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //Other 这部分是观小马哥视频时学习的内容
    UIButtonK *btnOther = [[UIButtonK alloc] initWithFrame:CGRectMake(230, 150, 100, 44)];
    [btnOther setStyleGreen];
    [btnOther setTitle:@"Other" forState:UIControlStateNormal];
    btnOther.clickButtonBlock = ^(UIButtonK *btn){
        XMGMThreadVC *vc = [XMGMThreadVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:threadBtn];
    [self.view addSubview:threadsBtn];
    [self.view addSubview:operationBtn];
    [self.view addSubview:gcdBtn];
    [self.view addSubview:btnOther];
    
}

#pragma mark - 加载单张图片
//解决线程阻塞问题［这里是单个线程］
- (void)threadLoadImage
{
    /*
     NSThread是轻量级的多线程开发，使用起来也并不复杂，但是使用NSThread需要自己管理线程生命周期。可以使用对象方法
     
     + (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(id)argument
       直接将操作添加到线程中并启动，也可以使用对象方法
     
     - (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(id)argument
     
     创建一个线程对象，然后调用start方法启动线程。
     */
    
    //下载图片的时候 用户还可以做其他操作
    
    //方法1：使用对象方法
    //创建一个线程，第一个参数是请求的操作，第二个参数是操作方法的参数
    //    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage) object:nil];
    //    //启动一个线程，注意启动一个线程并非就一定立即执行，而是处于就绪状态，当系统调度时才真正执行
    //    [thread start];
    
    //方法2：使用类方法
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
    
}

#pragma mark 加载图片
-(void)loadImage
{
    //请求数据
    NSData *data = [self requestData];
    /*将数据显示到UI控件,注意只能在主线程中更新UI,
     另外performSelectorOnMainThread方法是NSObject的分类方法，每个NSObject对象都有此方法，
     它调用的selector方法是当前调用控件的方法，例如使用UIImageView调用的时候selector就是UIImageView的方法
     Object：代表调用方法的参数,不过只能传递一个参数(如果有多个参数请使用对象进行封装)
     waitUntilDone:是否线程任务完成执行
     */
    
    //在主线程中更新UI
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
}

- (NSData *)requestData
{
    NSURL  *url  = [NSURL URLWithString:@"https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/117.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
    
}

#pragma mark 将图片显示到界面
-(void)updateImage:(NSData *)imageData
{
    UIImage *image = [UIImage imageWithData:imageData];
    _imageView.image = image;
    
}

#pragma mark - 加载多张图片
- (void)loadManyImgs
{
    /*
     上面这个演示并没有演示多个子线程操作之间的关系，现在不妨在界面中多加载几张图片，每个图片都来自远程请求。
     
     大家应该注意到不管是使用
     + (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(id)argument、
     - (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(id)argument 方法还是使用
     - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait
     方法都只能传一个参数，由于更新图片需要传递UIImageView的索引和图片数据，因此这里不妨定义一个类保存图片索引和图片数据以供后面使用。
     KImageData.h
     
     */
    
    //接下来将创建多个UIImageView并创建多个线程用于往UIImageView中填充图片。
    
    LoadManyImgsVC *vc = [LoadManyImgsVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _imageView  = nil;
    
}

@end
