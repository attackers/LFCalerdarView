//
//  LFCalendarValueInfo.m
//  LFCalendar
//
//  Created by lifu on 16/3/30.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "LFCalendarValueInfo.h"
@implementation LFCalendarValueInfo

+ (NSInteger)getHowManyDaysInMonth:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSInteger)getHowManyWeekInMonth:(NSDate*)date
{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSInteger)getTodayInWeekAndInMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    NSDateComponents *compon = [calendar components:unitFlags fromDate:[NSDate date]];
    return compon.weekday;
}

+ (NSInteger)getDayInWeekAndInMonth:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    NSDateComponents *compon = [calendar components:unitFlags fromDate:date];
    return compon.weekday;
}

+ (NSInteger)getWeekInMonth:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    NSDateComponents *compon = [calendar components:unitFlags fromDate:date];
    return compon.weekOfMonth;
}

+ (NSInteger)getFirstDayInWeekDays:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    NSDateComponents *compon = [calendar components:unitFlags fromDate:date];
    
    NSString *dateStg = [NSString stringWithFormat:@"%lu-%02lu-01 12:00:00",compon.year,compon.month];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *monthFirstDay = [dateFormatter dateFromString:dateStg];
    
    NSCalendar *firestCalendar = [NSCalendar currentCalendar];
    NSDateComponents *value = [firestCalendar components:unitFlags fromDate:monthFirstDay];
    
    return value.weekday - 1;
}

+ (NSInteger)getLastDayInWeekDays:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    NSDateComponents *compon = [calendar components:unitFlags fromDate:date];
    
    NSInteger days = [self getHowManyDaysInMonth:date];
    
    NSString *dateStg = [NSString stringWithFormat:@"%lu-%02lu-%02lu 12:00:00",compon.year,compon.month,days];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *monthFirstDay = [dateFormatter dateFromString:dateStg];
    
    NSDateComponents *value = [calendar components:unitFlags fromDate:monthFirstDay];
    return value.weekday;
}

+ (NSInteger)getHowManyDaysInBeforeMonth:(NSDate*)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    NSDateComponents *compon = [calendar components:unitFlags fromDate:date];
    
    NSInteger year,month;
    if (compon.month == 1) {
        year = compon.year - 1;
        month = 12;
    }else{
        year = compon.year;
        month = compon.month -1;
    }
    
    NSString *dateStg = [NSString stringWithFormat:@"%lu-%02lu-10 12:00:00",year,month];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beforeMonthDays = [dateFormatter dateFromString:dateStg];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:beforeMonthDays];
    return range.length;
}

@end
