//
//  SNNetworking.m
//  sdk-demo
//
//  Created by User on 16/3/19.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNNetworking.h"
#import "AFNetworking.h"
#import "SNLog.h"
#import "SNAPI.h"
#import "MJExtension.h"
#import "SNAPIManager.h"

#import "NSObject+SN.h"

@implementation SNNetworking

#pragma mark - POST请求方法

+ (void)postURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager POST:url parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf printError:error url:url parameters:paramers];
        
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark - delete请求方法

+ (void)deleteURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager DELETE:url parameters:paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf printError:error url:url parameters:paramers];
        
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)postURL:(NSString *)url parameters:(NSDictionary *)paramers formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager POST:url parameters:paramers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (SNFormData *data in formDataArray){
            [formData appendPartWithFileData:data.fileData name:data.name fileName:data.fileName mimeType:data.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf printError:error url:url parameters:paramers];
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - GET请求方法

+ (void)getURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:url parameters:paramers progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf printError:error url:url parameters:paramers];
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 打印

+ (NSString *)spliceUrlWithUrl:(NSString *)url parameters:(NSDictionary *)params {
    
    NSString *requestStr=[NSString stringWithFormat:@"%@?",url];
    NSArray *keys = [params allKeys];
    for (int i = 0; i < keys.count; i ++) {
        NSString *key = keys[i];
        if (i == 0) {
            requestStr = [NSString stringWithFormat:@"%@%@=%@",requestStr,key,params[key]];
        } else {
            requestStr = [requestStr stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,params[key]]];
        }
    }
    
    return requestStr;
}

+ (void)printResponse:(id)response url:(NSString *)url parameters:(NSDictionary *)params {
    
    if (![SNAPIManager shareAPIManager].isShowLog) {
        return;
    }
    
    NSString *responseStr = [[response mj_JSONObject] descriptionUTF8];
//    NSString *responseStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSString *urlStr = [self spliceUrlWithUrl:url parameters:params];
    
    [SNLog log:@"\nURL:\n%@\n收到：\n%@", urlStr, responseStr];
}

+ (void)printError:(NSError *)error url:(NSString *)url parameters:(NSDictionary *)params {
    
    if (![SNAPIManager shareAPIManager].isShowLog) {
        return;
    }
    
    NSString *urlStr = [self spliceUrlWithUrl:url parameters:params];
    
    [SNLog log:@"\nURL:\n%@\n错误：\n%@", urlStr, error];
}

#pragma mark - 检测换票
+ (void)cheakTokenWithResponse:(id)response {
    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
    id dict = [response mj_JSONObject];
    
    if ([dict isKindOfClass:[NSDictionary class]]) {

        if ([[NSString stringWithFormat:@"%@",dict[@"state"]] isEqualToString:@"10003"]) {
            [SNAPI userRefreshTokenSuccess:^{
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
}

@end

@implementation SNFormData


@end

