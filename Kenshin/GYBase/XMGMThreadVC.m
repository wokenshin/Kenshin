//
//  XMGMThreadVC.m
//  GYBase
//
//  Created by kenshin on 16/8/23.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "XMGMThreadVC.h"
#import "LiaoJieThreadVC.h"
#import "LiaoJiePThreadVC.h"
#import "ZWNSThreadVC.h"
#import "ThreadStatesVC.h"
#import "ThreadMsgVC.h"
#import "ThreadSafeVC.h"
#import "XMG_GCDVC.h"
#import "XMGNSOperationVC.h"

@interface XMGMThreadVC ()

@end

@implementation XMGMThreadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"多线程部分-fromXMG";
    
}

//了解
- (IBAction)btnLiaoJie:(id)sender
{
    LiaoJieThreadVC *vc = [LiaoJieThreadVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//C语言操作线程的知识 作为了解 今后几乎用不到
- (IBAction)btnPThread:(id)sender
{
    LiaoJiePThreadVC *vc = [LiaoJiePThreadVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//掌握 NSThread
- (IBAction)btnNSThread:(id)sender
{
    ZWNSThreadVC *vc = [ZWNSThreadVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//了解 线程的状态
- (IBAction)btnThreadState:(id)sender
{
    ThreadStatesVC *vc = [ThreadStatesVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//线程间的通信
- (IBAction)btnThreadMsg:(id)sender
{
    ThreadMsgVC *vc = [ThreadMsgVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//线程安全
- (IBAction)btnThreadSafe:(id)sender
{
    ThreadSafeVC *vc = [ThreadSafeVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//GCD
- (IBAction)btnGCD:(id)sender
{
    XMG_GCDVC *vc = [XMG_GCDVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//NSOperation
- (IBAction)btnNSOperation:(id)sender
{
    XMGNSOperationVC *vc = [XMGNSOperationVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
