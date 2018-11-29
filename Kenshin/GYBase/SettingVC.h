//
//  FiveVC.h
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    数据都保存到沙盒中，图片保存到Doucuments中
    
 
 */

#import <UIKit/UIKit.h>
#import "BlockButton.h"

@interface SettingVC : UIViewController<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray            *cellsData;//数据源
@property (nonatomic, strong) UITableView               *tableview;
@property (nonatomic, strong) BlockButton               *loginOutBtn;
@property (nonatomic, strong) UIAlertController         *alertController;
@property (nonatomic, strong) UIImagePickerController   *picker;


@end
