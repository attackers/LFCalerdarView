//
//  LFCalendarValueInfo.h
//  LFCalendar
//
//  Created by lifu on 16/3/30.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFCalendarValueInfo : NSObject
/**
 *  获取最后一天是周几
 *
 *  @param date 需要查询的日期数据
 *
 *  @return 返回是本周第几天
 */
+ (NSInteger)getLastDayInWeekDays:(NSDate*)date;
/**
 *  获取第一天是周几
 *
 *  @param date 需要查询的日期数据
 *
 *  @return 返回是本周第几天
 */
+ (NSInteger)getFirstDayInWeekDays:(NSDate*)date;
/**
 *  获取当月有几周
 *
 *  @param date  需要查询的日期数据
 *
 *  @return 返回本月有几周
 */
+ (NSInteger)getWeekInMonth:(NSDate*)date;
/**
 *  获取指定日期是周几
 *
 *  @param date 需要查询的日期数据
 *
 *  @return 返回指定日期是周几，按照西方数据返回，即：1为周日
 */
+ (NSInteger)getDayInWeekAndInMonth:(NSDate*)date;
/**
 *  获取当天是周几
 *
 *  @return 返回当天是周几，按照西方数据返回，即：1为周日
 */
+ (NSInteger)getTodayInWeekAndInMonth;
/**
 *  获取指定月有几周
 *
 *  @param date 需要查询的日期数据
 *  @return 返回指定月有几周
 */
+ (NSInteger)getHowManyWeekInMonth:(NSDate*)date;
/**
 *  获取指定月有几天
 *
 *  @param date 需要查询的日期数据
 *  @return 返回指定月有几天
 */
+ (NSInteger)getHowManyDaysInMonth:(NSDate*)date;
/**
 *  获取指定月的前一个月里有几天
 *
 *  @param date 需要查询的日期数据
 *
 *  @return 返回指定月有几天
 */
+ (NSInteger)getHowManyDaysInBeforeMonth:(NSDate*)date;
@end
