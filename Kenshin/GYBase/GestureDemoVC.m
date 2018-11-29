//
//  GestureDemoVC.m
//  GYBase
//
//  Created by doit on 16/5/26.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
     使用手势
     
     在iOS中添加手势比较简单，可以归纳为以下几个步骤：
     
     创建对应的手势对象；
     设置手势识别属性【可选】；
     附加手势到指定的对象；
     编写手势操作方法；
     为了帮助大家理解，下面以一个图片查看程序演示一下上面几种手势，在这个程序中我们完成以下功能：
     
     如果点按图片会在导航栏显示图片名称；
     
     如果长按图片会显示删除按钮，提示用户是否删除；
     
     如果捏合会放大、缩小图片；
     
     如果轻扫会切换到下一张或上一张图片；
     
     如果旋转会旋转图片；
     
     如果拖动会移动图片；
 

 示例中需要强调几点：
 
 UIImageView默认是不支持交互的，也就是userInteractionEnabled=NO ，因此要接收触摸事件（手势识别），必须设置userInteractionEnabled=YES(在iOS中UILabel、UIImageView的userInteractionEnabled默认都是NO，UIButton、UITextField、UIScrollView、UITableView等默认都是YES)。
 轻扫手势虽然是连续手势但是它的操作事件只会在识别结束时调用一次，其他连续手势都会调用多次，一般需要进行状态判断；此外轻扫手势支持四个方向，但是如果要支持多个方向需要添加多个轻扫手势。
 
 */

#define imageCount 3
#import "GestureDemoVC.h"
#import "Tools.h"

@interface GestureDemoVC ()

@property (nonatomic, strong) UIImageView           *imgView;
@property (nonatomic, assign) int                   currentImgIndex;//当前图片索引


@end

@implementation GestureDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initGestureUI];
    [self addGesture];
    
    [Tools toast:@"综合例子" andCuView:self.view];
    
}

- (void)initGestureUI
{
    self.view.backgroundColor = RGB2Color(148, 199, 11);
    
    /*添加图片展示控件*/
    CGSize screenSize  = [UIScreen mainScreen].applicationFrame.size;
    CGFloat topPadding = 20;
    CGFloat y = 22 + 44 + topPadding;
    CGFloat height = screenSize.height - y - topPadding;
    
    CGRect imageFrame = CGRectMake(0, y, screenSize.width, height);
    _imgView = [[UIImageView alloc]initWithFrame:imageFrame];
    _imgView.contentMode = UIViewContentModeScaleToFill;//设置内容模式为缩放填充
    _imgView.userInteractionEnabled = YES;//这里必须设置为YES，否则无法接收手势操作
    [self.view addSubview:_imgView];
    
    //添加默认图片
    UIImage *image = [UIImage imageNamed:@"gesture_0"];
    _imgView.image = image;
    [self showPhotoName];
    
}

#pragma mark 添加手势
-(void)addGesture
{
    /*添加点按手势*/
    //创建手势对象
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(tapImage:)];
    //设置手势属性
    tapGesture.numberOfTapsRequired = 1;//设置点按次数，默认为1，注意在iOS中很少用双击操作
    tapGesture.numberOfTouchesRequired = 1;//点按的手指数
    //添加手势到对象(注意，这里添加到了控制器视图中，而不是图片上，否则点击空白无法隐藏导航栏)
    [self.view addGestureRecognizer:tapGesture];
    
    
    /*添加长按手势*/
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                                                                                  action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration = 0.5;//设置长按时间，默认0.5秒，一般这个值不要修改
    //注意由于我们要做长按提示删除操作，因此这个手势不再添加到控制器视图上而是添加到了图片上
    [_imgView addGestureRecognizer:longPressGesture];
    
    /*添加捏合手势*/
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self
                                                                                      action:@selector(pinchImage:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    /*添加旋转手势*/
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self
                                                                                               action:@selector(rotateImage:)];
    [self.view addGestureRecognizer:rotationGesture];
    
    /*添加拖动手势*/
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(panImage:)];
    [_imgView addGestureRecognizer:panGesture];
    
    /*添加轻扫手势*/
    //注意一个轻扫手势只能控制一个方向，默认向右，通过direction进行方向控制
    UISwipeGestureRecognizer *swipeGestureToRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                             action:@selector(swipeImage:)];
    //swipeGestureToRight.direction=UISwipeGestureRecognizerDirectionRight;//默认为向右轻扫
    [self.view addGestureRecognizer:swipeGestureToRight];
    
    UISwipeGestureRecognizer *swipeGestureToLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                            action:@selector(swipeImage:)];
    swipeGestureToLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGestureToLeft];
    
    
    //解决在图片上滑动时拖动手势和轻扫手势的冲突
    [panGesture requireGestureRecognizerToFail:swipeGestureToRight];
    [panGesture requireGestureRecognizerToFail:swipeGestureToLeft];
    //解决拖动和长按手势之间的冲突
    [longPressGesture requireGestureRecognizerToFail:panGesture];
}

