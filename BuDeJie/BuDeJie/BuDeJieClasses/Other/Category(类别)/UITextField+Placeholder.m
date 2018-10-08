//
//  UITextField+Placeholder.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/8.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

//设置占位文字颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    //bug处理 如果先设颜色 在设占位文字, 颜色就不会添加上去
    //处理: 让占位文字中一直有文字
    if (self.placeholder.length == 0) {
        self.placeholder = @" ";
    }
    
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
    
}

- (UIColor *)placeholderColor {
  
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    return placeholderLabel.textColor;
    
}

@end
