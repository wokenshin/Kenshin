//
//  SDHeadCell.h
//  GYBase
//
//  Created by doit on 16/5/11.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*———————————————————————————定义协议—————————————————————————————————————*/
@class SDHeadCell;

@protocol SDHeadCellDelegate <NSObject>

@optional
-(void)pressHeadImgChangeHeader:(SDHeadCell *)cell;

@end
/*———————————————————————————定义协议—————————————————————————————————————*/

@interface SDHeadCell : UITableViewCell

/*———————————————————————————定义协议属性—————————————————————————————————————*/
@property (nonatomic, weak) id<SDHeadCellDelegate> delegate;

//初始化函数
- (instancetype)initWithFrame:(CGRect)frame;

@end
