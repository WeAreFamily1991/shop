//
//  DRUserInfoModel.m
//  Shop
//
//  Created by 解辉 on 2019/3/2.
//  Copyright © 2019年 SanTie. All rights reserved.
//

#import "DRUserInfoModel.h"
#import "MJExtension.h"

@implementation DRUserInfoModel

//+ (NSDictionary *)mj_objectClassInArray {
//    return @{
//             @"id" : @"user_id"
//             };
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"user_id" : @"id"
             };
}
@end
