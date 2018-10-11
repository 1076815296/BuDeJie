//
//  ZWJSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/11.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJSeeBigPictureViewController.h"
#import "ZWJTopicItem.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

#define ZWJAlbumTitle @"百思不得姐19"

@interface ZWJSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ZWJSeeBigPictureViewController

/*
 
 id<NSFastEnumeration>看到这个 就可以d当做一个数组去用 这是一个协议
 
 如何学习新的框架 (百度)
 1.了解这个框架有哪些常用的类
 2.查看苹果官方文档
 
 想了解一个类怎么去用,可以适用option
 
 */
/*
 PHPhotoLibrary:共享对象，管理用户共享照片库的访问和更改
 PHAsset:图片
 PHAssetCollection:相册,所有相片的一个集合
 PHAssetChangeRequest:创建修改删除图片的
 PHAssetCollectionChangeRequest:创建修改删除相册的
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.image0]];
    
    [self.scrollView addSubview:imageView];
//
//    CGFloat h = ZWJScreenW / self.item.width * self.item.height;
//
//    imageView.frame = CGRectMake(0, 0, ZWJScreenW, h);
//
//    //判断大图还是小图
//    if (self.item.is_bigPicture){
//        //大图
//        _scrollView.contentSize = CGSizeMake(0, h);
//
//        //进行缩放
//        _scrollView.delegate = self;
//        //缩放比例
//        if (self.item.height > h) {
//            //最大缩放比例
//            _scrollView.maximumZoomScale = _item.height / h;
//        }
    
//        
//        
//    }else{
//        //小图
//        imageView.center = CGPointMake(ZWJScreenW * 0.5 , ZWJScreenH * 0.5);
//    }
    
}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)save:(id)sender {
    //保存到自己相册 自己的自定义相册 Photos框架  导入<Photos/photos.h>
    
    /*
     2.显示提示框,询问用户是否允许当前的APP访问当前相册
     1.每次都创建新的相册
     */
    
    //相簿
    //获取用户的授权状态
    /*
     PHAuthorizationStatusNotDetermined = 0, 不确定
     PHAuthorizationStatusRestricted,        家长控制,拒绝
     PHAuthorizationStatusDenied,            拒绝
     PHAuthorizationStatusAuthorized         授权
     */
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined){//不确定
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //授权完成调用
            if(status == PHAuthorizationStatusAuthorized){
                [self savaPhoto];
            }
        }];
        
    }else if (status == PHAuthorizationStatusAuthorized ){
        [self savaPhoto];
    }else {
        //拒绝
        //提示用户去打开授权
        [SVProgressHUD showInfoWithStatus:@"进入设置界面->找到当前应用-打开允许访问相册开关"];
    }
    
    
    
    
    
    
}

//保存图片
- (void)savaPhoto{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //判断之前有没有相册,获取之前相册
        PHAssetCollection *assetcollection = [self fetchAssetColletion:ZWJAlbumTitle];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
        if (assetcollection) {
            //已有相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetcollection]; 
        }else{
            //创建自定义相册
            //1.创建自定义相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:ZWJAlbumTitle];
        }
        
        
        
        //2.添加图片到系统的相册
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
       
        //3.把创建好的图片添加到自己的相册中
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];

        [assetCollectionChangeRequest addAssets:@[placeholder]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
    }];
}

#pragma mark -----------------------
#pragma mark 获取之前的相册
- (PHFetchResult *)fetchAssetColletion:(NSString *)albumTitle {
    //获取之前的相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return result;
        }
    }
    return nil;
}


#pragma mark -----------------------
#pragma mark <UIScrollViewDelegate>
//功能:返回需要缩放的控件
//什么时候调用:进行缩放的时候
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //返回需要缩放的控件
    return self.imageView;
}





//保存图片完成的时候调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    //获得图片
    //UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:self.item.image0];
    
    //这个方法是保存到系统相册
    /* 参数属性
     *
     * 第一个参数:要保存的图片
     * 第二个参数:保存完就会执行这个对象
     * 第三个参数:保存完就会执行这个方法.方法必须是系统提供的 点击去在上面
     * 第四个参数:
     */
    //底层会弹出对话框
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //这个方法一般用来提示用户有没有保存成功
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存成功"];
    }
    
}

@end
