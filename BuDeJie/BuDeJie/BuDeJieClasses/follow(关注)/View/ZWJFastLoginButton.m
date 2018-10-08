//
//  ZWJFastLoginButton.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/7.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJFastLoginButton.h"

@implementation ZWJFastLoginButton


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置图片
    //self.imageView.center = CGPointMake(self.center.x * 0.5, 0);
    self.imageView.frame = CGRectMake( (self.frame.size.width - self.imageView.frame.size.width) *0.5, 0, self.imageView.frame.size.width, self.imageView.frame.size.width);
    
    //先计算文字宽度,在设置label宽度
    //CGFloat w = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:18]].width;
    //self.titleLabel.zwj_width = w;
    // 根据文字内容计算下label,设置好label尺寸
    [self.titleLabel sizeToFit];
    
    //设置文字
    //self.titleLabel.center = CGPointMake(self.center.x * 0.5, 0);
    self.titleLabel.frame = CGRectMake((self.frame.size.width - self.titleLabel.frame.size.width) *0.5, self.frame.size.height - self.titleLabel.frame.size.height, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    
   
    
}


@end
