//
//  ZWJBackView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/5.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJBackView.h"

@implementation ZWJBackView


+ (instancetype)viewButtonAddTarget:(nullable id)target action:(SEL)action title:(NSString *)title image:(UIImage *)image imageClick:(UIImage *)imageClick {
    
    //设置导航条返回按钮 获取当前控制器的navgationItem的left
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:imageClick forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //CGRect frame = backButton.frame;
    //frame.origin.x -= 10;
    //backButton.frame = frame;
    backButton.zwj_x -= 10;
    
    ZWJBackView *view = [[self alloc] initWithFrame:backButton.bounds];
    [view addSubview:backButton];
    return view;
    
}

@end
