//
//  PlayMusicVC.m
//  GYBase
//
//  Created by doit on 16/4/27.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    
    大神博客
    http://www.cnblogs.com/kenshincui/p/4186022.html
 
 */

#import "PlayMusicVC.h"
#import "Tools.h"


@interface PlayMusicVC()
{
    CGFloat     angle;              //按钮旋转角度
    NSTimer     *timerRotate;       //周期旋转
    NSTimer     *timerLength;       //计算剩余时间
    NSTimer     *timerProgress;     //计算当前播放进度
    UILabel     *lengthOfMusicLab;  //显示播放时间
    UISlider    *sliderVoice;       //音量键
    UISlider    *processSlider;     //音乐进度控制
    
}

@end

@implementation PlayMusicVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.player = [[PlaySound alloc] initWithFileName:@"直到世界的尽头" isLoopPlayBack:YES];
    [self initPlayMusicUI];
    
}

//在这里释放资源
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //下面的代码放在dealloc中 player对象并不会释放 不知道为什么 也许是因为这里的timer的关系
    self.player    = nil;
    self.musicCtrl = nil;
    
    [timerRotate invalidate];
    [timerLength invalidate];
    timerRotate = nil;
    timerLength = nil;
    
}

- (void)initPlayMusicUI
{
    self.view.backgroundColor = RGB2Color(0, 100, 100);
    self.navigationItem.title = @"直到世界的尽头";
    
    CGFloat sizeCtrl = screenWidth * 0.6;
    self.musicCtrl = [[UIControlK alloc] initWithFrame:CGRectMake(0, 0, sizeCtrl, sizeCtrl)];
    self.musicCtrl.center = CGPointMake(screenWidth/2, screenHeight/2);
    [self.musicCtrl setYuanJiao:sizeCtrl/2];
    [self.musicCtrl setBackgroundImgNormal:@"charater_sanjing"];
    [self.musicCtrl setBackgroundImgHighLight:@"charater_caizi"];
    [self.musicCtrl setBackgroundIsAlternate];
    [self.view addSubview:self.musicCtrl];
    WS(ws);
    self.musicCtrl.clickBlock = ^(UIControlK *a)
    {
        if (ws.isPlaying)//暂停
        {
            ws.isPlaying = NO;
            [ws.player stopSound];
            [ws stopTimer];
            [ws removeTimerProgressLife];
        }
        else//播放
        {
            ws.isPlaying = YES;
            [ws.player playSound];
            [ws startTimer];
            [ws monitorProgressOfMusic];
        }
        
    };
    
    
    //创建滑块 控制音量
    sliderVoice = [[UISlider alloc]initWithFrame:CGRectMake(margin_10, 64 + 20, screenWidth - margin_10 * 2, 20)];
    [self.view addSubview:sliderVoice];
    
    sliderVoice.maximumValue = 100;
    sliderVoice.minimumValue = 0 ;
    sliderVoice.value = 100;
    [sliderVoice addTarget:self action:@selector(valuechange:) forControlEvents:UIControlEventValueChanged ];
    
    //歌曲长度
    CGFloat yLength = CGRectGetMaxY(self.musicCtrl.frame) + margin_10;
    lengthOfMusicLab = [[UILabel alloc] initWithFrame:CGRectMake(0, yLength, screenWidth, height_normal)];
    lengthOfMusicLab.textAlignment = NSTextAlignmentCenter;
    lengthOfMusicLab.textColor = [UIColor whiteColor];
    [self.view addSubview: lengthOfMusicLab];
    
    //转换时间
    NSTimeInterval secondsFloat = [self.player lengOfMusic];
    NSInteger munite  = secondsFloat / 60;
    NSInteger seconds = (int)secondsFloat % 60;
    lengthOfMusicLab.text = [NSString stringWithFormat:@"歌曲长度 %02ld:%02ld", munite, seconds];
    
    //进度
    processSlider = [[UISlider alloc] initWithFrame:CGRectMake(margin_10, screenHeight - 100, screenWidth - margin_10 * 2, 20)];
    
    [processSlider addTarget:self
                      action:@selector(processChanged)
            forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:processSlider];
    
}

//监听播放进度
- (void)monitorProgressOfMusic
{
    if (timerProgress == nil)
    {
        timerProgress = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                         target:self
                                                       selector:@selector(updateSliderValue)
                                                       userInfo:nil
                                                        repeats:YES];
    }
    
}

//删除进度监听的timer
- (void)removeTimerProgressLife
{
    if (!self.player.player.isPlaying)
    {
        if (timerProgress != nil)
        {
            [timerProgress invalidate];
            timerProgress = nil;
        }
    }
}

//0.001s 调用一次 更改进度
- (void)processChanged
{
    [self.player.player setCurrentTime:processSlider.value * self.player.player.duration];
    
}

- (void)updateSliderValue
{
    processSlider.value = self.player.player.currentTime/self.player.player.duration;
    
}

//开启timer
- (void)startTimer
{
    if (timerRotate == nil)
    {
       //周期旋转
       timerRotate = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
        
        //计算剩余时间
        timerLength = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(completeLengthToEnd) userInfo:nil repeats:YES];
    }
    
}

//关闭timer
- (void)stopTimer
{
    [timerRotate invalidate];
    timerRotate = nil;
    
    [timerLength invalidate];
    timerLength = nil;
}

//旋转动画 按钮［timer周期触发］
- (void)startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    if (self.isPlaying)
    {
        angle += 0.2;
    }
    self.musicCtrl.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
    
}

//计算剩余时间 [timer 周期触发]
- (void)completeLengthToEnd
{
    NSTimeInterval secondsFloat = [self.player lengOfMusic] - [self.player.player currentTime];
    NSInteger munite  = secondsFloat / 60;
    NSInteger seconds = (int)secondsFloat % 60;
    lengthOfMusicLab.text = [NSString stringWithFormat:@"歌曲长度 %02ld:%02ld", munite, seconds];
}

//音量键
- (void)valuechange:(UISlider *)slider
{
    self.player.player.volume = slider.value/100;
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.player      = nil;
    self.musicCtrl   = nil;
    timerRotate      = nil;
    timerLength      = nil;
    timerProgress    = nil;
    lengthOfMusicLab = nil;
    sliderVoice      = nil;
    processSlider    = nil;
    
}
@end
