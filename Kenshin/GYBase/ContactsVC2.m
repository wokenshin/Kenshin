//
//  ContactsVC2.m
//  GYBase
//
//  Created by doit on 16/5/20.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ContactsVC2.h"
#import "Tools.h"

#import <AddressBook/AddressBook.h>

@interface ContactsVC2 ()

@end

@implementation ContactsVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initContactsVC2UI];
    
    //获取用户授权
    [self userAuthorization];
}

- (void)initContactsVC2UI
{
    self.navigationItem.title = @"获取通讯录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

#pragma mark - 获取用户授权
- (void)userAuthorization
{
    [Tools toast:@"用时现学easy" andCuView:self.view];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
