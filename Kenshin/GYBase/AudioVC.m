//
//  AudioVC.m
//  GYBase
//
//  Created by doit on 16/5/16.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    学习资源来自：http://www.cnblogs.com/kenshincui/p/4186022.html#commentform
 
    在iOS中音频播放从形式上可以分为音效播放和音乐播放。前者主要指的是一些短音频播放，通常作为点缀音频，对于这类音频不需要进行进度、
    循环等控制。后者指的是一些较长的音频，通常是主音频，对于这些音频的播放通常需要进行精确的控制。在iOS中播放两类音频分别使用
    AudioToolbox.framework和
    AVFoundation.framework来完成音效和音乐播放。
 
     音效：
     AudioToolbox.framework是一套基于C语言的框架，使用它来播放音效其本质是将短音频注册到系统声音服务（
     System Sound Service）。System Sound Service是一种简单、底层的声音播放服务，但是它本身也存在着一些限制：
     
     音频播放时间不能超过30s
     数据必须是PCM或者IMA4格式
     音频文件必须打包成.caf、.aif、.wav中的一种（注意这是官方文档的说法，实际测试发现一些.mp3也可以播放）
    
     音乐：
     如果播放较大的音频或者要对音频有精确的控制则System Sound Service可能就很难满足实际需求了，
     通常这种情况会选择使用AVFoundation.framework中的AVAudioPlayer来实现。AVAudioPlayer可以看成一个播放器，
     它支持多种音频格式，而且能够进行进度、音量、播放速度等控制
 
 */

#import "AudioVC.h"
#import "Tools.h"
#import "UIButtonK.h"

#import <AudioToolbox/AudioToolbox.h>//播放音效
#import <AVFoundation/AVFoundation.h>//播放音乐
@interface AudioVC ()<AVAudioPlayerDelegate>

//播放音乐
@property (nonatomic, strong)AVAudioPlayer      *audioPlayer;
@property (nonatomic, strong)UIProgressView     *progressMusic;
@property (nonatomic, strong)UIButtonK          *btnMusic;//播放/暂停按钮(如果tag为0认为是暂停状态，1是播放状态)
@property (nonatomic, strong)NSTimer            *timer;
@end

@implementation AudioVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAudioVCUI];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];//杀掉定时器 否则本控制器无法释放
    
}

- (void)initAudioVCUI
{
    self.navigationItem.title = @"音频";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     1.音效
     2.音乐
     3.
     4.
     */
    
    WS(ws);
    
    //播放音效——————————————————————————————————————————————————————————————————————————————————————————
    
    UIButtonK *btnSound = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 44, 44)];
    [btnSound setTitle:@"音效" forState:UIControlStateNormal];
    btnSound.clickButtonBlock = ^(UIButtonK *b){
        [ws playSound];
    };
    
    //播放音乐［已经实现了 后台模式(app在后台运行时，黑屏时依然能够继续播放) 和 耳机模式(插入耳机 耳机播放， 拔出耳机 暂停播放)］
    self.btnMusic = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_10 + (44+margin_10), 64 + margin_10, 44, 44)];
    [self.btnMusic setTitle:@"音乐" forState:UIControlStateNormal];
    [self.btnMusic setBackgroundNormalColor:RGB2Color(13, 121, 213)];
    self.btnMusic.tag = 0;//暂停
    self.btnMusic.clickButtonBlock = ^(UIButtonK *b){
        [ws playMusic];
    };
    //音乐进度条
    self.progressMusic = [[UIProgressView alloc] initWithFrame:CGRectMake(margin_10, 300, screenWidth - margin_10*2, 44)];
    /*
     [耳机模式]
     为了能够让应用退到后台之后支持耳机控制，建议添加远程控制事件（这一步不是后台播放必须的）
     
     前两步是后台播放所必须设置的，第三步主要用于接收远程事件，这部分内容之前的文章中有详细介绍，如果这一步不设置虽让也能够在后台播放，但是无法获得音频控制权（如果在使用当前应用之前使用其他播放器播放音乐的话，此时如果按耳机播放键或者控制中心的播放按钮则会播放前一个应用的音频），并且不能使用耳机进行音频控制。第一步操作相信大家都很容易理解，如果应用程序要允许运行到后台必须设置，正常情况下应用如果进入后台会被挂起，通过该设置可以上应用程序继续在后台运行。但是第二步使用的AVAudioSession有必要进行一下详细的说明。
     */
    
    //音频会话——————————————————————————————————————————————————————————————————————————————————————————
    /*
     在MediaPlayer.frameowork 中有一个 MPMusicPlayerController 用于播放音乐库中的音乐
     
     MPMusicPlayerController有两种播放器：applicationMusicPlayer和systemMusicPlayer，前者在应用退出后音乐播放会自动停止，后者在应用停止后不会退出播放状态。
     MPMusicPlayerController加载音乐不同于前面的AVAudioPlayer是通过一个文件路径来加载，而是需要一个播放队列。在MPMusicPlayerController中提供了两个方法来加载播放队列：- (void)setQueueWithQuery:(MPMediaQuery *)query和- (void)setQueueWithItemCollection:(MPMediaItemCollection *)itemCollection，正是由于它的播放音频来源是一个队列，因此MPMusicPlayerController支持上一曲、下一曲等操作。
     
     后续的学习内容很多，都是关于 播放音乐 录音 视频 摄像头等功能的使用。 要深入学习的时候再去查看吧！2016-05-18 over
     
     */
    
    
    
    [self.view addSubview:btnSound];
    [self.view addSubview:self.btnMusic];
    [self.view addSubview:self.progressMusic];
    
}

