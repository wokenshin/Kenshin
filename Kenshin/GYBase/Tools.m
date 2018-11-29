//
//  Tools.m
//  GYBase
//
//  Created by doit on 16/4/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "Tools.h"
#import "AFNetworkReachabilityManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>//判断用户是否有权限访问相册

//iOS7之前都可以访问相机，iOS7之后访问相机有权限设置
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@implementation Tools

#pragma mark 单例 demoCode
+ (Tools *)shareTools
{
    static Tools *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[Tools alloc] init];
        
    });
    
    return sharedAccountManagerInstance;
    
}



#pragma mark 设置UI圆角
+ (void)setCornerRadiusWithView:(UIView *)view andAngle:(CGFloat)angle
{
    view.layer.cornerRadius  = angle; //本行代码在IOS6中就可以给label设置圆角，但是在IOS7中不行，还需要再加上下面一行代码
    view.layer.masksToBounds = YES;   //默认是NO,超出主层边界的内容统统剪掉
    
}

#pragma mark 设置边框
+ (void)setBorder:(UIView *)view andColor:(UIColor *)backColor andWidth:(CGFloat)width
{
    view.layer.borderColor = [backColor CGColor];
    view.layer.borderWidth = width;
    
}

#pragma mark 吐司
+ (void)toast:(NSString *)content andCuView:(UIView *)cuView
{
    UILabel *label = [[UILabel alloc] init];
    label.text = content;
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;//内容居中
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, screenWidth*0.8, screenHeight*0.07);
    label.center = CGPointMake(screenWidth/2, screenHeight*0.85);
    label.alpha = 0.0;//这里讲透明度设置为完全透明，是为了让它在之后渐渐显示出来。
    
    //设置圆角
    [Tools setCornerRadiusWithView:label andAngle:10];
    
    [cuView addSubview:label];
    
    //动画
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 0.5;
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
             
             label.alpha = 0.0;
             
         } completion:^(BOOL finished)
          {
              [label removeFromSuperview];//将label从控制器中移除【也从内存中释放了】
              
          }];
     }];
    
}

+ (void)toast:(NSString *)content andCuView:(UIView *)cuView andHeight:(CGFloat)height
{
    UILabel *label = [[UILabel alloc] init];
    label.text = content;
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;//内容居中
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, screenWidth*0.8, screenHeight*0.07);
    label.center = CGPointMake(screenWidth/2, height);
    label.alpha = 0.0;//这里讲透明度设置为完全透明，是为了让它在之后渐渐显示出来。
    
    //设置圆角
    [Tools setCornerRadiusWithView:label andAngle:10];
    
    [cuView addSubview:label];
    
    //动画
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 0.5;
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
             
             label.alpha = 0.0;
             
         } completion:^(BOOL finished)
          {
              [label removeFromSuperview];//将label从控制器中移除【也从内存中释放了】
              
          }];
     }];
    
}
#pragma mark 多行文本 定宽 不定高 demoCode
+ (UILabel *)manyLineLab:(NSString *)contents andTextFount:(UIFont *)font
{
    //注意！ 这里需要注意两处：
    //1.设置好lab的高度，高度小了 自动换行了也看不到
    //2.将lab的 numberOfLines属性 设置为0
    
    //获取文本长度
    CGSize labSize = [Tools sizeOfTheText:contents font:font maxSize:CGSizeMake(300, MAXFLOAT)];
    UILabel *manyLineLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, labSize.height)];
    manyLineLab.numberOfLines = 0;
    manyLineLab.text = contents;
    
    return manyLineLab;
    
}

+ (void)toastImage:(NSString *)content andImgName:(NSString *)imgName andCuView:(UIView *)cuView
{
    //实现起来 和 toast的原理一样，
    //用一个 view add进去 一个imgview add进去 一个label
}

#pragma mark 弹出框demoCode 已不推荐使用 可查看AlertUI group下面的控制器 代码
+ (void)alertDemoCode
{
    //如果有多个弹出框 可以设置tag 区分
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:@"请选择一个按钮:"
                                                 delegate:self
                                        cancelButtonTitle:@"否"
                                        otherButtonTitles:@"是", nil];
    [alert show];
    
    
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:@"老兄！你他么联网了没！?"
                                                    delegate:self
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    //关联代码 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
}

+ (void)TipsAlertWithTitle:(NSString *)title andContent:(NSString *)content andCu:(id)ws
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无可用网络"
                                                                             message:@"请连接网络后重试"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             
                                                         }];
    
    [alertController addAction:cancelAction];
    [ws presentViewController:alertController animated:YES completion:nil];
    
}
//当弹出框按钮被点击后触发，如果有多个弹出框 可以通过tag 来区分
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            NSLog(@"0");
            break;
            
        case 1:
            NSLog(@"1");
            break;
            
        default:
            break;
    }
}

