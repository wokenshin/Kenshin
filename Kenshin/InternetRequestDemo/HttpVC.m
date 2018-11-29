//
//  HttpVC.m
//  GYBase
//
//  Created by doit on 16/4/13.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "HttpVC.h"
#import "BlockButton.h"
#import "UIButtonK.h"
#import "Tools.h"
#import "AFHTTPSessionManager.h"
#import "AFNDemo.h"
#import "HttpDemoVC.h"

@interface HttpVC ()

@end

@implementation HttpVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    
    //fromhttp://www.hcios.com/archives/1207 同步请求
    [self getRequestBtnUI]; //明文
    [self postRequestBtnUI];//隐藏
    [self postAsynRequestUI];//异步请求
    
    //from http://www.hcios.com/archives/1406
    [self afnBase];
    
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"网络请求";
    
    //仿照贵阳项目 运用afn 建立网络请求
    UIButtonK *btn = [[UIButtonK alloc] initWithFrame:CGRectMake(200, 64 + margin_10, 100, 44)];
    [btn setTitle:@"AFN 综合" forState:UIControlStateNormal];
    [btn setStyleGreen];
    WS(ws);
    [self.view addSubview:btn];
    btn.clickButtonBlock = ^(UIButtonK *b){
        AFNDemo *vc = [AFNDemo new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    UIButtonK *btn2 = [[UIButtonK alloc] initWithFrame:CGRectMake(200, 64 + margin_10*2 + 44, 100, 44)];
    [btn2 setTitle:@"原生 综合" forState:UIControlStateNormal];
    [btn2 setStyleGray];
    [self.view addSubview:btn2];
    btn2.clickButtonBlock = ^(UIButtonK *b){
        HttpDemoVC *vc = [HttpDemoVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
}


#pragma mark 异步请求UI
- (void)postAsynRequestUI
{
    BlockButton *asynPostBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10 + 250, 100, height_normal)];
    [asynPostBtn setTitle:@"异步请求" forState:UIControlStateNormal];
    asynPostBtn.backgroundColor = colorMyButton;
    [self.view addSubview:asynPostBtn];
    WS(ws);
    asynPostBtn.block = ^(BlockButton *btn)
    {
        [ws postAsynReques];
    };
    
}

#pragma mark 异步请求
- (void)postAsynReques
{
    // 1.获取请求网址
    NSURL *url = [NSURL URLWithString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?"];
    
    // 2.封装请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];  // post
    
    // 设置请求方式
    [request setHTTPMethod:@"POST"];
    
    // 设置请求体(会把请求的数据转成data,达到用户信息保密的目的)
    NSData *data = [@"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213" dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    // 3.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSError *newError = nil;
        // 获取数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&newError];
        
        NSArray *array = dict[@"news"];
        NSDictionary *dic = array[0];
        NSLog(@"%@", dic[@"title"]);
        
    }];
    [Tools toast:@"异步请求" andCuView:self.view];
    
}

#pragma mark 同步请求UI［get］
- (void)getRequestBtnUI
{
    BlockButton *getBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 100, height_normal)];
    [getBtn setTitle:@"GetRequest" forState:UIControlStateNormal];
    getBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:getBtn];
    WS(ws);
    getBtn.block = ^(BlockButton *btn)
    {
        [ws getRequest];
    };
    
}

#pragma mark 同步请求UI［post］
- (void)postRequestBtnUI
{
    BlockButton *postBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10 + 50, 120, height_normal)];
    [postBtn setTitle:@"PostRequest" forState:UIControlStateNormal];
    postBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:postBtn];
    WS(ws);
    postBtn.block = ^(BlockButton *btn)
    {
        [ws postRequest];
    };
    
}

