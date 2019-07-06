//
//  SNTool.m
//  sdk-demo
//
//  Created by User on 16/3/29.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNTool.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "sys/utsname.h"

@implementation SNTool

+ (NSString *)SSID {
    
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count]) {
            break;
        }
    }
    NSString *ssid = info[@"SSID"];
//    if (!ssid.length) {
//        ssid = @"NETGEAR57";
//    }
    return ssid;
}
+(NSString *)jsontringData:(id)data{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    
    return mutStr;
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}
//编码问题
+(NSString*)DataTOjsonString:(id)object{
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
+ (NSString *)getDeviceModel {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone_1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone_3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone_3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone_4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon_iPhone_4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone_4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone_5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone_5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone_5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone_5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone_5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone_5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone_6_P";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone_6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone_6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone_6s_P";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone_7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone_7_P";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod_1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod_2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod_3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod_4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod_5G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad_2_WiFi";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad_2_GSM";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad_2_CDMA";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad_2_32nm";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad_mini_WiFi";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad_mini_GSM";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad_mini_CDMA";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad_3_WiFi";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad_3_CDMA";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad_3_4G";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad_4_WiFi";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad_4_4G";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad_4_CDMA";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad_Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad_Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad_Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad_Air_2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad_Air_2";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    // iPad
    if ([deviceString isEqualToString:@"iPad4,4"]||[deviceString isEqualToString:@"iPad4,5"]||[deviceString isEqualToString:@"iPad4,6"]) return @"iPad_mini_2";
    if ([deviceString isEqualToString:@"iPad4,7"]||[deviceString isEqualToString:@"iPad4,8"]||[deviceString isEqualToString:@"iPad4,9"])  return @"iPad_mini_3";
    
    return deviceString;
}

+ (NSString *)getNetWorkStates{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *children;
    if([[application valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        children = [[[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    } else{
        children = [[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }
   
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}
+(NSString *)StringTimeFormat:(NSString *)format
{
    NSTimeInterval interval    =[format doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

///< 获取当前时间的: 前一周(day:-7)丶前一个月(month:-30)丶前一年(year:-1)的时间戳
+ (NSString *)ddpGetExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    ///< 当前时间
    NSDate *currentdata = [NSDate date];
    
    ///< NSCalendar -- 日历类，它提供了大部分的日期计算接口，并且允许您在NSDate和NSDateComponents之间转换
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    /*
     ///<  NSDateComponents：时间容器，一个包含了详细的年月日时分秒的容器。
     ///< 下例：获取指定日期的年，月，日
     NSDateComponents *comps = nil;
     comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentdata];
     NSLog(@"年 year = %ld",comps.year);
     NSLog(@"月 month = %ld",comps.month);
     NSLog(@"日 day = %ld",comps.day);*/
    
    
    NSDateComponents *datecomps = [[NSDateComponents alloc] init];
    [datecomps setYear:year?:0];
    [datecomps setMonth:month?:0];
    [datecomps setDay:day?:0];
    
    ///< dateByAddingComponents: 在参数date基础上，增加一个NSDateComponents类型的时间增量
    NSDate *calculatedate = [calendar dateByAddingComponents:datecomps toDate:currentdata options:0];
    
    ///< 打印推算时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *calculateStr = [formatter stringFromDate:calculatedate];
    
    NSLog(@"calculateStr 推算时间: %@",calculateStr );
    
    ///< 预期的推算时间
//    NSString *result = [NSString stringWithFormat:@"%ld", (long)[calculatedate timeIntervalSince1970]];
    
    return calculateStr;
}
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    //获取系统当前时间
//    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
//    //需要转换的字符串
//    NSString *dateString = @"2015-06-26 08:08:08";
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    return date;
}
+(NSString *)yearMonthTimeFormat:(NSString *)format
{
    NSTimeInterval interval    =[format doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}
+(NSString *)currenTime
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    return nowStr;
}
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    label.attributedText = str;
}
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}
///< 获取当前时间的: 前一周(day:-7)丶前一个月(month:-30)丶前一年(year:-1)的时间戳
+ (NSString *)laterGetExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    ///< 当前时间
    NSDate *currentdata = [NSDate date];
    
    ///< NSCalendar -- 日历类，它提供了大部分的日期计算接口，并且允许您在NSDate和NSDateComponents之间转换
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    /*
     ///<  NSDateComponents：时间容器，一个包含了详细的年月日时分秒的容器。
     ///< 下例：获取指定日期的年，月，日
     NSDateComponents *comps = nil;
     comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentdata];
     NSLog(@"年 year = %ld",comps.year);
     NSLog(@"月 month = %ld",comps.month);
     NSLog(@"日 day = %ld",comps.day);*/
    
    
    NSDateComponents *datecomps = [[NSDateComponents alloc] init];
    [datecomps setYear:year?:0];
    [datecomps setMonth:month?:0];
    [datecomps setDay:day?:0];
    
    ///< dateByAddingComponents: 在参数date基础上，增加一个NSDateComponents类型的时间增量
    NSDate *calculatedate = [calendar dateByAddingComponents:datecomps toDate:currentdata options:0];
    
    ///< 打印推算时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *calculateStr = [formatter stringFromDate:calculatedate];
    
    NSLog(@"calculateStr 推算时间: %@",calculateStr );
    
    ///< 预期的推算时间
    //    NSString *result = [NSString stringWithFormat:@"%ld", (long)[calculatedate timeIntervalSince1970]];
    
    return calculateStr;
}

// 读取本地JSON文件
+ (NSArray *)readLocalFileWithName:(NSString *)name {
//    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];;
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
//    NSString *string = [[NSString alloc] initWithContentsOfFile:imagePath encoding:NSUTF8StringEncoding error:nil];
//    NSData * resData = [[NSData alloc]initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
//    return [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
}
@end
