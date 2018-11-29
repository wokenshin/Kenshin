//
//  SetHeaderVC.m
//  GYBase
//
//  Created by doit on 16/5/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SetHeaderVC.h"
#import "Tools.h"
#import "Constants.h"

@interface SetHeaderVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIAlertController           *alertController;
    UIImagePickerController     *picker;//拍照获取图片 和 选中本地图片
    
}
@end

@implementation SetHeaderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImgPicker];
    [self initSetHeaderVCUI];
    [self loadData];
    [Tools toast:@"点击头像进行编辑！" andCuView:self.view];
    
}

#pragma mark 初始化图片选择
- (void)initImgPicker
{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = YES;
    
}

#pragma mark 初始化UI
- (void)initSetHeaderVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置头像";
    
    CGFloat sizeHeader = 120;
    CGFloat sizeHeaderFrame = sizeHeader + 4;
    
    //边框
    UILabel *headerFrame = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sizeHeaderFrame, sizeHeaderFrame)];
    headerFrame.center = CGPointMake(screenWidth/2, 150);
    headerFrame.backgroundColor = RGB2Color(107, 165, 169);
    [Tools setCornerRadiusWithView:headerFrame andAngle:sizeHeaderFrame/2];
    
    //头像
    self.headerCtrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, sizeHeader, sizeHeader)];
    self.headerCtrl.center = CGPointMake(screenWidth/2, 150);
    [self.headerCtrl addTarget:self action:@selector(setTingHeaderImg) forControlEvents:UIControlEventTouchUpInside];
    
    //默认头像
    self.headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sizeHeader, sizeHeader)];
    self.headerImg.image = [UIImage imageNamed:@"defaultPic"];
    [self.headerCtrl addSubview:self.headerImg];
    [Tools setCornerRadiusWithView:self.headerCtrl andAngle:sizeHeader/2];
    
    //描述
    UILabel *desLab = [[UILabel alloc] initWithFrame:CGRectMake(margin_10, 200, screenWidth - margin_10*2, 300)];
    desLab.textColor = [UIColor blackColor];
    desLab.font = [UIFont systemFontOfSize:16];
    desLab.numberOfLines = 0;//多行现实
    desLab.text = @"        只是将设置头像保存到了Documents中，没有上传头像到服务端";
    
    //头像背景
    self.backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, 220)];
//    [self setMaoBoliStyleWithImageView:self.backView];
    
    [self.view addSubview:self.backView];
    [self.view addSubview:headerFrame];
    [self.view addSubview:self.headerCtrl];
    [self.view addSubview:desLab];
    
}

#pragma mark 毛玻璃效果
- (void)setMaoBoliStyleWithImageView:(UIImageView *)imgView
{
    if (imgView == nil || ![imgView isKindOfClass:[UIImageView class]]) {
        return;
    }
    imgView.userInteractionEnabled = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height);
    
    [imgView addSubview:effectview];
    
}

#pragma mark 设置头像
- (void)setTingHeaderImg
{
    /*
     1.从本地选择图片设置头像
     2.拍照设置头像
     3.将设置好的头像图片保存到Documents中
     */
    alertController = [UIAlertController alertControllerWithTitle:@"设置头像"
                                                          message:nil
                                                   preferredStyle:UIAlertControllerStyleActionSheet];
    
    WS(ws);
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照选择"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             [ws takePhoto];
                                                         }];
    
    UIAlertAction *localPhoto = [UIAlertAction actionWithTitle:@"本地图片"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                            [ws localPhoto];
                                                        }];
    
    UIAlertAction *clearPhoto = [UIAlertAction actionWithTitle:@"清空头像"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                              [ws clearPhoto];
                                                          }];
    
    UIAlertAction *cancelPhoto = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    
    //按钮的顺序由UIAlertAction 的style来决定的
    [alertController addAction:takePhoto];
    [alertController addAction:localPhoto];
    [alertController addAction:clearPhoto];
    [alertController addAction:cancelPhoto];
    
    //显示alertController
    [self presentViewController:alertController animated:YES completion:nil];
    
}
//拍照
- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;//指定源的类型
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    else
    {
        [Tools toast:@"模拟其中无法打开照相机" andCuView:self.view];
        
    }
    
}
//取相册
- (void)localPhoto
{
    //创建图片选择器
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//指定源的类型
//    picker.delegate = self;//实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作进行监听
    picker.allowsEditing = YES;//在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
    //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark 拍照or选择本地图片 选择后 进入本函数
-(void)imagePickerController:(UIImagePickerController*)ImgPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData   UIImagePickerControllerReferenceURL
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data;
        data = UIImageJPEGRepresentation(image, 0.6);//压缩比例 默认值为：1
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png【保存为 xxx.png】
        NSString *headerPng = headerPath_SetHeaderVC;
        
        //将图片保存到Documents 中
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:headerPng] contents:data attributes:nil];
        
        //关闭相册界面
        [ImgPicker dismissViewControllerAnimated:YES completion:nil];
        [Tools toast:@"设置头像成功！" andCuView:self.view];
        [self freshData];
        
    }
    
}

#pragma mark 清空头像
- (void)clearPhoto
{
    //获取Documents路径
    NSString * DocumentsPath   = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];//文件管理器
    NSString *headerPngPath    = [NSString stringWithFormat:@"%@%@", DocumentsPath, headerPath_SetHeaderVC];//获取文件路径
    
    //删除Documents 指定路径下的数据
    BOOL isDeleteHeader = [fileManager removeItemAtPath:headerPngPath error:nil];
    if (isDeleteHeader)
    {
        [Tools toast:@"清空头像成功！" andCuView:self.view];
        [self freshData];
    }
    
}

#pragma mark 加载头像
- (void)loadData
{
    //从Documents中获取图片
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *headerName    = headerPath_SetHeaderVC;
    NSString *filePath      = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, headerName];
    UIImage* img = [[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:filePath,NSHomeDirectory()]];
    
    if (img != nil)
    {
        self.headerImg.image = img;
//        self.backView.image  = img;
        self.backView.image = [Tools maoBoLiBackWithImage:img];
    }
    else
    {
        self.headerImg.image = [UIImage imageNamed:@"defaultPic"];//默认头像
        self.backView.image = [Tools maoBoLiBackWithImage:[UIImage imageNamed:@"defaultPic"]];
        
    }
    
}

- (void)freshData
{
    [self loadData];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
