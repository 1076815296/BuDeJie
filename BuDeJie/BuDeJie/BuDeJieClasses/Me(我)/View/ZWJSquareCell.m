//
//  ZWJSquareCell.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/8.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJSquareCell.h"
#import <UIImageView+WebCache.h>
#import "ZWJSquareItem.h"
@interface ZWJSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;


@end

@implementation ZWJSquareCell

- (void)setItem:(ZWJSquareItem *)item {
    
    _item = item;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameView.text = item.name;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
