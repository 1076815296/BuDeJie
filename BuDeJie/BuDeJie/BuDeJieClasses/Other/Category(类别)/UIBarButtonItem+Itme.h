//
//  UIBarButtonItem+Itme.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Itme)

+ (instancetype)itmeWithImageName:(UIImage *)image highImage:(UIImage *)highImage Target:(nullable id)target action:(SEL)action;

+ (instancetype)itmeWithImageName:(UIImage *)image selImage:(UIImage *)selImage Target:(nullable id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
