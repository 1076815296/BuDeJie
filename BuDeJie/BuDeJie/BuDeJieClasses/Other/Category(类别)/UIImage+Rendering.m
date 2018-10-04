//
//  UIImage+Rendering.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "UIImage+Rendering.h"

@implementation UIImage (Rendering)

+ (UIImage *)imageNamedWitgOriginal:(NSString *)name {
    
    UIImage *selImage = [UIImage imageNamed:name];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return selImage;
}


@end
