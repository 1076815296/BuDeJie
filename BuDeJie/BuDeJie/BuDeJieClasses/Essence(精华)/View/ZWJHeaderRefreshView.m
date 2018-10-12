//
//  ZWJHeaderRefreshView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/12.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJHeaderRefreshView.h"

@interface ZWJHeaderRefreshView ()

@property (weak, nonatomic) IBOutlet UILabel *labelView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;

@property (weak, nonatomic) IBOutlet UIView *loadView;

@end

@implementation ZWJHeaderRefreshView

-(void)setIsRefreshing:(BOOL)isRefreshing{
    
    _isRefreshing = isRefreshing;
    _loadView.hidden = !isRefreshing;
    
    _arrowView.hidden = isRefreshing;
    _arrowView.hidden = isRefreshing;
    
}

- (void)setIsNeedLoad:(BOOL)isNeedLoad{
    
    _isNeedLoad = isNeedLoad;
    _labelView.text = isNeedLoad?@"松开立即刷新":@"下拉可以刷新";
    [UIView animateWithDuration:0.25 animations:^{
        self.arrowView.transform = self.isNeedLoad?CGAffineTransformMakeRotation(-M_PI + 0.000001):CGAffineTransformIdentity;
    }];
    
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)headerView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}


@end
