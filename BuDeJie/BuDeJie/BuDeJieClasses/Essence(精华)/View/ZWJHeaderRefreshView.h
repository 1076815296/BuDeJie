//
//  ZWJHeaderRefreshView.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/12.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN



@interface ZWJHeaderRefreshView : UIView

@property (nonatomic, assign) BOOL isNeedLoad;
@property (nonatomic, assign) BOOL isRefreshing;


+ (instancetype)headerView;

@end

NS_ASSUME_NONNULL_END
