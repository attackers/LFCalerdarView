//
//  DateObject.m
//  webview
//
//  Created by lifu on 16/1/19.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "DateObject.h"

@implementation DateObject
+ (NSString*)stringFromString:(NSString *)dateString  showStyle:(ShowDateStyle)style
{
    
    
    NSDate *dateValue = [DateObject  dateForString:dateString];
    
    
    NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    
    switch (style) {
        case showMD_style:
        {
            [dateF setDateFormat:@"MM-dd"];

        }
            break;
        case showTM_style:
        {
            [dateF setDateFormat:@"HH:mm"];

        }
            break;
        case showMDTM_style:
        {
            [dateF setDateFormat:@"MM-dd HH:mm"];

        }
            break;
        case showYM_style:
        {
            [dateF setDateFormat:@"yyyy-MM"];

        }
            break;
        case showYMDTM_style:
        {
            [dateF setDateFormat:@"yyyy-MM-dd HH:mm"];

        }
            break;
        case showYMDTMS_style:
        {
            [dateF setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        }
            break;

        default:
            break;
    }
    
    NSString *datestg = [dateF stringFromDate:dateValue];
    
    
    
    return datestg;


}

+ (NSDate*)dateForString:(NSString*)stg
{
    NSString *stgS = @"^(([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2}))+";
    NSRange range = [stg rangeOfString:stgS options:NSRegularExpressionSearch];
    
    if (range.location>19) {
        
        stg = [stg stringByAppendingString:@":00"];
    }
    
    NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    [dateF setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateValue = [dateF dateFromString:stg];
    return dateValue;
}

+ (NSString*)stringForDate:(NSDate*)date
{
    
    NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    [dateF setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestg = [dateF stringFromDate:date];
    return datestg;
}
+ (NSDictionary*)stringCalendarFromString:(NSString*)dateString
{
    NSMutableDictionary *dateDic = [NSMutableDictionary dictionary];

    NSDate *date = [self dateForString:dateString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekOfYear;
  NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];

    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.year] forKey:@"year"];
    [dateDic setObject:[NSString stringWithFormat:@"%@",[self returnWeekDayStg:(long)dateComponents.weekday]] forKey:@"weekDay"];
    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.month] forKey:@"month"];
    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.day] forKey:@"day"];
    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.hour] forKey:@"hour"];
    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.minute] forKey:@"minute"];
    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.second] forKey:@"second"];
    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.weekOfMonth] forKey:@"weekOfMonth"];
    [dateDic setObject:[NSString stringWithFormat:@"%lu",(long)dateComponents.weekOfYear] forKey:@"weekOfYear"];
    return dateDic;
}
+ (NSString*)returnWeekDayStg:(NSInteger)weekday
{
    switch (weekday) {
        case 1:
        {
            return @"星期天";
        }
            break;
        case 2:
        {
            return @"星期一";

        }
            break;
        case 3:
        {
            return @"星期二";

        }
            break;
        case 4:
        {
            return @"星期三";

        }
            break;
        case 5:
        {
            return @"星期四";

        }
            break;
        case 6:
        {
            return @"星期五";

        }
            break;
        case 7:
        {
            return @"星期六";

        }
            break;
        default:
            break;
    }
    return nil;
}
+ (NSString*)dateToDate:(NSDate*)date toDate:(NSDate*)toDate
{
    NSString *dateStg;

    NSString *stg = [DateObject stringForDate:date];
    NSDictionary *dateDic = [DateObject stringCalendarFromString:stg];
    
    NSString *currentDate = [DateObject stringForDate:[NSDate date]];
    NSDictionary *currentDateDic = [DateObject stringCalendarFromString:currentDate];
    dateStg = [NSString stringWithFormat:@"%@-%@-%@",[dateDic objectForKey:@"year"],[dateDic objectForKey:@"month"],[dateDic objectForKey:@"day"]];
    
    NSInteger currentYear = [[currentDateDic objectForKey:@"year"]integerValue];
    NSInteger dateYear = [[dateDic objectForKey:@"year"]integerValue];
    if (currentYear - dateYear > 0) {
        return [self stringFromString:[self stringForDate:date] showStyle:showYMDTM_style];
    }
    
    NSString* dateWeek = [dateDic objectForKey:@"weekDay"];

    
    NSInteger currentDay = [[currentDateDic objectForKey:@"day"]integerValue];
    NSInteger dateDay = [[dateDic objectForKey:@"day"]integerValue];
    if (currentDay - dateDay > 0) {
        
        return [self stringFromString:[self stringForDate:date] showStyle:showYMDTM_style];
    }
    
    NSInteger currentHour = [[currentDateDic objectForKey:@"hour"]integerValue];
    NSInteger dateHour = [[dateDic objectForKey:@"hour"]integerValue];
    if (currentHour - dateHour > 0) {
        return [NSString stringWithFormat:@"%lu小时前",(long)(currentHour - dateHour)];

    }
    NSInteger currentMinute = [[currentDateDic objectForKey:@"minute"]integerValue];
    NSInteger dateMinuter = [[dateDic objectForKey:@"minute"]integerValue];
    return [NSString stringWithFormat:@"%lu分钟前",(long)(currentMinute - dateMinuter)];

}

+ (NSString*)objectForDic:(NSDictionary*)aDic Key:(NSString*)akey
{
    if ([aDic objectForKey:akey]) {
        
        if ([[aDic objectForKey:akey]isKindOfClass:[NSNull class]]) {
            
            return @" ";

        }
        NSString *stg = [NSString stringWithFormat:@"%@",[aDic objectForKey:akey]];
        return stg;
    }
    return @" ";
}

+ (NSString *)htmlStringFilter:(NSString*)docContent
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"&lt;"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"&gt;"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"&amp;"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"&nbsp;"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"&quot;"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"&qpos;"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"&qpos;" withString:@"'"];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"\n"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"\t"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
    }
    
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"\r"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        
    }
    
    return docContent;
    
}
+ (NSString*)htmlESCFilter:(NSString *)docContent
{
    NSPredicate*  predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"\\"];
    while ([predicate evaluateWithObject:docContent]) {
        
        docContent = [docContent stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
    }
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"\n"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    return docContent;
    
}

+ (NSString*)htmlDoubleQuotationMarksFilter:(NSString *)docContent
{
    
    NSPredicate*  predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"\""];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    }
    predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"'"];
    while ([predicate evaluateWithObject:docContent]) {
        docContent = [docContent stringByReplacingOccurrencesOfString:@"'" withString:@"&qpos;"];
    }
    return docContent;
}

@end
