//
//  BlockBaseVC.m
//  GYBase
//
//  Created by kenshin on 17/1/24.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "BlockBaseVC.h"
#import "BlockBaseVC2.h"

@interface BlockBaseVC ()

@end

@implementation BlockBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBlockBaseUI];
    
}

- (void)initBlockBaseUI
{
    self.navigationItem.title = @"block基础篇";
    
}

/**
*  无参数无返回值的Block
*/
- (IBAction)btnBlockOne:(id)sender
{
    /**
     *  void ：就是无返回值
     *  emptyBlock：就是该block的名字
     *  ()：这里相当于放参数。由于这里是无参数，所以就什么都不写
     */
    NSLog(@"1");
    void (^emptyBlock)() = ^(){
        NSLog(@"无参数,无返回值的Block");
    };
    NSLog(@"2");
    emptyBlock();//代码块中的内容 是在执行代码块的时候才会制定的，这段代码相当于是保存起来了 在调用代码块的时候才去执行他
    NSLog(@"3");

    
}

/**
 *  有参数无返回值的Block
 */
- (IBAction)btnBlockTwo:(id)sender
{
    /**
     *  调用这个block进行两个参数相加
     *
     *  @param int 参数A
     *  @param int 参数B
     *
     *  @return 无返回值
     */
    NSLog(@"1");
    void (^sumBlock)(int ,int ) = ^(int a,int b){
        NSLog(@"%d + %d = %d",a,b,a+b);
    };
    /**
     *  调用这个sumBlock的Block，得到的结果是20
     */
    NSLog(@"2");
    sumBlock(10,10);
    NSLog(@"3");
    
}

/**
 *  有参数有返回值的Block
 */
- (IBAction)btnBlockThree:(id)sender
{
    /**
     *  有参数有返回值
     *
     *  @param NSString 字符串1
     *  @param NSString 字符串2
     *
     *  @return 返回拼接好的字符串3
     */
    NSLog(@"1");
    NSString* (^logBlock)(NSString *,NSString *) = ^(NSString * str1,NSString *str2){
        return [NSString stringWithFormat:@"%@%@",str1,str2];
    };
    //调用logBlock,输出的是 我是Block
    NSLog(@"2");
    NSLog(@"%@", logBlock(@"我是",@"Block"));
    NSLog(@"3");
    
}

- (IBAction)btnBlockWithTypeOf:(id)sender
{
    BlockBaseVC2 *vc = [[BlockBaseVC2 alloc] init];
    // 回调修改颜色
    vc.backgroundColor = ^(UIColor *color){
        self.view.backgroundColor = color;
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
