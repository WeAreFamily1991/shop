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
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
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

@end
