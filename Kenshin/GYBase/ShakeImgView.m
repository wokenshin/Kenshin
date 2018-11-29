//
//  ShakeImgView.m
//  GYBase
//
//  Created by doit on 16/5/26.
//  Copyright © 2016年 kenshin. All rights reserved.
//
#define kImageCount 4
#import "ShakeImgView.h"

@implementation ShakeImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.image=[self getImage];
        
    }
    return self;
    
}

#pragma mark 设置控件可以成为第一响应者
-(BOOL)canBecomeFirstResponder
{
    return YES;
    
}

#pragma mark 运动开始
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //这里只处理摇晃事件
    if (motion==UIEventSubtypeMotionShake)
    {
        self.image=[self getImage];
        
    }
    NSLog(@"运动开始");
    
}
#pragma mark 运动结束
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"运动结束");
    
}


#pragma mark 随机取得图片
-(UIImage *)getImage
{
    int index = arc4random() % kImageCount;
    NSString *imageName = [NSString stringWithFormat:@"shake%i", index];//shake0, shake1, shake2
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
    
}

@end
