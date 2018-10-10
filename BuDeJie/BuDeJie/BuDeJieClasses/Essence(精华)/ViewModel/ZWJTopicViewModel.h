//
//  ZWJTopicViewModel.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ZWJTopicItem;
@interface ZWJTopicViewModel : NSObject

@property (nonatomic, strong) ZWJTopicItem *item;


@property (nonatomic, assign) CGRect topViewFrame;
@property (nonatomic, assign) CGRect middleViewFrame;
@property (nonatomic, assign) CGFloat cellH;


@end

NS_ASSUME_NONNULL_END
