//
//  BlockButton.m
//  BaseGY
//
//  Created by doit on 16/4/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        //可以给不同的事件 设置不同的block
        [self addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;

}

- (void)touchAction
{
    //调用代码块
    if (_block) {
        _block(self);
    }
    
    
}

@end
