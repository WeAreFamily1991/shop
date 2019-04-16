//
//  SNTool.h
//  sdk-demo
//
//  Created by User on 16/3/29.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SNTool : NSObject

/**
 *  获取当前网络的SSID
 */
+ (NSString *)SSID;

/**
 *  获取系统设备型号
 */
+ (NSString *)getDeviceModel;

/**
 *  获取网络状态
 */
+ (NSString *)getNetWorkStates;

+(NSString *)jsontringData:(id)data;
+(NSString*)DataTOjsonString:(id)object;
+(NSString *)convertToJsonData:(NSDictionary *)dict;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)string;
+(NSString *)StringTimeFormat:(NSString *)format;
+(NSString *)yearMonthTimeFormat:(NSString *)format;
///< 获取当前时间的: 前一周(day:-7)丶前一个月(month:-30)丶前一年(year:-1)的时间戳
+ (NSString *)ddpGetExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
+(NSString *)currenTime;
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;
+ (int)getRandomNumber:(int)from to:(int)to ;
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
+ (NSString *)laterGetExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
@end
