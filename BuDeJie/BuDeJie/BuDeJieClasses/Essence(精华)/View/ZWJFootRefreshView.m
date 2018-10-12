//
//  ZWJFootRefreshView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/12.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJFootRefreshView.h"

@interface ZWJFootRefreshView ()

@property (weak, nonatomic) IBOutlet UILabel *labelVIew;

@property (weak, nonatomic) IBOutlet UIView *refreshView;

@end

@implementation ZWJFootRefreshView

-(void)setIsRefreshing:(BOOL)isRefreshing {
    
    _isRefreshing = isRefreshing;
    _refreshView.hidden = !isRefreshing;
    _labelVIew.hidden = isRefreshing;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
//    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)footView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}


@end
