//
//  UIImage+Rendering.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Rendering)

//加载一个不要被渲染的图片
+ (UIImage *)imageNamedWitgOriginal:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
