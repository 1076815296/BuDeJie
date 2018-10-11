//
//  ZWJPictureTopicView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJPictureTopicView.h"
#import "ZWJTopicItem.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "ZWJSeeBigPictureViewController.h"

@interface ZWJPictureTopicView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end

@implementation ZWJPictureTopicView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.progressTintColor = [UIColor whiteColor];
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    self.progressView.roundedCorners = 5;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"点击了图片");
    //弹出查看大图的view在
    ZWJSeeBigPictureViewController *seeVC = [[ZWJSeeBigPictureViewController alloc] init];
    seeVC.item = self.item;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeVC animated:YES completion:nil];
    
}


- (void)setItem:(ZWJTopicItem *)item {
    
    [super setItem:item];
    
    //将缓存清空为0
    self.progressView.progress = 0;
    self.progressView.progressLabel.text = @"0%";
    
    
    //[self.pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //进度的block在子线程调用 改成在主线程
        
        //拿到下载进度值
        if (expectedSize == -1) return ;
        CGFloat progress = 1.0 * receivedSize /expectedSize;
        
        self.progressView.progress = progress;
        NSString *str = [NSString stringWithFormat:@"%.1f%%",progress * 100];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.progressView.progressLabel.text = str;
            self.progressView.progress = progress;
        });
        
        
    } completed:nil];
    
    self.gifView.hidden = !item.is_gif;
    
    //做大图处理
    _seeBigButton.hidden = !item.is_bigPicture;
    
    if (item.is_bigPicture) {
        //设置图片内容模式
        self.pictureView.contentMode = UIViewContentModeTop;
        self.pictureView.clipsToBounds = YES;
    }else{
        self.pictureView.contentMode = UIViewContentModeScaleToFill;
        self.pictureView.clipsToBounds = NO;
    }
    
}


@end
