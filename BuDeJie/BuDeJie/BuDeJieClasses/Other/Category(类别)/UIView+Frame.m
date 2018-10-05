//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/5.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)zwj_x{
    
    return self.frame.origin.x;
    
}

- (CGFloat)zwj_y{
    
    return self.frame.origin.y;
    
}

- (CGFloat)zwj_width{
    
    return self.frame.size.width;
    
}

- (CGFloat)zwj_height{
    
    return self.frame.size.height;
    
}

- (void)setZwj_x:(CGFloat)zwj_x{
    
    CGRect frame = self.frame;
    frame.origin.x = zwj_x;
    self.frame = frame;
    
}

- (void)setZwj_y:(CGFloat)zwj_y{
    
    CGRect frame = self.frame;
    frame.origin.x = zwj_y;
    self.frame = frame;
    
}

-(void)setZwj_width:(CGFloat)zwj_width{
    
    CGRect frame = self.frame;
    frame.size.width = zwj_width;
    self.frame = frame;
    
}

-(void)setZwj_height:(CGFloat)zwj_height{
    
    CGRect frame = self.frame;
    frame.size.height = zwj_height;
    self.frame = frame;
    
}

@end
