//
//  DateObject.h
//  webview
//
//  Created by lifu on 16/1/19.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,ShowDateStyle) {
    /**
     *  只显示月、日
     */
    showMD_style,
    /**
     *  只显示小时和分钟
     */
    showTM_style,
    /**
     *  只显示年、月
     */
    showYM_style,
    /**
     *  只显示月、日、小时、分钟
     */
    showMDTM_style,
    /**
     *  只显示年、月、日、小时、分钟
     */
    showYMDTM_style,
    /**
     *  显示年、月、日、小时、分钟、秒
     */
    showYMDTMS_style
};
@interface DateObject : NSObject
/**
 *  转换日期字符显示
 *
 *  @param dateString 需要转换的日期字符
 *  @param style      需要转换后显示的样式，使用枚举ShowDateStyle
 *
 *  @return 返回要显示的样式字条
 */
+ (NSString*)stringFromString:(NSString *)dateString  showStyle:(ShowDateStyle)style;
/**
 *  将字符转换成日期
 *
 *  @param stg 所要转换的日期数据
 *
 *  @return 返回日期
 */
+ (NSDate*)dateForString:(NSString*)stg;
/**
 *  将日期转换成字符
 *
 *  @param date 所要转换的日期数据
 *
 *  @return 返回日期形字符串
 */
+ (NSString*)stringForDate:(NSDate*)date;
/**
 *  返回一个字典，里面包含日期为周几，年、月、日、时、分、秒
 *
 *  @param dateString 需要进行转换的时间格式字符
 *
 *  @return 返回字典
 */
+ (NSDictionary*)stringCalendarFromString:(NSString*)dateString;
/**
 *  返回周几
 *
 *  @param weekday 第几天
 *
 *  @return 返回周期字符
 */
+ (NSString*)returnWeekDayStg:(NSInteger)weekday;
/**
 *  处理字典key不存在，或者value为空
 *
 *  @param aDic 字典
 *  @param akey 键值
 *
 *  @return 返回字符
 */
+ (NSString*)objectForDic:(NSDictionary*)aDic Key:(NSString*)akey;
/**
 * 日期相减
 *
 *  @param date   起止日期
 *  @param toDate 结束日期
 *
 *  @return 返回NSDateComponents类型，通过相关方法可以获取时间value
 */
+ (NSString*)dateToDate:(NSDate*)date toDate:(NSDate*)toDate;
/**
 *  需要过滤的html，将html里面的代字符串更改成相应的符号
 *
 *  @param docContent 需要过滤的html字符串
 *
 *  @return 返回过滤后的字符串
 */
+ (NSString *)htmlStringFilter:(NSString*)docContent;
/**
 * 转换双引号
 *
 *  @param docContetn 需要转换的字符串
 *
 *  @return 返回转换过后的字符串
 */
+ (NSString *)htmlDoubleQuotationMarksFilter:(NSString*)docContent;
/**
 *  转义字符过滤
 *
 *  @param docContent 需要转换的字符串
 *
 *  @return 返回转换过后的字符串
 */
+ (NSString*)htmlESCFilter:(NSString *)docContent;
@end