#pragma mark 注册远程推送
+ (void)registerRemoteNotification
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                                               UIRemoteNotificationTypeAlert |
                                                                               UIRemoteNotificationTypeSound)];
    }
}

#pragma mark 本地通知 参考
+ (void)localNotice
{
    //1.在需要发送通知的地方 发送通知
    
    //2.在需要接收通知的地方 接收通知
    
    //3.在接收通知的地方    删除通知
    
    //4.主义 避免重复发送通知
    
    NSString *noticeName = @"这个可以理解成通知的唯一标志";
    
    //在A类中：
    //1 发送通知[如果 没有dic 可以 userInfo 可以设置为 nil]
    NSDictionary *infoDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"value", @"key", nil];
    NSNotification *notification = [NSNotification notificationWithName:noticeName object:nil userInfo:infoDic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    //在B类中：
    //2 接收通知 [如果1中 userInfo == nil 下面的 function 可以不带参数 即 去掉双引号]
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(function:) name:noticeName object:nil];
    
    //3 删除通知
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:noticeName object:nil];
    
}

//由接收通知的函数 触发的 函数
- (void)function:(NSNotification *)userInfo
{
    //    NSDictionary* dic = [userInfo userInfo];
    
}

#pragma mark 监测网络
+ (void)checkNetStatus
{
    //    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //    [reachabilityManager startMonitoring];//打开监测
    //
    //    //监测网络状态回调
    //    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //        switch (status)
    //        {
    //            case AFNetworkReachabilityStatusUnknown://未知
    //            {
    //                [Tools NSLogMyFunction:@"网络状况 未知！"];
    //            }
    //            break;
    //
    //            case AFNetworkReachabilityStatusNotReachable://无连接
    //            {
    //                //基本上监测到无连接 给出友好提示就够了
    //                [Tools NSLogMyFunction:@"网络状况 无连接！"];
    //            }
    //            break;
    //
    //            case AFNetworkReachabilityStatusReachableViaWWAN://3G
    //            {
    //                [Tools NSLogMyFunction:@"网络状况 3G！"];
    //            }
    //            break;
    //
    //            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi
    //            {
    //                [Tools NSLogMyFunction:@"网络状况 WiFi！"];
    //            }
    //            break;
    //
    //            default:
    //                [Tools NSLogMyFunction:@"监测网络状况 出错哦！！！"];
    //                break;
    //        }
    //    }];
    
}

#pragma mark - 是否开启权限
//是否开启远程通知
+ (BOOL)fxwIsOpenAPNS
{
    //如果没有开发接收通知的功能 提醒用户打开
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone)
    {
        return NO;
    }
    return YES;
    
}


//是否开启相机
+ (BOOL)fxwIsOpenCamera
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
    
}

//是否开启运动与健康[这个地方可能不需要单独判断]
+ (BOOL)fxwIsOpenHealthData
{
    //其实是需要判断两部：第一步是判断是否设备具有计步器的功能【监测芯片是否可用】
    //第二步是判断用户是否开启 运动与健康 的数据访问权限
    
    return YES;
    
}

//是否开启麦克风
+ (BOOL)fxwIsOpenMicrophone
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)])
        {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted)
            {
                if (granted)
                {
                    bCanRecord = YES;
                }
                else
                {
                    bCanRecord = NO;
                }
            }];
        }
    }
    
    return bCanRecord;
    
}

#pragma mark 简单动画
+ (void)animationDemoCode
{
    //位移动画
    
    //渐变动画   参考 AnimationVC
    
    //旋转动画
}

#pragma mark 旋转ui
+ (void)transformWithView:(UIView *)view andWithDegrees:(CGFloat)degrees
{
    //    view.transform = CGAffineTransformMakeRotation(M_PI);
    view.transform = CGAffineTransformMakeRotation(degrees);
}

#pragma mark 计算文本的长度
+ (CGSize)sizeOfTheText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGFloat) widthWithTheText:(NSString *)text andFont:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, 1000);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}

#pragma mark 定时器
+ (void)nstimerDemoCode
{
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(cicyleFunction) userInfo:nil repeats:YES];
}

//- (void)cicyleFunction
//{
//
//}

