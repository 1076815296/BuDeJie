//
//  NSDate+Date.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/11.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate (Date)

- (BOOL)isThisYear {
  
    //获取年份 日历对象 (获取日历组件)
    //获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
   
    //获取调用者日期年份
    NSDateComponents *createCmp =[calendar components:NSCalendarUnitYear fromDate:self];
    
    //拿着当前的时间与当前时间对比
    NSDate *curDate = [NSDate date];
    //当前日期对象
    NSDateComponents *curCmp =[calendar components:NSCalendarUnitYear fromDate:curDate];
    
    
    return createCmp.year == curCmp.year;
    
}

- (BOOL)isThiToday{
    
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar isDateInToday:self];
    
}

- (BOOL)isThisYesterday{
    
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar isDateInYesterday:self];
    
}

- (NSDateComponents *)datelWithNow{
    
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return  [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute ) fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
    
    
}



@end
