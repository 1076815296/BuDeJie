//
//  ZWJTopTopicView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTopTopicView.h"
#import <UIImageView+WebCache.h>
#import "ZWJTopicItem.h"

@interface ZWJTopTopicView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UILabel *textView;



@end

@implementation ZWJTopTopicView

+ (instancetype)ViewForXib {
    
    
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}




- (void)setItem:(ZWJTopicItem *)item{
    
    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image]];
    self.nameView.text = item.screen_name;
    self.timeView.text = item.create_time;
    self.textView.text = item.text;
    
    self.iconView.image = [UIImage imageNamed:@"defaultUserIcon"];
    self.nameView.text = @"机器人";
    self.timeView.text = @"2018.10.10 11:03";
    self.textView.text = @"我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!";
    
}


//假数据





@end
