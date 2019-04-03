//
//  NetworkConstants.h
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//


/*
 * 此文件中定义所有网络请求时所用到的常量，与 Constants.h 一样，内容都是常量，只是为了方便管理，单独提取出来的
 * 包括：
 * 1、服务器地址（开发环境和线上环境）
 * 2、所有 API 的名称
 * 3、状态码（枚举类型）
 */


#ifndef NetworkConstants_h
#define NetworkConstants_h

#pragma mark - ServerRoot
// 开发环境
#define DEBUGSERVER_ROOT             @"192.168.31.133:8081"
#define DEBUGAPI_ROOT                [NSString stringWithFormat:@"http://%@/santie-restful/", DEBUGSERVER_ROOT]

 // 线上环境
#define SERVER_ROOT             @"192.168.31.195:8081"
#define RELEASEAPI_ROOT                [NSString stringWithFormat:@"http://%@/", SERVER_ROOT]
#pragma mark - 状态码
typedef NS_ENUM(NSUInteger, NetWorkStatus) {
    NetWorkStatusSuccess = 200, // 请求成功
    NetWorkStatusFail = -1, // 请求失败
};

#pragma mark - API
// 获取游客的 token
static NSString * const API_GuestToken                          = @"token/getToken";

#pragma mark - 首页接口
// 新闻通知
static NSString * const API_News                                = @"mainPage/news";
// 新品推荐
static NSString * const API_NewRecommend                        = @"mainPage/newRecommend";
// 卖家推荐
static NSString * const API_SellerRecommend                     = @"mainPage/sellerRecommend";
// 商品分类
static NSString * const API_ItemCagetory                        = @"mainPage/itemCagetory";
static NSString * const DRLogoutNotification                    = @"DRLogoutNotification";
#endif /* NetworkConstants_h */