#pragma mark 显示图片名称
-(void)showPhotoName
{
    NSString *title=[NSString stringWithFormat:@"gesture_%i",_currentImgIndex];//_currentImgIndex=0，1，2
    [self setTitle:title];
    
}

#pragma mark 下一张图片
-(void)nextImage
{
    int index = (_currentImgIndex + imageCount + 1) % imageCount;
    NSString *imageName = [NSString stringWithFormat:@"gesture_%i",index];
    _imgView.image = [UIImage imageNamed:imageName];
    _currentImgIndex = index;
    [self showPhotoName];
    
}

#pragma mark 上一张图片
-(void)lastImage
{
    int index = (_currentImgIndex + imageCount - 1) % imageCount;
    NSString *imageName = [NSString stringWithFormat:@"gesture_%i",index];
    _imgView.image = [UIImage imageNamed:imageName];
    _currentImgIndex = index;
    [self showPhotoName];
    
}

#pragma mark - 手势操作
#pragma mark 点按隐藏或显示导航栏
-(void)tapImage:(UITapGestureRecognizer *)gesture
{
    //NSLog(@"tap:%i",gesture.state);
    BOOL hidden = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
    
}

#pragma mark 长按提示是否删除
-(void)longPressImage:(UILongPressGestureRecognizer *)gesture{
    //NSLog(@"longpress:%i",gesture.state);
    //注意其实在手势里面有一个view属性可以获取点按的视图
    //UIImageView *imageView=(UIImageView *)gesture.view;
    
    //由于连续手势此方法会调用多次，所以需要判断其手势状态
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"System Info"
                                                              delegate:nil
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:@"Delete the photo"
                                                     otherButtonTitles:nil];
        [actionSheet showInView:self.view];
        
    }
}

#pragma mark 捏合时缩放图片
-(void)pinchImage:(UIPinchGestureRecognizer *)gesture{
    //NSLog(@"pinch:%i",gesture.state);
    
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        //捏合手势中scale属性记录的缩放比例
        _imgView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }
    else if(gesture.state == UIGestureRecognizerStateEnded)
    {//结束后恢复
        [UIView animateWithDuration:.5 animations:^{
            _imgView.transform = CGAffineTransformIdentity;//取消一切形变
        }];
    }
}

#pragma mark 旋转图片
-(void)rotateImage:(UIRotationGestureRecognizer *)gesture
{
    //NSLog(@"rotate:%i",gesture.state);
    if (gesture.state==UIGestureRecognizerStateChanged)
    {
        //旋转手势中rotation属性记录了旋转弧度
        _imgView.transform=CGAffineTransformMakeRotation(gesture.rotation);
    }
    else if(gesture.state==UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.8 animations:^{
            _imgView.transform=CGAffineTransformIdentity;//取消形变
        }];
    }
}

#pragma mark 拖动图片
-(void)panImage:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state==UIGestureRecognizerStateChanged)
    {
        CGPoint translation=[gesture translationInView:self.view];//利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动
        _imgView.transform=CGAffineTransformMakeTranslation(translation.x, translation.y);
    }
    else if(gesture.state==UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _imgView.transform=CGAffineTransformIdentity;
        }];
    }
    
}

#pragma mark 轻扫则查看下一张或上一张
//注意虽然轻扫手势是连续手势，但是只有在识别结束才会触发，不用判断状态
-(void)swipeImage:(UISwipeGestureRecognizer *)gesture
{
    //    NSLog(@"swip:%i",gesture.state);
    //    if (gesture.state==UIGestureRecognizerStateEnded) {
    
    //direction记录的轻扫的方向
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight)
    {//向右
        [self nextImage];
        //            NSLog(@"right");
    }
    else if(gesture.direction==UISwipeGestureRecognizerDirectionLeft)
    {//向左
        //            NSLog(@"left");
        [self lastImage];
    }
    //    }
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _imgView = nil;
    
}

@end
