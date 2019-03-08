//
//  Constants.h
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//


/*
 * 此文件中定义项目中使用到的常量（除网络请求时所用到的常量）
 * 包括：
 * 1、一些宏定义，以及宏定义的方法
 * 2、使用第三方库时用到的 key
 * 3、全局使用的通知名
 */

#ifndef Constants_h
#define Constants_h

#pragma mark - ThirdPartyAppIDAndKey

#pragma mark - Key
static NSString * const kUserIsLogin = @"kUserIsLogin";
static NSString * const kCurrentUserToken = @"kCurrentUserToken";
static NSString * const kCurrentUserName = @"kCurrentUserName";

//日至输出
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow
//判断设备是否为iphoneX
#define DCIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#pragma mark - 通知名称
// 登录状态变化通知
static NSString * const kLoginStatusChange = @"kLoginStatusChange";
// 游客登录成功通知
static NSString * const kGuestLoginStatusChange = @"kGuestLoginStatusChange";
//国际化输入
#define SNStandardString(key)   [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:@"SNStandardString"]

#pragma mark - Macro
// Block相关的强/弱引用
#define DRWeakSelf __weak typeof(self) weakSelf = self
#define StrongObj(o) __strong typeof(o) o = o##Weak;

// 屏幕比例系数
#define ScreenScale [UIApplication sharedApplication].keyWindow.screen.scale

// 屏幕宽高
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define HScale(v) v / 667. * SCREEN_HEIGHT //高度比
#define WScale(w) w / 375. * SCREEN_WIDTH //宽度比
#define ScreenBounds [[UIScreen mainScreen] bounds]
#define DRTopHeight (DRStatusBarHeight + 44)
#define DRTabBarHeight self.tabBarController.tabBar.frame.size.height
#define DRStatusBarHeight UIApplication.sharedApplication.statusBarFrame.size.height

// 以 iPhone6 屏幕为标准，按比例计算宽度
#define WidthScale(width) width/750.0*SCREEN_WIDTH

// 字体
#define DR_FONT(__fontsize__) [UIFont systemFontOfSize:__fontsize__]
#define DR_BoldFONT(__fontsize__) [UIFont boldSystemFontOfSize:__fontsize__]
#define BoldFont(size)                  [UIFont boldSystemFontOfSize:FontSize(size)]
#define FontWithWeight(size, fontWeight)    [UIFont systemFontOfSize:FontSize(size) weight:fontWeight]

// 是否是 iPhoneX 及以上机型（以状态栏的高度来判断）
#define IsiPhoneXOrLater CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) >= 44.0

// 根据 RGB 生成 UIColor 对象
#define KTextColor              RGB(67, 67, 67)

#define BACKGROUNDCOLOR         RGBHex(0XF3F5F7)
#define RGB(R, G, B)            [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define RGBA(R, G, B, A)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGBHex(s)               [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0xFF00) >>8))/255.0 blue:((s&0xFF))/255.0 alpha:1.0]
#define RGBAHex(s, A)           [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0xFF00) >>8))/255.0 blue:((s&0xFF))/255.0 alpha:A]
#define JDColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//
#ifdef DEBUG
    #define STLog(...) NSLog(__VA_ARGS__)
#else
    #define STLog(...)
#endif
//PNG JPG 图片路径
#define PNGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME,EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

//加载图片
#define PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMAGENAMED(NAME)       [UIImage imageNamed:NAME]
//DEFAULTS
#define DEFAULTS [NSUserDefaults standardUserDefaults]
#pragma mark - 公共方法
/**
 根据16进制字符串返回 UIColor
 
 @param str 颜色的 16 进制字符串
 @return UIColor
 */
static inline UIColor * ColorWithHexString(NSString *str){
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


/**
 计算字体大小，以 iPhone6 屏幕为标准，如果屏幕大于 4.5，以 4.5 标准计算，如果屏幕小于 4.5，等比例缩小

 @param size UI 设计的字体大小
 */
static inline CGFloat FontSize (CGFloat size) {
    CGFloat screenW = SCREEN_WIDTH > 375.0 ? 375.0 : SCREEN_WIDTH;
    CGFloat finalSize = size / 750.0 * screenW;
    
    return finalSize;
}

#endif /* Constants_h */
