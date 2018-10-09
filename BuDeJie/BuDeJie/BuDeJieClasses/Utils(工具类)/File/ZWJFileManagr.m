//
//  ZWJFileManagr.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/9.
//  Copyright © 2018年 ZWJ. All rights reserved.
//  处理文件

#import "ZWJFileManagr.h"


@implementation ZWJFileManagr

/*
 获取文件夹尺寸 => 遍历文件夹所有的尺寸,把文件尺寸累加
 1.创建一个文件管理者
 2.获取文件夹的路径
 3.获取文件夹里面所有的子路径
 4.遍历所有的子路径
 5.拼接文件全路径
 6.attributesOfItemAtPath: 指定文件全路径,就能获取文件属性
 7.获取c文件尺寸
 8.累加
 
 */
+ (void)getDirectorySize:(NSString *)directoryPath completion:(nonnull void (^)(NSInteger))completion{
    
    //GCD
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        
        //容错处理
        BOOL isDirectory = NO;
        BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if (!isExists || !isDirectory){
            
            //报错:抛出异常异常
            NSException *excp = [NSException exceptionWithName:@"FileError" reason:@"你传入的路径不存在" userInfo:nil];
            
            [excp raise];
            
        }
        
        
        //获取文件夹下所有的子路径,获取多级目录下文件路径
        NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        for (NSString *subPath in subpaths) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            //判断是否是隐藏属性
            if ([filePath containsString:@".DS"]) {
                continue;
            }
            
            //判断是否是当前文件夹 是否存在
            BOOL isDirectory = NO;
            BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            if (isDirectory || !isExists ) continue;
            
            
            
            //获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize += [attr fileSize];
            
        }
        
        if (completion) {
            completion(totalSize);
        }
        
    });
    
    
}

+ (void)removeDirectoryPath:(NSString *)directoryPath {
    
    //创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    //容错处理
    BOOL isDirectory = NO;
    BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExists || !isDirectory){
        
        //报错:抛出异常异常
        @throw [NSException exceptionWithName:@"FileError" reason:@"你传入的路径不存在" userInfo:nil];
        
    }
    
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    
}

+ (void)directorSizeString:(NSString *)directoryPath completion:( nonnull void(^)(NSString *))completion{
    
    
    
    [self getDirectorySize:directoryPath completion:^(NSInteger totalSize){
        NSInteger size = totalSize;
        
        NSString *str = @"清除缓存";
        
        if (size > 1000 * 1000) {
            CGFloat sizeF = size / 1000.0 / 1000.0;
            str = [NSString stringWithFormat:@"%@(%.1fMB)",str,sizeF];
            
        }else if (size > 1000) {
            CGFloat sizeF = size / 1000.0 ;
            str = [NSString stringWithFormat:@"%@(%.1fKB)",str,sizeF];
        }else if (size > 0){
            
            str = [NSString stringWithFormat:@"%@(%ldB)",str,size];
        }
        
        [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(str);
            }
            
        });
        
    }];
  
    

    
    
    
}

@end 
