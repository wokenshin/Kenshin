//
//  LoadManyImgsVC.m
//  GYBase
//
//  Created by doit on 16/6/2.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    NSThread
 
 */

#import "LoadManyImgsVC.h"
#import "Tools.h"
#import "KImageData.h"
#import "UIButtonK.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface LoadManyImgsVC ()

@property (nonatomic, strong)NSMutableArray         *imageViews;//多张图片

@end

@implementation LoadManyImgsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLoadManyImgsUI];
    
}

- (void)initLoadManyImgsUI
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
    
    WS(ws);
    //加载多张图片［按钮］
    UIButtonK *loadimgsBtn = [[UIButtonK alloc] initWithFrame:CGRectMake(screenWidth/2 - 100/2, screenHeight - 49, 100, 44)];
    [loadimgsBtn setStyleGreen];
    [loadimgsBtn setTitle:@"loadimgs" forState:UIControlStateNormal];
    [self.view addSubview:loadimgsBtn];
    loadimgsBtn.clickButtonBlock = ^(UIButtonK *b){
        [ws loadManyImages];
        
    };
    
}

#pragma mark 多线程下载图片
- (void)loadManyImages
{
    //创建多个线程用于填充图片
    for (int i = 0; i < ROW_COUNT * COLUMN_COUNT; ++i)
    {
//        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
//        thread.name = [NSString stringWithFormat:@"myThread%i",i];//设置线程名称
//        [thread start];
        
        //等同于上面注释掉的代码
        [self performSelectorInBackground:@selector(loadImage:) withObject:[NSNumber numberWithInt:i]];
    }

}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index
{
//    NSLog(@"%@",index);
    //currentThread方法可以取得当前操作线程
    NSLog(@"current thread:%@",[NSThread currentThread]);
    
    int i = (int)[index integerValue];
    
    //    NSLog(@"%i",i);//未必按顺序输出
    
    NSData *data = [self requestData:i];
    
    KImageData *imageData = [[KImageData alloc]init];
    imageData.index = i;
    imageData.data  = data;
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
    
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index
{
    NSURL  *url  = [NSURL URLWithString:@"http://images.apple.com/v/watch/j/images/shared/watch_04_large.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
    
}

#pragma mark 将图片显示到界面
-(void)updateImage:(KImageData *)imageData
{
    UIImage *image = [UIImage imageWithData:imageData.data];
    UIImageView *imageView = _imageViews[imageData.index];
    imageView.image = image;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _imageViews = nil;
    
}

@end