#pragma 设备功能
+ (void)deviceFunctionOfBalaBala
{
    //no sleep
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];//静止休眠
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];//当靠近听筒时将屏幕变黑[离开听筒后会变亮]
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];// 注意！ 在释放资源的时候 关闭红外感应
    
    //震动 //需要导入 AVFoundation 框架
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
}

#pragma mark 隐藏软键盘 demoCodes
+ (void)hiddenKeyboard
{
    //方式一 关闭当前响应弹出软键盘的 text
    //    [yourTextField resignFirstResponder];
    
    //方式二 点击背景关闭软键盘 (你的view 必须集成UIControl)
    //    [self.view endEditing:YES];
    
    //方式三 可在任何地方加上这句话，可以用来统一收起键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    //方式四 点击软键盘上的return按钮 关闭软键盘 (需要实现代理:UITextFieldDelegate)
    //然后 实现对应的代理方法
    //    self.yourTextField.delegate = self;
    /*
     
     //点击return 按钮 关闭软键盘
     -(BOOL)textFieldShouldReturn:(UITextField *)textField
     {
     [textField resignFirstResponder];
     return YES;
     
     }
     */
    
}

#pragma mark 设置文本输入类型 demoCodes
+ (void)setTextFieldInputType
{
    //    self.txtPhoneNo.keyboardType = UIKeyboardTypeNumberPad; //只能输入数字
    //    self.txtPhoneNo.keyboardType = UIKeyboardTypePhonePad;  //数字 加 ＋* # 号码
    //...
    
}

#pragma mark - table
#pragma mark 默认选中某行cell 并滚动到该行
+(void)selectedCellWith:(UITableView *) table andIndex:(NSInteger)index andSection:(NSInteger)section
{
    NSIndexPath *ip=[NSIndexPath indexPathForRow:index inSection:section];
    [table selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
}

#pragma 设置table滚动条是否可见
+ (void)setTableViewScrollBarVisible:(UITableView *)table scrollBarVisible:(BOOL)visible
{
    table.showsVerticalScrollIndicator   = visible;
    table.showsHorizontalScrollIndicator = visible;
    
}

//隐藏分割线
+ (void)hiddenTableViewCellSeparateLine:(UITableView *)table
{
    table.separatorStyle = NO;
    
}

//局部刷新
+ (void)juBuRefreshCellOrSectionDemoCodes
{
    //    //局部section刷新
    //    NSIndexSet *nd = [[NSIndexSet alloc] initWithIndex:1]; //刷新第二个section
    //    [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationAutomatic];
    //    //局部cell刷新
    //    NSIndexPath *te=[NSIndexPath indexPathForRow:2 inSection:0];//刷新第一个section的第二行
    //    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationMiddle];
    
}

#pragma mark 自定义输出
+ (void)NSLogMyFunction:(NSString *)content
{
    NSLog(@"——————————————%@————————————————————————————————————————————————————————", content);
    
}

#pragma mark 提示某类已释放
+ (void)NSLogClassDestroy:(id)cuSelf
{
    NSLog(@"——————————————%s Destroy!!!——————————————————————————————————————————————", object_getClassName(cuSelf));
    
}

#pragma mark 导航栏样式
+ (void)setNavigationBarBackgroundColor:(UIColor *)backColor andTextColor:(UIColor *)textColor
{
    [UINavigationBar  appearance].barTintColor = backColor;
    [UINavigationBar  appearance].tintColor    = textColor;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : textColor}];
    
    
}

#pragma mark 添加导航栏按钮 左 右
+ (void)addNavigationBarButton
{
    //导航栏添加按钮
    
    //方式一： 添加系统按钮
    /*
     UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
     target:self
     action:@selector(shareItemAction)];
     NSArray *arrBtns = @[shareItem];
     self.navigationItem.rightBarButtonItems = arrBtns;
     */
    
    //方式二：添加文本按钮
    //发布按钮
    /*
     UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
     
     [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
     [rightBtn setTitleColor:RGB2Color(251, 93, 95) forState:UIControlStateNormal];
     [rightBtn setTitleColor:RGB2Color(251, 80, 80) forState:UIControlStateHighlighted];
     rightBtn.frame = CGRectMake(0, 0, 44, 44);
     rightBtn.titleLabel.font = Font7;
     
     //事件
     [rightBtn addTarget:self action:@selector(PressPublishBtn) forControlEvents:UIControlEventTouchUpInside];
     
     UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
     [self.navigationItem setRightBarButtonItem:rightBtnItem];
     */
    
    //方式三：添加自定义按钮
    /*
     eg: 需要注意 这里的图片最要是使用2倍或者3倍的 不然会显示得很的张
     UIImage *image = [UIImage imageNamed:@"defaultPic"];
     image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//IOS 7以上要设置图片渲染模式
     UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickBtnNavRight)];
     self.navigationItem.rightBarButtonItem = rightButtonItem;
     */
    
    
}

