//
//  ContactsVC.m
//  GYBase
//
//  Created by doit on 16/5/20.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ContactsVC.h"
#import "Tools.h"
#import "RegexUtil.h"
#import "UIButtonK.h"
#import "ContactsVC2.h"

#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

@interface ContactsVC ()<ABPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong)UITableView        *tableview;

@end

@implementation ContactsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initContactsUI];
    
}

- (void)initContactsUI
{
    self.navigationItem.title = @"通讯录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    WS(ws);
    CGFloat x = screenWidth/2.0 - screenWidth*0.5/2.0;
    //调用系统的通讯录
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(x, 64 + 100, screenWidth*0.5, 44)];
    [btn setTitle:@"系统通讯录" forState:UIControlStateNormal];
    [btn setYuanJiao];
    [btn setBackgroundNormalColor:RGB2Color(130, 130, 130)];
    [btn setBackgroundHeightlightColor:RGB2Color(150, 150, 150)];
    btn.clickButtonBlock = ^(UIButtonK *btn)
    {
        [ws initContacts];
        
    };
    
    //读取通讯录
    UIButtonK *btn2 = [[UIButtonK alloc] initWithFrame:CGRectMake(x, 64 + 200, screenWidth*0.5, 44)];
    [btn2 setTitle:@"读取通讯录" forState:UIControlStateNormal];
    [btn2 setYuanJiao];
    [btn2 setBackgroundNormalColor:RGB2Color(130, 130, 130)];
    [btn2 setBackgroundHeightlightColor:RGB2Color(150, 150, 150)];
    btn2.clickButtonBlock = ^(UIButtonK *btn)
    {
        ContactsVC2 *vc = [ContactsVC2 new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };

    [self.view addSubview:btn];
    [self.view addSubview:btn2];
    
}

//然后初始化ABPeoplePickerNavigationController
- (void)initContacts
{
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.peoplePickerDelegate = self;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        //在iOS8之后，需要添加nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        //这一段代码，否则选择联系人之后会直接dismiss，不能进入详情选择电话。
        
    }
    //进入通讯录控制器
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark 代理
//取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    //删除通讯录控制器
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark iOS8下
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    if ([phoneNO hasPrefix:@"+"])
    {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if (phone && [RegexUtil isValidTelePhone:phoneNO])
    {
//        phoneNum = phoneNO;
        [self.tableview reloadData];
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}

#pragma mark IOS7下
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    if ([phoneNO hasPrefix:@"+"])
    {
        phoneNO = [phoneNO substringFromIndex:3];
        
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if (phone && [RegexUtil isValidTelePhone:phoneNO])
    {
//        phoneNum = phoneNO;
        [self.tableview reloadData];
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
