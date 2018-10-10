//
//  ZWJVoiceTopicView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJVoiceTopicView.h"
#import "ZWJTopicItem.h"
#import <UIImageView+WebCache.h>


@interface ZWJVoiceTopicView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictireView;
@property (weak, nonatomic) IBOutlet UILabel *playCountView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;

@end

@implementation ZWJVoiceTopicView


- (void)setItem:(ZWJTopicItem *)item {
    [super setItem:item];
    [self.pictireView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    self.playCountView.text = [NSString stringWithFormat:@"%ld播放",(long)item.playcount];
    
    NSInteger second = item.voicetime % 60;
    NSInteger minute = item.voicetime / 60;
    
    self.timeView.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
}


@end
