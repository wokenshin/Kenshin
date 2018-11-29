//
//  CharacterCell.h
//  GYBase
//
//  Created by doit on 16/4/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CharacterModel;

@interface CharacterCell : UITableViewCell

@property (nonatomic, strong) CharacterModel *modelCharacter;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
