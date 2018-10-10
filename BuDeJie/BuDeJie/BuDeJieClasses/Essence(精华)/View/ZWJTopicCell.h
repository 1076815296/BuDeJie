//
//  ZWJTopicCell.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class ZWJTopicViewModel,ZWJTopicItem;
@interface ZWJTopicCell : UITableViewCell

@property (nonatomic ,strong) ZWJTopicViewModel *vm;

@property (nonatomic ,strong) ZWJTopicItem *item;

@end

NS_ASSUME_NONNULL_END
