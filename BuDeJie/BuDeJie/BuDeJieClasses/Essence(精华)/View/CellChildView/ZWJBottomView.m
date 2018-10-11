//
//  ZWJBottomView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/11.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJBottomView.h"
#import "ZWJTopicItem.h"

@interface ZWJBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *dingView;
@property (weak, nonatomic) IBOutlet UIButton *caiView;
@property (weak, nonatomic) IBOutlet UIButton *shareView;
@property (weak, nonatomic) IBOutlet UIButton *commentView;


@end

@implementation ZWJBottomView

- (void)setItem:(ZWJTopicItem *)item {
    
    [super setItem:item];
    
    [self setupButton:_dingView count:item.ding title:@"赞"];
    [self setupButton:_caiView count:item.cai title:@"踩"];
    [self setupButton:_shareView count:item.repost title:@"转发"];
    [self setupButton:_commentView count:item.comment title:@"评论"];
    
}


- (void)setupButton:(UIButton *)btn count:(CGFloat)count title:(NSString *)title{
    NSString *str = title;
    
    if (count >= 10000) {
        count = count / 10000;
        str = [NSString stringWithFormat:@"%.1f万",count];
    }else if(count > 0){
        str = [NSString stringWithFormat:@"%.0f",count];
    }
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    [btn setTitle:str forState:UIControlStateNormal];
}

@end
