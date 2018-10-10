//
//  ZWJBaseTopicView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJBaseTopicView.h"

@implementation ZWJBaseTopicView


+ (instancetype)ViewForXib {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}
@end
