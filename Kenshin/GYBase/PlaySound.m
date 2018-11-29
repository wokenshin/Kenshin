//
//  PlaySound.m
//  GYBase
//
//  Created by doit on 16/4/27.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "PlaySound.h"
#import "Tools.h"

@interface PlaySound()<AVAudioPlayerDelegate>
{
    BOOL            isLoop;
    BOOL            isShock;
    NSTimer         *shockTimer;
    
}

@end

@implementation PlaySound

- (id)initWithFileName:(NSString *)fileName isLoopPlayBack:(BOOL)isLoopPlay
{
    self = [super init];
    if (self)
    {
        if (fileName == nil || [fileName isEqualToString:@""])
        {
            fileName = @"Default";//如果传入的 文件名不合法 就设置为 默认音乐
        }
        
        NSString *path= [[NSBundle mainBundle]pathForResource:fileName ofType:@"mp3"];
        NSURL *pathurl=[NSURL fileURLWithPath:path];
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:pathurl error:nil];
        
        if (isLoopPlay)
        {
            self.player.delegate = self;//通过代理 循环播放
            isLoop = isLoopPlay;
        }
    }
    
    return self;
}

- (void)loopShock
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
}

//播放
- (void)playSound
{
    if (self.player)
    {
        [self.player play];
    }
    
}

- (void)playSoundShockWithTime:(NSInteger)repeatShockTime
{
    if (self.player)
    {
        [self.player play];
        isShock = YES;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//在模拟器上 会有警告输出 因为模拟器 没有震动功能
        if (isLoop)
        {
            shockTimer = [NSTimer scheduledTimerWithTimeInterval:repeatShockTime target:self selector:@selector(loopShock) userInfo:nil repeats:YES];
        }
    }
    
}

//暂停
- (void)stopSound
{
    if (self.player)
    {
        [self.player stop];
    }
    if (shockTimer != nil)
    {
        [shockTimer invalidate];
        shockTimer = nil;
    }
    
}

//获取音乐长度
- (NSTimeInterval)lengOfMusic
{
    if (self.player)
    {
        return self.player.duration;
    }
    return 0.0;
    
}

#pragma mark 代理 循环播放 当播放完时触发
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player2 successfully:(BOOL)flag
{
    [player2 play];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.player = nil;
    shockTimer  = nil;
    
}
@end
