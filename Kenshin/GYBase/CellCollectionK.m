//
//  CellCollectionK.m
//  GYBase
//
//  Created by kenshin on 16/8/18.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "CellCollectionK.h"

@interface CellCollectionK()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation CellCollectionK

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        
        [self.contentView addSubview:imageView];
    }
    
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
    self.imageView.frame = self.bounds;
}


@end