//+ (void)setNavgationBarHiddenDemoCodes
//{
//    [cuNav.navigationController setNavigationBarHidden:hidden];
//    [cuNav.navigationController setNavigationBarHidden:hidden animated:YES];
//
//}

#pragma mark 毛玻璃效果
//+ (UIImage *)maoBoLiBackImage:(NSString *)imageName;
//{
//    UIImage *sourceImage = [UIImage imageNamed:imageName];
//    UIImage *lastImage = [sourceImage applyBlurWithRadius:5
//                                                tintColor:[UIColor clearColor]
//                                    saturationDeltaFactor:1 maskImage:nil];
//    return lastImage;
//    
//}


+ (UIImage *)maoBoLiBackWithImage:(UIImage *)image
{
    UIImage *lastImage = [image applyBlurWithRadius:5
                                                tintColor:[UIColor clearColor]
                                    saturationDeltaFactor:1 maskImage:nil];
    return lastImage;
    
}

#pragma mark 裁剪图片
+ (UIImage *)cutImageWithSize:(CGSize)size originalImage:(UIImage *)originalImage
{
    
    CGSize originalsize = [originalImage size];
    NSLog(@"原始图片的宽度为%f,原始图片的高度为%f",originalsize.width, originalsize.height);
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate)//原始图片高度>宽度 即为【高图：竖屏的感觉】
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage],//y坐标从0开始
                                                    CGRectMake(0, 0,//originalsize.height/2-size.height*rate/2
                                                               originalsize.width, size.height*rate));//获取图片整体部分
        }
        else//原始图片 宽度>高度 即为【长图：横屏的感觉】
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage],
                                                    CGRectMake(originalsize.width/2-size.width*rate/2,
                                                               0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"裁剪后图片的宽度为%f,裁剪后图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage],
                                                    CGRectMake(0, originalsize.height/2-size.height/2,
                                                               originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage],
                                                    CGRectMake(originalsize.width/2-size.width/2, 0,
                                                               size.width, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"裁剪后图片的宽度为%f,裁剪后图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    else//原图为标准长宽的，不做处理
    {
        return originalImage;
    }
}

#pragma mark 获取属性列表中的值[数组]
+ (NSArray *)plistArrayTypeWithName:(NSString *)plistName//plistName eg: @"xxx.plist"
{
    if (plistName == nil || [plistName isEqualToString:@""]) {
        return nil;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    return arr;
    
}

#pragma mark 获取属性列表中的值[字典]
+ (NSDictionary *)plistDicTypeWithName:(NSString *)plistName//plistName eg: @"xxx.plist"
{
    if (plistName == nil || [plistName isEqualToString:@""]) {
        return nil;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSDictionary *dic  = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
    
}

#pragma mark 获取Documents中指定文件名的文件路径 [不建议将文件保存在 Documents 路径下， 推荐保存在 Caches文件夹下]
+ (NSString *)filePathWithDocuments:(NSString *)fileName//fileName eg: /kenshin.png
{
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath      = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, fileName];
    return filePath;
    
}

#pragma mark 添加手势事件
+ (void)setTapAction:(UIView *)tapView
{
    //添加手势事件
    UITapGestureRecognizer *greenViewClickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
    tapView.userInteractionEnabled = YES;
    [tapView addGestureRecognizer:greenViewClickTap];
    
}

- (void)clickAction
{
    
}

#pragma mark 生成随机数的代码
+ (void)randomNumDomoCodes
{
    /*
     1)、arc4random()方法：比较精确不需要生成随即种子
     使用方法如下 ：
     通过arc4random()
     
     获取0到x-1之间的整数的代码如下：
     int value = arc4random() % x;
     
     获取1到x之间的整数的代码如下:
     int value = (arc4random() % x) + 1;
     
     2)、CCRANDOM_0_1()方法：在cocos2d中使用 ，范围是[0,1]
     使用方法如下：
     float random = CCRANDOM_0_1() * 5; //[0,5]  CCRANDOM_0_1() 取值范围是[0,1]
     
     3)、random()方法： 需要初始化时设置种子
     使用方法如下：
     srandom((unsigned int)time(time_t *)NULL); //初始化时，设置下种子就好了。
     
     */
}

#pragma mark - UIApplocation［方法未测试］
//打电话
+ (void)tellPhoneWith:(NSString *)phoneNun
{
    NSString *protocol = [NSString stringWithFormat:@"tel://%@", phoneNun];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:protocol]];
    
}

