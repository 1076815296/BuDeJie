//
//  ZWJTopicCell.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTopicCell.h"
#import "ZWJTopTopicView.h"
#import "ZWJTopicItem.h"
#import "ZWJTopicViewModel.h"
#import "ZWJPictureTopicView.h"
#import "ZWJVideoTopicView.h"
#import "ZWJVoiceTopicView.h"
#import "ZWJCommentView.h"
#import "ZWJBottomView.h"

@interface ZWJTopicCell ()

@property (nonatomic, weak) ZWJTopTopicView *topView;
@property (nonatomic, weak) ZWJPictureTopicView *pictureView;
@property (nonatomic, weak) ZWJVideoTopicView *videoView;
@property (nonatomic, weak) ZWJVoiceTopicView *VoiceView;
@property (nonatomic, weak) ZWJCommentView *commentView;
@property (nonatomic, weak) ZWJBottomView *bottomView;

@end


@implementation ZWJTopicCell


// Cell比较特殊,通过initWithStyle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]]];
        
        //设置顶部view的内容,设置TopView高度m,设置cell的尺寸
        //顶部
        ZWJTopTopicView *topView = [ZWJTopTopicView ViewForXib];
        [self.contentView addSubview:topView];
        self.topView = topView;
        //中间(视频,声音,图片)
        
        
        //图片
        ZWJPictureTopicView *pictureView = [ZWJPictureTopicView ViewForXib];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
        //视频
        //ZWJVideoTopicView *videoView = [ZWJVideoTopicView ViewForXib];
        //[self.contentView addSubview:video];
        //self.video = video;
        
        //声音
        //ZWJVoiceTopicView *VoiceView = [ZWJVoiceTopicView ViewForXib];
        //[self.contentView addSubview:Voice];
        //self.Voice = Voice;
        
        //最热评论
//        ZWJCommentView *commentView = [ZWJCommentView ViewForXib];
//        [self.contentView addSubview:commentView];
//        self.commentView = commentView;
        
        //底部
        
        ZWJBottomView *bottomView = [ZWJBottomView ViewForXib];
        [self.contentView addSubview:bottomView];
        self.bottomView = bottomView;
    }
    
    return self;
    
}


- (void)setVm:(ZWJTopicViewModel *)vm{
    _vm = vm;
    
    //顶部View
    self.topView.item = vm.item;
    self.topView.frame = vm.topViewFrame;
    
    //中间View
    if (vm.item.type == ZWJTopicItemTypePicture) {
        self.pictureView.item = vm.item;
        self.pictureView.frame = vm.middleViewFrame;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = NO;
        self.VoiceView.hidden = YES;
    }else if (vm.item.type == ZWJTopicItemTypeVideo){
        self.videoView.item = vm.item;
        self.videoView.frame = vm.middleViewFrame;
        
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.VoiceView.hidden = YES;
    }else if (vm.item.type == ZWJTopicItemTypeVocie){
        
        self.VoiceView.item = vm.item;
        self.VoiceView.frame = vm.middleViewFrame;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.VoiceView.hidden =NO;
    }else {
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.VoiceView.hidden =YES;
    }
    
    //设置最热评论
    if (vm.item.topComment) {
        _commentView.hidden = NO;
        self.commentView.item = vm.item;
        self.commentView.frame = vm.middleViewFrame;
        
    }else {
        _commentView.hidden = YES;
    }
    
    //设置底部View
    self.bottomView.item = vm.item;
    self.bottomView.frame = vm.bottomViewFrame;
    
    
}

- (void)setItem:(ZWJTopicItem *)item{
    
    _item = item;
    _topView.item = item;
    
    self.topView.frame = CGRectMake(10, 0, 355,75);
    self.pictureView.frame = CGRectMake(10, 120, 355, 200);
    self.bottomView.frame = CGRectMake(10, 400, 355, 35);
    
}




@end
