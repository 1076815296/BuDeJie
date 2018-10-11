//
//  ZWJVideoTopicView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJVideoTopicView.h"
#import "ZWJTopicItem.h"
#import <UIImageView+WebCache.h>


@interface ZWJVideoTopicView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictireView;
@property (weak, nonatomic) IBOutlet UILabel *playCountView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;


@end

@implementation ZWJVideoTopicView


- (void)setItem:(ZWJTopicItem *)item {
    [super setItem:item];
    [self.pictireView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    self.playCountView.text = [NSString stringWithFormat:@"%ld播放",item.playcount];
    
    NSInteger second = item.videotime % 60;
    NSInteger minute = item.videotime / 60;
    
    self.timeView.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
}


@end
