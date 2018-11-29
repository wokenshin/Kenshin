//
//  RecodeVoiceVC.m
//  GYBase
//
//  Created by doit on 16/5/24.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "RecodeVoiceVC.h"
#import "Tools.h"
#import <AVFoundation/AVFoundation.h>
#import "UIButtonK.h"
#define kRecordAudioFile @"myRecord.caf"

@interface RecodeVoiceVC ()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder    *audioRecorder;//音频录音机
@property (nonatomic, strong) AVAudioPlayer      *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic, strong) NSTimer            *timer;//录音声波监控（注意这里暂时不对播放进行监控）
@property (nonatomic, strong) UIProgressView     *audioPower;//音频波动
@property (nonatomic, strong) UISwitch           *yangShengQiSwitch;//是否打开扬声器［默认为听筒模式］
@end

@implementation RecodeVoiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initRecodeVoiceUI];
    [self setAudioSession];
    [Tools toast:@"只有一段录音" andCuView:self.view];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    
}

- (void)initRecodeVoiceUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"录音";
    
    //音频波动 初始化
    self.audioPower = [[UIProgressView alloc] initWithFrame:CGRectMake(margin_10, 300, screenWidth - margin_10*2, 44)];
    
    //开始录音
    UIButtonK *btnStarRecode = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_5, 64 + margin_5, 44, 44)];
    [btnStarRecode setBackgroundNormalColor:RGB2Color(30, 40, 40)];
    [btnStarRecode setBackgroundHeightlightColor:RGB2Color(40, 40, 50)];
    [btnStarRecode setTitle:@"开录" forState:UIControlStateNormal];
    
    
    //暂停录音
    UIButtonK *btnPaseRecode = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_5*2 + 44, 64 + margin_5, 44, 44)];
    [btnPaseRecode setBackgroundNormalColor:RGB2Color(30, 40, 40)];
    [btnPaseRecode setBackgroundHeightlightColor:RGB2Color(40, 40, 50)];
    [btnPaseRecode setTitle:@"暂录" forState:UIControlStateNormal];
    
    //恢复录音
    UIButtonK *btnResumeRecode = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_5*3 + 44*2, 64 + margin_5, 44, 44)];
    [btnResumeRecode setBackgroundNormalColor:RGB2Color(30, 40, 40)];
    [btnResumeRecode setBackgroundHeightlightColor:RGB2Color(40, 40, 50)];
    [btnResumeRecode setTitle:@"恢录" forState:UIControlStateNormal];
    
    //停止录音
    UIButtonK *btnStopRecode = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_5, 64 + margin_10 + 100, 150, 44)];
    [btnStopRecode setBackgroundNormalColor:RGB2Color(30, 40, 40)];
    [btnStopRecode setBackgroundHeightlightColor:RGB2Color(40, 40, 50)];
    [btnStopRecode setTitle:@"停录并播放" forState:UIControlStateNormal];
    
    //播放
    UIButtonK *btnPlayRecode = [[UIButtonK alloc] initWithFrame:CGRectMake(margin_5, 64 + margin_10 + 160, 100, 44)];
    [btnPlayRecode setBackgroundNormalColor:RGB2Color(30, 40, 40)];
    [btnPlayRecode setBackgroundHeightlightColor:RGB2Color(40, 40, 50)];
    [btnPlayRecode setTitle:@"播放" forState:UIControlStateNormal];
    
    UILabel *isYangShengQiLab = [[UILabel alloc] initWithFrame:CGRectMake(margin_10, 330, 150, 44)];
    isYangShengQiLab.text = @"是否打开扬声器";
    
    self.yangShengQiSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(screenWidth - 60, 330, 40, 40)];
    [self.yangShengQiSwitch addTarget:self action:@selector(changeVoiceMode) forControlEvents:UIControlEventValueChanged];
    
    //事件
    WS(ws);
    
    //开始录音
    btnStarRecode.clickButtonBlock = ^(UIButtonK *b){
        [ws recordClick];
    };
    
    //暂停录音
    btnPaseRecode.clickButtonBlock = ^(UIButtonK *b){
        [ws pauseClick];
    };
    
    //恢复录音
    btnResumeRecode.clickButtonBlock = ^(UIButtonK *b){
        [ws resumeClick];
    };
    
    //停止录音
    btnStopRecode.clickButtonBlock = ^(UIButtonK *b){
        [ws stopClick];
    };
    
    //播放
    btnPlayRecode.clickButtonBlock = ^(UIButtonK *b){
        [ws playClick];
    };
    
    [self.view addSubview:self.audioPower];
    [self.view addSubview:btnStarRecode];
    [self.view addSubview:btnPaseRecode];
    [self.view addSubview:btnResumeRecode];
    [self.view addSubview:btnStopRecode];
    [self.view addSubview:btnPlayRecode];
    [self.view addSubview:isYangShengQiLab];
    [self.view addSubview:self.yangShengQiSwitch];
    
}

- (void)changeVoiceMode
{
    if (self.yangShengQiSwitch.isOn)
    {
        [Tools setYangShengQiMode];
        NSLog(@"扬声器 模式");
    }
    else
    {
        [Tools setTingTongMode];
        NSLog(@"听筒 模式");
    }
}

/**
 *  设置音频会话
 */
-(void)setAudioSession
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath
{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
    
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting
{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
    
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder
{
    if (!_audioRecorder)
    {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error)
        {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
    
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer
{
    if (!_audioPlayer)
    {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error)
        {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
    
}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer
{
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                target:self
                                              selector:@selector(audioPowerChange)
                                              userInfo:nil repeats:YES];
    }
    return _timer;
    
}

/**
 *  录音声波状态设置
 */
-(void)audioPowerChange
{
    [self.audioRecorder updateMeters];//更新测量值
    float power = [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress = (1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
    
}

/**
 *  点击录音按钮
 *
 *  @param sender 录音按钮
 */
- (void)recordClick
{
    if (![self.audioRecorder isRecording])
    {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate=[NSDate distantPast];
    }
    
}

/**
 *  点击暂定按钮
 *
 *  @param sender 暂停按钮
 */
- (void)pauseClick
{
    if ([self.audioRecorder isRecording])
    {
        [self.audioRecorder pause];
        self.timer.fireDate=[NSDate distantFuture];
    }
    
}

/**
 *  点击恢复按钮
 *  恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
 *
 *  @param sender 恢复按钮
 */
- (void)resumeClick
{
    [self recordClick];
    
}

/**
 *  点击停止按钮
 *
 *  @param sender 停止按钮
 */
- (void)stopClick
{
    [self.audioRecorder stop];
    self.timer.fireDate=[NSDate distantFuture];
    self.audioPower.progress=0.0;
    
}

- (void)playClick
{
    if (![self.audioPlayer isPlaying])
    {
        [self.audioPlayer play];
    }
    
}

#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (![self.audioPlayer isPlaying])
    {
        [self.audioPlayer play];
    }
    NSLog(@"录音完成!");
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    [self.timer invalidate];
    self.timer             = nil;
    self.audioPlayer       = nil;
    self.audioRecorder     = nil;
    self.audioPower        = nil;
    self.yangShengQiSwitch = nil;
    
}
@end
