//
//  ZWJTagCell.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/7.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZWJSubTagItem;
@interface ZWJTagCell : UITableViewCell

@property (nonatomic, strong) ZWJSubTagItem *item;

+ (instancetype)cell;

@end

NS_ASSUME_NONNULL_END
