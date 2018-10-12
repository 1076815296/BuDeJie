//
//  ZWJPhotoManager.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/12.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJPhotoManager.h"
#import <Photos/Photos.h>

@implementation ZWJPhotoManager

+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:( void(^)(BOOL success, NSError * error))completionHandler{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //判断之前有没有相册,获取之前相册
        PHAssetCollection *assetcollection = [self fetchAssetColletion:albumTitle];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
        if (assetcollection) {
            //已有相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetcollection];
        }else{
            //创建自定义相册
            //1.创建自定义相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        
        
        
        //2.添加图片到系统的相册
        //        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //
        //        //3.把创建好的图片添加到自己的相册中
        //        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
        //
        //        [assetCollectionChangeRequest addAssets:@[placeholder]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        //保存完成
        if (completionHandler) {
            completionHandler(success,error);
        }
    }];
}

#pragma mark -----------------------
#pragma mark 获取之前的相册
+ (PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle {
    //获取之前的相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

@end
