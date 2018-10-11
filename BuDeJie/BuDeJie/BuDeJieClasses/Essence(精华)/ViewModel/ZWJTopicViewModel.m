//
//  ZWJTopicViewModel.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTopicViewModel.h"
#import "ZWJTopicItem.h"
#import "ZWJCommentItem.h"

@implementation ZWJTopicViewModel

- (void)setItem:(ZWJTopicItem *)item {
    
    //计算tioView
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = ZWJScreenW;
    CGFloat margin = 10;
    CGFloat textY = 55;
    CGFloat textW = ZWJScreenW - margin * 2;
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
    
    //最热评论view
    if (item.topComment) {
        CGFloat commentX = 0;
        CGFloat commentY = _cellH;
        CGFloat commentW = ZWJScreenW;
        CGFloat commentH = 43;
        if (item.topComment.content.length) {
            CGFloat textH = [item.topComment.totalContent sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
            commentH = 21 + textH;
        }
        self.commentViewFrame = CGRectMake(commentX, commentY, commentW, commentH);
        _cellH = CGRectGetMaxY(self.commentViewFrame) + margin;
    }
    
    //底部的view
    CGFloat bottomX = 0;
    CGFloat bottomY = _cellH;
    CGFloat bottomW = ZWJScreenW;
    CGFloat bottomH = 35;
    self.bottomViewFrame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    _cellH = CGRectGetMaxY(self.bottomViewFrame) + margin;
}

@end
