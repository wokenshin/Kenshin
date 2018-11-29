//
//  FiveVC.m
//  GYBase
//
//  Created by doit on 16/4/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SettingVC.h"
#import "Tools.h"
#import "BlockButton.h"
#import "ContentsVC.h"
#import "SDHeadCell.h"
#import "SettingCell.h"
#import "Constants.h"
#import "SettingCellModel.h"
#import "NameVC.h"
#import "EmailVC.h"
/*
 这个页面要有 表头，表足
 
 参考 母亲电商的 minevc
 
 要有上传图片的功能［本地实现就可以了］ 拍照 或者 获取本地相册的图片 可以参考以前的项目 或现在的项目
 
 要有修改个人资料的页面， 涉及到数据库的 修改操作。
 
 要有退出tabbar的功能
 
 总之先知少完成同 母亲电商 服务端 一样的效果
 
 */

@interface SettingVC()<SDHeadCellDelegate>

@end

@implementation SettingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSettingUI];
    [self initImgPicker];
    
}

//每次展现页面的时候都会调用一次
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Tools setNavigationBarBackgroundColor:RGB2Color(233, 100, 0) andTextColor:[UIColor whiteColor]];
    [self.tableview reloadData];
    NSLog(@"重现！！！");
}

//懒加载［模型数组］
- (NSMutableArray* )cellsData
{
    if (_cellsData == nil)
    {
        _cellsData = [NSMutableArray array];
        
        //定义字典
        NSDictionary *dicOne   = @{@"title":@"个人姓名", @"tellPhone":@""};
        NSDictionary *dicTwo   = @{@"title":@"个人邮箱", @"tellPhone":@""};
        NSDictionary *dicThree = @{@"title":@"个人电话", @"tellPhone":@"18312345678"};
        
        //将字典转为模型
        SettingCellModel *modelOne   = [SettingCellModel settingCellModelWith:dicOne];
        SettingCellModel *modelTwo   = [SettingCellModel settingCellModelWith:dicTwo];
        SettingCellModel *modelThree = [SettingCellModel settingCellModelWith:dicThree];

        
        //将模型添加到数据源
        [_cellsData addObject:modelOne];
        [_cellsData addObject:modelTwo];
        [_cellsData addObject:modelThree];
        
    }
    return _cellsData;
}

#pragma mark 初始化图片选择
- (void)initImgPicker
{
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    //设置拍照后的图片可被编辑
    self.picker.allowsEditing = YES;
    
}

