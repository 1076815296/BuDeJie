//
//  ZWJTopicViewModel.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTopicViewModel.h"
#import "ZWJTopicItem.h"

@implementation ZWJTopicViewModel

- (void)setItem:(ZWJTopicItem *)item {
    
    //计算tioView
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = ZWJScreenW;
    CGFloat margin = 10;
    CGFloat textY = 55;
    CGFloat textW = ZWJScreenW - margin;
    CGFloat textH = [item.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
    CGFloat topH = textY + textH;
    
    
    self.topViewFrame = CGRectMake(topX, topY, topW, topH);
    self.cellH = CGRectGetMaxY(self.topViewFrame) + margin;
    
    //计算中间的view,只有非段子才需要计算
    if (item.type != ZWJTopicItemTypeText) {
        CGFloat middleX = margin;
        CGFloat middleY = _cellH;
        CGFloat middleW = textW;
        CGFloat middleH = textW / item.width *item.height;
        if (middleH > ZWJScreenH) {
            middleH = 300;
            item.is_bigPicture = YES;
        }
        self.middleViewFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellH = CGRectGetMaxY(self.middleViewFrame) + margin;
    }
   
}

@end
