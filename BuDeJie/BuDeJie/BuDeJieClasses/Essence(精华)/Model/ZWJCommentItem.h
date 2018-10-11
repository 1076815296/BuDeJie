//
//  ZWJCommentItem.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/11.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZWJUserItem;
@interface ZWJCommentItem : NSObject

@property (nonatomic,strong) NSString *voiceurl;
@property (nonatomic,strong) NSString *voicetime;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) ZWJUserItem *user;

@property (nonatomic,strong) NSString *totalContent;

@end

NS_ASSUME_NONNULL_END
