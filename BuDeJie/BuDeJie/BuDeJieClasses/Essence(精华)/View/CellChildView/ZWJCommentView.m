//
//  ZWJCommentView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/11.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJCommentView.h"
#import "ZWJCommentItem.h"
#import "ZWJUserItem.h"
#import "ZWJTopicItem.h"

@interface ZWJCommentView ()
@property (weak, nonatomic) IBOutlet UILabel *totalView;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end

@implementation ZWJCommentView
/*
 以后只要界面没有问题,但是莫名奇妙报一些约束冲突,这时候考虑自动拉伸属性(iOS6)
 */

-(void)awakeFromNib{
    [super awakeFromNib];
    //取消自动拉伸属性
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setItem:(ZWJTopicItem *)item {
    
    [super setItem:item];
    
    if (item.topComment.content.length) {
        //文字
        _voiceView.hidden = YES;
        _totalView.hidden = NO;
        
        _totalView.text= item.topComment.totalContent;
    }else{
        _voiceView.hidden = NO;
        _totalView.hidden = YES;
        
        _nameView.text = item.topComment.user.username;
        [_voiceButton setTitle:item.topComment.voicetime forState:UIControlStateNormal];
    }
    
}

@end
