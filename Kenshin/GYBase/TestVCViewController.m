//
//  TestVCViewController.m
//  GYBase
//
//  Created by kenshin on 16/8/30.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "TestVCViewController.h"
#import "Tools.h"

@interface TestVCViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) NSInteger     flagMode;
@property (nonatomic, assign) BOOL          flag;
@end

@implementation TestVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"UIImageView";
    self.view.backgroundColor = [UIColor blackColor];
    _flagMode = 0;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
}


- (IBAction)btnChangeUIImageContentMode:(id)sender
{
    /*
     typedy enum(NSInteger,UIViewContentMode){
     //伸缩至高度和宽度与UIImageView的大小一致
     UIViewContentModeScaleToFill,
     
     //不改变图片宽高比例，且不超过UIImageView的尺寸范围的情况下伸缩至最大
     UIViewContentModeScaleAspectFit,
     
     //在图片比例不变的情况下伸缩至最大，但最多只允许宽或高其中一个超出UIImageView的尺寸
     UIViewContentModeScaleAspectFill,
     
     //图片充满UIImageView，但是只要UIImageView的bounds属性发生改变就调用setNeedsDisplay方法
     UIViewContentModeRedraw,
     
     //不改变图片的尺寸，在UIImageView正中央
     UIViewContentModeCenter,
     
     //不改变图片的尺寸，但图片在UIImageView顶部中央
     UIViewContentModeTop,
     
     //不改变图片的尺寸，但图片在UIImageView底部中央
     UIViewContentModeBottom,
     
     //不改变图片的尺寸，但图片在UIImageView左边中央
     UIViewContentModeLeft,
     
     //不改变图片的尺寸，但图片在UIImageView右边中央
     UIViewContentModeRight,
     
     //不改变图片的尺寸，但图片在UIImageView左上角
     UIViewContentModeTopLeft,
     
     //不改变图片的尺寸，但图片在UIImageView右上角
     UIViewContentModeTopRight,
     
     //不改变图片的尺寸，但图片在UIImageView左下角
     UIViewContentModeBottomLeft,
     
     //不改变图片的尺寸，但图片在UIImageView右下角
     UIViewContentModeBottomRight,
     };
     */
    switch (_flagMode) {
        case 0:
            _imageView.contentMode = UIViewContentModeTop;
            break;
        
        case 1:
            _imageView.contentMode = UIViewContentModeLeft;
            break;
            
        case 2:
            _imageView.contentMode = UIViewContentModeRight;
            break;
            
        case 3:
            _imageView.contentMode = UIViewContentModeBottom;
            [Tools toast:@"UIViewContentModeBottom" andCuView:self.view andHeight:300];
            break;
            
        case 4:
            _imageView.contentMode = UIViewContentModeCenter;
            [Tools toast:@"UIViewContentModeCenter" andCuView:self.view andHeight:300];
            break;
            
        case 5:
            _imageView.contentMode = UIViewContentModeRedraw;
            break;
            
        case 6:
            _imageView.contentMode = UIViewContentModeTopLeft;
            break;
            
        case 7:
            _imageView.contentMode = UIViewContentModeTopRight;
            break;
            
        case 8:
            _imageView.contentMode = UIViewContentModeBottomLeft;
            break;
            
        case 9:
            _imageView.contentMode = UIViewContentModeBottomRight;
            break;
            
        case 10:
            _imageView.contentMode = UIViewContentModeScaleToFill;
            break;
            
        case 11:
            _imageView.contentMode = UIViewContentModeScaleAspectFit;
            break;
            
        case 12:
            _imageView.contentMode = UIViewContentModeScaleAspectFill;
            _flagMode = -1;
            break;
            
        default:
            break;
    }
    NSLog(@"当前选择的显示模式是：%zd", _flagMode);
    if (_flagMode == -1) {
        [Tools toast:@"MLGB！！根本不好使！！！" andCuView:self.view andHeight:300];
    }
    _flagMode++;
    
    
}

#pragma mark 裁剪
- (IBAction)btnCutImg:(id)sender
{
    //这里有个问题：当我吧Assets.xcassets中的图片设置为2倍的时候，获取到的图片的尺寸就不是实际的尺寸了，所以要放在一倍的位置
    NSString *imgName = [NSString stringWithFormat:@"%@", @"iphone6Pic"];
    
    if (_flag) {
        imgName = [NSString stringWithFormat:@"%@", @"iphone6Pic"];
        _flag = NO;
    }
    else
    {
        imgName = [NSString stringWithFormat:@"%@", @"qingzi"];
        _flag = YES;
    }
    
    self.imageView.image = [self handleImage:[UIImage imageNamed:imgName] withCutSize:CGSizeMake(screenWidth, 220)];
    
}


//裁剪图片
- (UIImage *)handleImage:(UIImage *)originalImage withCutSize:(CGSize)size {
    
    CGSize originalsize = [originalImage size];
    NSLog(@"改变前图片的宽度为%f,图片的高度为%f",originalsize.width,originalsize.height);
    
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
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
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
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    else//原图为标准长宽的，不做处理
    {
        return originalImage;
    }
}

#pragma mark 恢复
- (IBAction)btnReset:(id)sender
{
    _flag = NO;
    self.imageView.image = [UIImage imageNamed:@"qingzi"];
    
}


@end
