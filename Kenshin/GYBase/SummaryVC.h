//
//  OneVC.h
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//  故事该要 MVC 设计模式 参考的是 以前的 李明杰 微博table
/*
    cell 的高度是根据内容的多少来计算的————————其实是计算了最后一个label的y值
 
    数据源 是从 plist中获取的[也可以从 数据库 网络中获取]
 */

#import <UIKit/UIKit.h>

@interface SummaryVC : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@end
