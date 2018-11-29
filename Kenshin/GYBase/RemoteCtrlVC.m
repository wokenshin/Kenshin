//
//  RemoteCtrlVC.m
//  GYBase
//
//  Created by doit on 16/5/26.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
     远程控制，远程控制事件这里主要说的就是耳机线控操作。在前面的事件列表中，大家可以看到在iOS中和远程控制事件有关的只有一个- (void)remoteControlReceivedWithEvent:(UIEvent *)event NS_AVAILABLE_IOS(4_0);事件。要监听到这个事件有三个前提（视图控制器UIViewController或应用程序UIApplication只有两个）
     
     启用远程事件接收（使用[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];方法）。
     对于UI控件同样要求必须是第一响应者（对于视图控制器UIViewController或者应用程序UIApplication对象监听无此要求）。
     应用程序必须是当前音频的控制者，也就是在iOS 7中通知栏中当前音频播放程序必须是我们自己开发程序。
 
 
     我们将远程控制事件放到视图控制器（事实上很少直接添加到UI控件，一般就是添加到UIApplication或者UIViewController），模拟一个音乐播放器。
     
     1.首先在应用程序启动后设置接收远程控制事件，并且设置音频会话保证后台运行可以播放（注意要在应用配置中设置允许多任务）
     //在 AppDelegate.m 中的 remoteCtrlAction方法实现了上诉需求
    
     2.在视图控制器中添加远程控制事件并音频播放进行控制
 
     注意：
     
     为了模拟一个真实的播放器，程序中我们启用了后台运行模式，配置方法：在info.plist中添加UIBackgroundModes并且添加一个元素值为audio。
     即使利用线控进行音频控制我们也无法监控到耳机增加音量、减小音量的按键操作（另外注意模拟器无法模拟远程事件，请使用真机调试）。
     子事件的类型跟当前音频状态有直接关系，点击一次播放/暂停按钮究竟是【播放】还是【播放/暂停】状态切换要看当前音频处于什么状态，如果处于停止状态则点击一下是播放，如果处于暂停或播放状态点击一下是暂停和播放切换。
     上面的程序已在真机调试通过，无论是线控还是点击应用按钮都可以控制播放或暂停。
 */

#import "RemoteCtrlVC.h"
#import "Tools.h"
#import "PlaySound.h"

@interface RemoteCtrlVC ()
{
    UIButton            *_playButton;
    BOOL                _isPlaying;
    PlaySound           *_player;
    
}
@end

@implementation RemoteCtrlVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initRemoteCtrlUI];
    [Tools toast:@"尚未耳机测试" andCuView:self.view];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _player = [[PlaySound alloc] initWithFileName:@"直到世界的尽头" isLoopPlayBack:YES];

}

- (void)initRemoteCtrlUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"远程控制事件";
    
    //专辑封面
    UIImage *image = [UIImage imageNamed:@"charater_caizi"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-80)];
    
    imageView.image = image;
    [self.view addSubview:imageView];
    //播放控制面板
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight - 80, screenWidth, 80)];
    view.backgroundColor = RGB2Color(40, 43, 53);
    [self.view addSubview:view];
    
    //添加播放按钮
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.bounds = CGRectMake(0, 0, 44, 44);
    _playButton.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [self changeUIState];
    [_playButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_playButton];
    
}


#pragma mark 远程控制事件[监听耳机]
-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    NSLog(@"%li,%li",(long)event.type, (long)event.subtype);
    
    if(event.type==UIEventTypeRemoteControl)
    {
        switch (event.subtype)
        {
            case UIEventSubtypeRemoteControlPlay:
                [_player playSound];
                _isPlaying=true;
                break;
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if (_isPlaying)
                {
                    [_player stopSound];
                }
                else
                {
                    [_player playSound];
                }
                _isPlaying = !_isPlaying;
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"Next...");
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"Previous...");
                break;
                
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                NSLog(@"Begin seek forward...");
                break;
                
            case UIEventSubtypeRemoteControlEndSeekingForward:
                NSLog(@"End seek forward...");
                break;
                
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                NSLog(@"Begin seek backward...");
                break;
                
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                NSLog(@"End seek backward...");
                break;
                
            default:
                break;
        }
        [self changeUIState];
        
    }
    
}

#pragma mark 界面状态 更改音乐按钮的状态图标
-(void)changeUIState
{
    if(_isPlaying)
    {
        [_playButton setImage:[UIImage imageNamed:@"stopNormal"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"stopHighlight"] forState:UIControlStateHighlighted];
        
    }
    else
    {
        [_playButton setImage:[UIImage imageNamed:@"playNormal"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"playHighlight"] forState:UIControlStateHighlighted];
        
    }
    
}

- (void)btnClick:(UIButton *)btn
{
    if (_isPlaying)
    {
        [_player stopSound];
        
    }
    else
    {
        [_player playSound];
        
    }
    _isPlaying = !_isPlaying;
    [self changeUIState];
    
}

//是否让当前控制器 成为 第一响应者
- (BOOL)canBecomeFirstResponder
{
    return NO;// YES?
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _playButton = nil;
    _player     = nil;
    _isPlaying  = nil;
    
}

@end
