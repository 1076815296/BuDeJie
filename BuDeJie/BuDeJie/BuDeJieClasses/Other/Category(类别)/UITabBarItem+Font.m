//
//  UITabBarItem+Font.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "UITabBarItem+Font.h"

@implementation UITabBarItem (Font)

- (void)setupTabBarButtonFont:(UIFont *)font{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    [self setTitleTextAttributes:attr forState:UIControlStateNormal];
}


@end
