//
//  ZWJTagCell.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/7.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTagCell.h"

@implementation ZWJTagCell


+ (instancetype)cell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ZWJTagCell" owner:nil options:nil] firstObject];
    
}


@end
