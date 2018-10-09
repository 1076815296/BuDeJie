//
//  ZWJFileManagr.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/9.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/*
 注意点:
 1.指定当前类是用来干嘛的,文件顶部或者类的顶部
 2.每个方法必须要有文档注释
 3.每个方法要做容错处理(严谨),提前就要排除别人犯得错误
 */

/***
 处理文件
 ***/

@interface ZWJFileManagr : NSObject

/**
 指定一个文件夹路径,获取当前文件大小
 参数directoryPath:文件夹路径
 返回值:文件夹路径尺寸
 */
+ (void)getDirectorySize:(NSString *)directoryPath completion:( nonnull void(^)(NSInteger))completion;

/**
 指定一个文件夹路径,删除文件夹
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 指定一个文件夹路径,获取当前文件夹的尺寸支付穿
 */
+ (void)directorSizeString:(NSString *)directoryPath completion:( nonnull void(^)(NSString * str))completion;

@end

NS_ASSUME_NONNULL_END
