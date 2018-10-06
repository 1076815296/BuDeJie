//
//  ZWJADItem.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/6.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWJADItem : NSObject

//为什么使用strong
@property (nonatomic, strong) NSString *w_picurl;
@property (nonatomic, strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;


@end

NS_ASSUME_NONNULL_END
