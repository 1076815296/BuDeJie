//
//  UIBarButtonItem+Itme.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "UIBarButtonItem+Itme.h"

@implementation UIBarButtonItem (Itme)

/* 参数属性
 *
 * 第一个参数:按钮的图片
 * 第二个参数:按钮高亮状态的图片
 * 第三个参数:执行方法的控制器
 * 第四个参数:执行的方法
 */
+(instancetype)itmeWithImageName:(UIImage *)image highImage:(UIImage *)highImage Target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(instancetype)itmeWithImageName:(UIImage *)image selImage:(UIImage *)selImage Target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
