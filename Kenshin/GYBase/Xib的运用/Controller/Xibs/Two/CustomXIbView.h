//
//  CustomXIbView.h
//  GYBase
//
//  Created by kenshin on 16/8/26.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置代理的第一步
@class CustomXIbView;

@protocol CustomXIbViewDelegate <NSObject>

@optional


-(void)customXIbViewChangeImg:(CustomXIbView *)itemView;  //切换图片
-(void)customXIbViewSetImgAlpha:(CustomXIbView *)itemView;//设置图片透明度
-(void)customXIbViewLeftSwitch:(CustomXIbView *)itemView; //左边的开关
-(void)customXIbViewRightSwitch:(CustomXIbView *)itemView;//右边的开关

@end


@interface CustomXIbView : UIView


//设置代理的第二步
@property (nonatomic, weak) id<CustomXIbViewDelegate> delegate;



@property (weak, nonatomic) IBOutlet UISegmentedControl         *segment;
@property (weak, nonatomic) IBOutlet UIImageView                *img;
@property (weak, nonatomic) IBOutlet UISlider                   *alphaImageSlider;
@property (weak, nonatomic) IBOutlet UISwitch                   *switchLeft;
@property (weak, nonatomic) IBOutlet UISwitch                   *switchRight;


@end