#pragma mark - 播放音效
- (void)playSound
{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:@"Default.mp3" ofType:nil];
    NSURL    *fileUrl   = [NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
//    AudioServicesPlayAlertSound(soundID);//播放音效并震动 只会震动一次
    
}

/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID, void * clientData)
{
    NSLog(@"音效播放完噢!");
    NSLog(@"%u,  %@", (unsigned int)soundID, clientData);
    
}

#pragma mark - 播放音乐
- (void)playMusic
{
    /*
     1.初始化AVAudioPlayer对象，此时通常指定本地文件路径。
     2.设置播放器属性，例如重复次数、音量大小等。
     3.调用play方法播放。
     */
    
    if (self.btnMusic.tag == 0)//此时为暂停
    {
        //播放
        self.btnMusic.tag = 1;
        [self.btnMusic setTitle:@"stop" forState:UIControlStateNormal];
        
        if (![self.audioPlayer isPlaying])//如果当前没有播放
        {
            [self.audioPlayer play];//播放音乐
            [self StartTimer];
        }
        
    }
    else//此时为播放
    {
        [self pause];
        
    }
    
}

/**
 *  创建播放器 懒加载
 *
 *  @return 音频播放器
 */
-(AVAudioPlayer *)audioPlayer
{
    if (_audioPlayer == nil)
    {
        NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"回家的少女.mp3" ofType:nil];
        NSURL    *url    = [NSURL fileURLWithPath:urlStr];
        NSError  *error  = nil;
        
        //初始化播放器，注意这里的Url参数只能是文件路径，不支持HTTP Url
        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        //设置播放器属性
        _audioPlayer.numberOfLoops = 0;//设置为0不循环
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];//加载音频文件到缓存
        if(error)
        {
            NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
            return nil;
            
        }
        
        //[让 app进入后台后 继续播放音乐]
        //为咯让app在进入后台的时候也能继续播放音乐 需要做两步：
        //1 是在 Capabilities 中设置 后台模式 选中 音乐播放 和 Background fetch
        //2 就是添加如下代码:
        
        //设置后台播放模式
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
        
#pragma mark - 耳机模式
        //添加通知，拔出耳机后暂停播放 routeChange:线路改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];
        
    }
    return _audioPlayer;
    
}

/**
 *  一旦输出改变则执行此方法
 *
 *  @param notification 输出改变通知对象
 */
-(void)routeChange:(NSNotification *)notification
{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable)
    {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"])
        {
            [self pause];
            
        }
    }
    
}

#pragma mark 暂停播放
-(void)pause
{
    //暂停
    self.btnMusic.tag = 0;
    [self.btnMusic setTitle:@"ing" forState:UIControlStateNormal];
    
    if ([self.audioPlayer isPlaying])//如果当前正在播放
    {
        [self.audioPlayer pause];//暂停音乐
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
}


//懒加载
-(NSTimer *)StartTimer
{
    
    if (!_timer)
    {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1
                                                target:self
                                              selector:@selector(updateProgress)
                                              userInfo:nil repeats:true];
    }
    return _timer;
    
}

- (void)updateProgress
{
    float progress= self.audioPlayer.currentTime /self.audioPlayer.duration;
    [self.progressMusic setProgress:progress animated:true];
    
}

#pragma mark - 播放器代理方法
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"音乐播放完成...");
    //根据实际情况播放完成可以将会话关闭，其他音频应用继续播放
    [[AVAudioSession sharedInstance]setActive:NO error:nil];
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
    self.audioPlayer   = nil;
    self.progressMusic = nil;
    self.btnMusic      = nil;
    self.timer         = nil;
    
}

@end
