//
//  NSDate+Date.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/11.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Date)

/**判断是否是今年*/
- (BOOL)isThisYear;

/**判断是否是今天*/
- (BOOL)isThiToday;

/**判断是否是昨天*/
- (BOOL)isThisYesterday;


/**获取时间差值*/
- (NSDateComponents *)datelWithNow;


@end

NS_ASSUME_NONNULL_END
