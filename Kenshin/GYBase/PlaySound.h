//
//  PlaySound.h
//  GYBase
//
//  Created by doit on 16/4/27.
//  Copyright © 2016年 kenshin. All rights reserved.
//
/*
 功能描述： 播放一段音乐 ，可以设置 是否循环播放
          可以设置播放音乐时 伴随 震动
 */
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlaySound : NSObject

@property (nonatomic, strong) AVAudioPlayer   *player;

//初始化 并设置是否要循环播放［当 fileName 不存在时 播放默认音乐］
- (id)initWithFileName:(NSString *)fileName isLoopPlayBack:(BOOL)isLoopPlay;

//播放
- (void)playSound;

//播放 伴随 震动
- (void)playSoundShockWithTime:(NSInteger)repeatShockTime;

//暂停
- (void)stopSound;

//获取音乐长度
- (NSTimeInterval)lengOfMusic;
@end
