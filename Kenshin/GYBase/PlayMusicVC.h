//
//  PlayMusicVC.h
//  GYBase
//
//  Created by doit on 16/4/27.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaySound.h"
#import "UIControlK.h"

@interface PlayMusicVC : UIViewController

@property (nonatomic, assign)BOOL        isPlaying;
@property (nonatomic, strong)PlaySound   *player;
@property (nonatomic, strong)UIControlK  *musicCtrl;

@end
