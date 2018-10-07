//
//  ZWJLogInRegisterView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/7.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJLogInRegisterView.h"

@interface ZWJLogInRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation ZWJLogInRegisterView


+ (instancetype)LogInView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
}

+ (instancetype)RegisterView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}



// 从xib加载就会调用,就会把xib所有的属性全部设置
-(void)awakeFromNib{
    
    //获得当前按钮的背景图片
    UIImage *image = self.loginRegisterBtn.currentBackgroundImage;
    //将图片从中心点拉伸
    image =[image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height * 0.5];
    [self.loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    
    
    
}

@end