- (void)initSettingUI
{
    /*
     UI 结构
     全部UI都放在tableview里面显示 退出按钮放在 tableFooterView中 这样做的目的是为了兼容小屏手机 UI的尺寸不变，显示不全 滑动查看
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Setting";
    
    //初始化table
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 49)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉tableview的分割线
    self.tableview.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    self.tableview.bounces = NO;//禁止其上下拖动
    
    //start 设置tableview 的多余行线
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableview setTableFooterView:view];
    [self.tableview setTableHeaderView:view];
    
    //设置tableView 代理
    self.tableview.delegate   = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    //退出
    CGFloat width = screenWidth * 0.75;
    CGFloat heightBtn = 36;
    self.loginOutBtn = [[BlockButton alloc] initWithFrame:CGRectMake((screenWidth-width)/2.0, 160-36, width, heightBtn)];
    [self.loginOutBtn setTitle:@"Back目录" forState:UIControlStateNormal];
    self.loginOutBtn.backgroundColor = RGB2Color(66, 210, 83);
    [Tools setCornerRadiusWithView:self.loginOutBtn andAngle:heightBtn/2];
    self.loginOutBtn.block = ^(BlockButton *btn)
    {
        ContentsVC *vc = [ContentsVC new];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
        [[UIApplication sharedApplication].delegate window].rootViewController = navController;
        
    };
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 160)];
    [bottomView addSubview:self.loginOutBtn];
    self.tableview.tableFooterView = bottomView;
    bottomView = nil;
    
}

#pragma mark - tableview 代理
//分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//至少为 1 ？
    
}

//行数［这里决定了 绘制 cell的方法的调用次数］
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellsData count]+1;//1.头像 2.name 3.签名 4.电话
    
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 45;
    if(indexPath.row == 0)
    {
        height = 210;//头像cell
        
    }
    return height;//其余高度
    
}

#pragma mark 绘制cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        SDHeadCell *cell = [[SDHeadCell alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 210)];
        cell.delegate = self;//实现委托？
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell选中时 颜色为无色
        return cell;
        
    }
    else
    {
        SettingCell *cell = [[SettingCell alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 45)];
        cell.model = self.cellsData[indexPath.row-1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell选中时 颜色为无色
        return cell;
        
    }
    
}

//设置cell可以被选中
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row != 0;//即 除了第一行 其他行可以被选中
    
}

#pragma mark cell选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)//姓名
    {
        NameVC *vc = [NameVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.row == 2)//邮箱
    {
        EmailVC *vc = [EmailVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.row == 3)//打电话
    {
        SettingCellModel *model = self.cellsData[indexPath.row-1];
        NSString *tellPhone = model.tellPhone;
        if (![tellPhone isEqualToString:@""]) {
            NSString *tellStr = [NSString stringWithFormat:@"tel://%@", tellPhone];
            
            //模拟器无法测试打电话
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tellStr]];
        }
        
    }
    
}

#pragma mark 代理 SDHeadCellDelegate
- (void)pressHeadImgChangeHeader:(SDHeadCell *)cell
{
    NSLog(@"我勒个擦！");
    [self setTingHeaderImg];
    
}

#pragma mark 设置头像
- (void)setTingHeaderImg
{
    /*
     1.从本地选择图片设置头像
     2.拍照设置头像
     3.将设置好的头像图片保存到Documents中
     */
    self.alertController = [UIAlertController alertControllerWithTitle:@"设置头像"
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
    [self.alertController addAction:takePhoto];
    [self.alertController addAction:localPhoto];
    [self.alertController addAction:clearPhoto];
    [self.alertController addAction:cancelPhoto];
    
    //显示alertController
    [self presentViewController:self.alertController animated:YES completion:nil];
    
}

- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;//指定源的类型
        [self presentViewController:self.picker animated:YES completion:nil];
        
    }
    else
    {
        [Tools toast:@"模拟其中无法打开照相机" andCuView:self.view];
        
    }
    
}

- (void)localPhoto
{
    //创建图片选择器
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//指定源的类型
    self.picker.allowsEditing = YES;//在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
    //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
    [self presentViewController:self.picker animated:YES completion:nil];
    
}

#pragma mark 拍照or选择本地图片 选择后 进入本函数
-(void)imagePickerController:(UIImagePickerController*)ImgPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData   UIImagePickerControllerReferenceURL
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];//这里有多种选择，当picker允许编辑的时候 这里可以选择当前参数
        NSData *data;
        data = UIImageJPEGRepresentation(image, 0.6);//压缩比例 默认值为：1
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png【保存为 xxx.png】
        NSString *headerPng = headerPath_SLAMDUNK;
        
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
    NSString *headerPngPath    = [NSString stringWithFormat:@"%@%@", DocumentsPath, headerPath_SLAMDUNK];//获取文件路径
    
    //删除Documents 指定路径下的数据
    BOOL isDeleteHeader = [fileManager removeItemAtPath:headerPngPath error:nil];
    if (isDeleteHeader)
    {
        [Tools toast:@"清空头像成功！" andCuView:self.view];
        [self freshData];
        
    }
    
}

//修改头像时调用
- (void)freshData
{
    //局部更新
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                          withRowAnimation:UITableViewRowAnimationNone];

}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.loginOutBtn     = nil;
    self.tableview       = nil;
    self.cellsData       = nil;
    self.alertController = nil;
    self.picker          = nil;
    
}

@end
