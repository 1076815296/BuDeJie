//
//  ZWJBaseTopicView.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZWJTopicItem;
@interface ZWJBaseTopicView : UIView


@property (nonatomic ,strong) ZWJTopicItem *item;

+ (instancetype)ViewForXib;

@end

NS_ASSUME_NONNULL_END
