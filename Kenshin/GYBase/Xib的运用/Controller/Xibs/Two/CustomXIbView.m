//
//  CustomXIbView.m
//  GYBase
//
//  Created by kenshin on 16/8/26.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CustomXIbView.h"


@implementation CustomXIbView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *nibName = NSStringFromClass([self class]);
        self = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}


//切换图片  分段选择
- (IBAction)segmentChangeImg:(id)sender {
    if (self.delegate != nil) {
        [self.delegate customXIbViewChangeImg:self];
    }
    
}

//设置图片 透明度
- (IBAction)setImageAlpha:(id)sender {
    if (self.delegate != nil) {
        [self.delegate customXIbViewSetImgAlpha:self];
    }
    
}

//左边的开关
- (IBAction)leftSwitch:(id)sender {
    if (self.delegate != nil) {
        [self.delegate customXIbViewLeftSwitch:self];
    }
    
}

//右边的开关
- (IBAction)rightSwitch:(id)sender {
    if (self.delegate != nil) {
        [self.delegate customXIbViewRightSwitch:self];
    }
}


@end