#pragma mark 同步请求UI［get］
- (void)getRequest
{
    /*
     在iOS下进行网络编程主要分为以下三步
     1.客户端向服务器发送请求
     2.和服务器建立连接
     3.服务器做出响应
     */
#pragma mark - get请求
    // 1.URL
    NSURL *url = [NSURL URLWithString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213"];
    // 2.封装请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    
    // 3.发送请求
    NSURLResponse *response = nil;
    NSError *error = nil;
    // 该方法在iOS9.0之后被废弃
    // 下面的方法有3个参数，参数分别为NSURLRequest，NSURLResponse**，NSError**，后面两个参数之所以传地址进来是为了在执行该方法的时候在方法的内部修改参数的值。这种方法相当于让一个方法有了多个返回值
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // 错误信息
    if(error)
    {
        NSLog(@"%@", [error localizedDescription]);
        // 此处需要解决iOS9.0之后，HTTP不能正常使用的问题，若不做任何处理，会打印“The resource could not be loaded because the App Transport Security policy requires the use of a secure connection” 错误信息。
    }
    NSError *newError = nil;
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&newError];
    // 获取对应的数据信息
    NSArray *array = dictionary[@"news"];
    NSDictionary *dic = array[0];
    NSLog(@"%@", dic[@"title"]);
    [Tools toast:@"同步请求 get" andCuView:self.view];
    
}

#pragma mark 同步请求［post］
- (void)postRequest
{
    // 1.获取请求网址
    NSURL *url = [NSURL URLWithString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?"];
    
    // 2.封装请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];  // post
    
    // 设置请求方式
    [request setHTTPMethod:@"POST"];
    
    // 设置请求体(会把请求的数据转成data,达到用户信息保密的目的)
    NSData *data = [@"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213" dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    // 3.发送请求
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *content = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSError *newError = nil;
    // 获取数据
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&newError];
    
    
    NSArray *array = dict[@"news"];
    NSDictionary *dic = array[0];
    NSLog(@"%@", dic[@"title"]);
    [Tools toast:@"同步请求 post" andCuView:self.view];

}


#pragma AFNetworking post请求
- (void)afnBase
{
    BlockButton *postBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 250, 100, height_normal)];
    postBtn.backgroundColor = colorNavBar;
    [postBtn setTitle:@"AFN test" forState:UIControlStateNormal];
    [self.view addSubview:postBtn];
    WS(ws);
    //点击 按钮时触发block
    postBtn.block = ^(BlockButton *btn){
        [ws afnPost];
    };
    
}

#pragma mark AFNetworking 基础学习
- (void)afnPost
{
    // 请求的参数
    NSDictionary *parametersDic = @{@"date"         :@"20131129",
                                    @"startRecord"  :@"1",
                                    @"len"          :@"5",
                                    @"udid"         :@"1234567890",
                                    @"terminalType" :@"Iphone",
                                    @"cid"          :@"213"};
    
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // post请求
    NSString *urltr = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?";
    
    [manager POST:urltr parameters:parametersDic
     constructingBodyWithBlock:^(id  _Nonnull formData)
     {
         // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
         //NSLog(@"formData-------%@", formData);
         
     }
     progress:^(NSProgress * _Nonnull uploadProgress)
     {
         // 这里可以获取到目前的数据请求的进度
         // NSLog(@"uploadProgress------%@", uploadProgress);
         
     }
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         // 请求成功，解析数据
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         
         NSArray *newsArr = [dic objectForKey:@"news"];
         for (int i = 0; i < [newsArr count]; i++)
         {
             
             NSDictionary *newsDic = [newsArr objectAtIndex:i];
             
             NSString *cname   = [newsDic objectForKey:@"cname"];
             NSString *title   = [newsDic objectForKey:@"title"];
             NSString *type    = [newsDic objectForKey:@"type"];
             NSString *summary = [newsDic objectForKey:@"summary"];
             
             NSLog(@"\ncname == %@\n title == %@\n type == %@\n summary == %@", cname, title, type, summary);
             NSLog(@"————————————————————————————————————————————————————————————————");
         }
         
         //            NSLog(@"请求成功---dic--%@", dic);
         
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         // 请求失败
         NSLog(@"请求失败-----error----%@", [error localizedDescription]);
     }];
    [Tools toast:@"AFN POST 异步请求" andCuView:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