//发短信
+ (void)sendMessageWith:(NSString *)contents
{
    NSString *protocol = [NSString stringWithFormat:@"tel://%@", contents];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:protocol]];
    
}

//发邮件
+ (void)sendEmailWith:(NSString *)emailAddress
{
    NSString *protocol = [NSString stringWithFormat:@"tel://%@", emailAddress];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:protocol]];
    
}

//打开网页
+ (void)openSafariWith:(NSString *)url
{
    NSString *protocol = [NSString stringWithFormat:@"tel://%@", url];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:protocol]];
    
}

+ (void)setTingTongMode
{
    //设置听筒模式
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
}

+ (void)setYangShengQiMode
{
    //设置扬声器模式
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
    
}

+ (void)setStaturBarHidden:(BOOL)hidden andIsAnimation:(BOOL)animation
{
    UIApplication *app = [UIApplication sharedApplication];
    if (animation)
    {
        [app setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationSlide];//动画效果
        
    }
    else
    {
        app.statusBarHidden = hidden;
    }
    
}

#pragma mark - 加密
//md5 加密
+ (NSString *)md5:(NSString *)content
{
    const char *cStr = [content UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}

//具体实现参见 ClearCachesVC.m
+ (CGFloat)cachesSizeDemoCodes
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    float folderSize;
    if ([fileManager fileExistsAtPath:path])
    {
        //拿到有文件的数组
        NSArray *childFile = [fileManager subpathsAtPath:path];
        
        //拿到每个文件的名字，如果有不想清除的文件 就在这判断[如 头像等]
        for (NSString *fileName in childFile)
        {
            NSLog(@"%@", fileName);
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize += [Tools fileSizePath:fullPath];
            
        }
    }
    
    //    NSString *cachesSize = [NSString stringWithFormat:@"%.2f", folderSize];//保留小数点后两位
    //    NSString *cachesSize = [NSString stringWithFormat:@"当前缓存为：%fM", folderSize];
    
    return folderSize;
    
}

//计算指定路径下某个文件的大小
+ (float)fileSizePath:(NSString*)path
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])
    {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
        
    }
    return 0;
    
}

+ (void)clearCachesDemoCodes
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childFiles)
        {
            //如果有需要 加入体检 过滤掉不删除的文件[如 头像等]
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
        
    }
    
}

#pragma mark 设置app通知数
+ (void)setAppNoticeNum:(NSInteger) noticesNum
{
    UIApplication *app = [UIApplication sharedApplication];
    float versionNumber = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (versionNumber >= 8.0)//提示用户是否允许通知
    {
        //通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        //接收用户的选择
        [app registerUserNotificationSettings:settings];
        
    }
    
    app.applicationIconBadgeNumber = noticesNum;
    
}

#pragma mark 清空app通知数
+ (void)clearAppNoticeNum
{
    [Tools setAppNoticeNum:0];
    
}

#pragma mark 加载头像
+ (UIImage *)loadHeadImage
{  //从Documents中获取图片
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *headerName    = @"/user_head_img.png";
    NSString *filePath      = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, headerName];
    UIImage* img = [[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:filePath,NSHomeDirectory()]];
    
    if (img != nil)
    {
        return img;
        
    }
    else
    {
        return [UIImage imageNamed:@"default_head"];//默认头像
        
    }
    
}

#pragma mark 画虚线 注意高度设置为1
/** 注意 view的高度就是虚线的高度 参考值[self drawDashLine:testView lineLength:4 lineSpacing:2 lineColor:[UIColor lightGrayColor]];
 
 ** lineView:	   需要绘制成虚线的view  参考值
 ** lineLength:	   虚线的宽度            4
 ** lineSpacing:   虚线的间距            2
 ** lineColor:	   虚线的颜色            灰色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
    
}

+ (NSDictionary *)JsonStringToDictionaryWith:(NSString *)jsonString
{
    NSData *JSONData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    return responseJSON;
}

+ (void)pushCuVC:(UINavigationController *)cuNav toNextVC:(UIViewController *)nextVC andCuNetState:(BOOL)state
{
    if (state)
    {
        [cuNav pushViewController:nextVC animated:YES];
    }
    else
    {
        [Tools TipsAlertWithTitle:@"无可用网络" andContent:@"请连接网络后重试" andCu:cuNav];
    }
    
}

//判断字符串是否是纯数字
+ (BOOL)isPureInt:(NSString *)string
{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

- (void)date
{
    
}

@end
