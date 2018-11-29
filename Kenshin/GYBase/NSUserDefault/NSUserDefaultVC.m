//
//  NSUserDefaultVC.m
//  GYBase
//
//  Created by kenshin on 17/2/5.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "NSUserDefaultVC.h"
#import "UDINPROVC.h"

@interface NSUserDefaultVC ()
@property (nonatomic, strong) NSArray       *shaHeArr;
@end

@implementation NSUserDefaultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)saveArrAction:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = @[@{@"key1":@"fww", @"key2":@"csq"},
                     @{@"key1":@"fxw", @"key2":@"zsh"},
                     @{@"key1":@"fxw", @"key2":@"kodoko"}];
    [userDefaults setObject:arr forKey:@"arr"];
    
    _shaHeArr = [NSArray array];
    _shaHeArr = arr;
}

- (IBAction)readArrAction:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefaults objectForKey:@"arr"];
    if ([arr count] > 0) {
        NSDictionary *dic = [arr objectAtIndex:0];
        NSLog(@"%@", dic);
    }
    NSLog(@"%@", arr);
    
    if ([_shaHeArr count] > 0)
    {
        NSDictionary *a = [_shaHeArr lastObject];
        NSLog(@"%@", a);
    }
    
}

- (IBAction)saveNilBreak:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:[NSNull null] forKey:@"NIL"];
    
    [userDefaults setObject:mDic forKey:@"NIL"];
    
}

- (IBAction)saveNilOk:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:[NSNull null] forKey:@"NIL"];
    
    NSData *data =    [NSJSONSerialization dataWithJSONObject:mDic options:NSJSONWritingPrettyPrinted error:nil];
    
    [userDefaults setObject:data forKey:@"NIL"];
    
}

- (IBAction)readNil:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults dataForKey:@"NIL"];
    
    //data转字典
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *value = [jsonDict objectForKey:@"NIL"];
    if (value == nil)
    {
        NSLog(@"value == nil");
    }
    if ([value isEqual:[NSNull null]])
    {
        NSLog(@"value == null");
    }
    
    NSLog(@"%@", jsonDict);
    
}

- (IBAction)xmzdyy:(id)sender
{
    UDINPROVC *vc = [[UDINPROVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
