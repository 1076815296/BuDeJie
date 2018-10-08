//
//  ZWJLoginField.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/8.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJLoginField.h"

@implementation ZWJLoginField

//当文本框开始编辑的时候,必须要成为第一响应者
//作用:成为第一响应者的时候 调用此方法
- (BOOL)becomeFirstResponder{
    
    //快速去设置 占位文字颜色
    
    //placeholderColor
    //猜测占位文字是一个UIabel,验证占位文字是一个UILabel
    //获取占位文字的控件, 获取一个类所有的属性,可以使用断点的属性
   
    
    //占位文字颜色
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//
//    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
//    self.attributedPlaceholder = attStr;

    //简化,找到私有属性按钮
//    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor whiteColor];
    
    //再简化,写一个私有属性按钮类
    self.placeholderColor = [UIColor whiteColor];
    
    return [super becomeFirstResponder];
    
}

//当文本框结束编辑的时候,注销掉第一响应者
- (BOOL)resignFirstResponder {
    
   
    self.placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];
    
}


- (void)awakeFromNib {
    
    [super awakeFromNib];
    //更改提示文字光标
    self.tintColor = [UIColor whiteColor];
    
    //监听文本框什么时候开始编辑 1.代理 2.通知 3.target
    //最好自己不要成为自己的代理
    //点击文本框的时候
    //[self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    //[self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    
    //占位文字颜色
    //attributedStringWithAttachment图文混排的
    //NSTextAttachment *Attach = [[NSTextAttachment alloc] init];
    //Attach.image = [UIImage imageNamed:@"defaultUserIcon"];
    //Attach.bounds = CGRectMake(0, 0, 5, 5);
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    self.attributedPlaceholder = attStr;
    
    
}

/*
- (void)textBegin {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    self.attributedPlaceholder = attStr;
    
}*/

/*
- (void)textEnd {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    self.attributedPlaceholder = attStr;
    
}*/



@end
