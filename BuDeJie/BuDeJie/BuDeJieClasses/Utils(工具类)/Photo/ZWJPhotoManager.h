//
//  ZWJPhotoManager.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/12.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 处理图片的,(保存)
 */
@interface ZWJPhotoManager : NSObject

+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:( void(^)(BOOL success, NSError * error))completionHandler;


@end

NS_ASSUME_NONNULL_END
